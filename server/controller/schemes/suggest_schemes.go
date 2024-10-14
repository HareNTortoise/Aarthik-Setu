package schemes

import (
	"context"
	// "encoding/json"
	"log"
	"net/http"
	"os"
	utils "server/config/firebase"
	model "server/models/forms/personal_forms"
	prompts "server/prompts"
	"strings"

	"cloud.google.com/go/firestore"
	"github.com/gin-gonic/gin"
	"github.com/pinecone-io/go-pinecone/pinecone"
)

var client *firestore.Client


func init() {
	client = utils.InitFirestore()
}


func SuggestSchemeInfo(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()
	// Bind the form data to the struct


	queryDB := client.Collection("personal_loan_applications").
	Where("profileId", "==", profileId).
	Where("applicationId", "==", applicationId).
	Limit(1)
	docs, err := queryDB.Documents(ctx).GetAll()
    if err != nil || len(docs) == 0 {
        c.JSON(http.StatusNotFound, gin.H{"error": "Loan application not found"})
        return
    }

    var loanApplication model.LoanApplication
    if err := docs[0].DataTo(&loanApplication); err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse loan application", "details": err.Error()})
        return
    }

	query := prompts.GenerateSuggestSchemesPrompt(loanApplication);

	// Fetching environment variables
	PINECONE_API_KEY := os.Getenv("PINECONE_API_KEY")
	INDEX_NAME := os.Getenv("INDEX_NAME")
	if PINECONE_API_KEY == "" || INDEX_NAME == "" {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Missing required environment variables"})
		return
	}

	// Creating Pinecone client
	clientParams := pinecone.NewClientParams{ApiKey: PINECONE_API_KEY}
	pc, err := pinecone.NewClient(clientParams)
	if err != nil {
		log.Printf("Failed to create Pinecone client: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Internal server error"})
		return
	}

	// Describe the index
	idx, err := pc.DescribeIndex(ctx, INDEX_NAME)
	if err != nil {
		log.Printf("Failed to describe index \"%v\": %v", INDEX_NAME, err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Internal server error"})
		return
	}

	// Embed the query
	queryVector, err := embedQuery(query)
	if err != nil {
		log.Printf("Failed to embed query: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to embed query"})
		return
	}
	embeddingMap, ok := queryVector["embedding"].(map[string]interface{})
	if !ok {
		log.Printf("Failed to extract embedding from response")
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to extract embedding"})
		return
	}

	// Extract the values from the embedding
	values, ok := embeddingMap["values"].([]interface{})
	if !ok {
		log.Printf("Failed to extract values from embedding")
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to extract embedding values"})
		return
	}

	// Convert values to a slice of float32
	var queryEmbedding []float32
	for _, v := range values {
		if floatVal, ok := v.(float64); ok {
			queryEmbedding = append(queryEmbedding, float32(floatVal))
		} else {
			log.Printf("Unexpected type for embedding value: %T", v)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Invalid embedding value type"})
			return
		}
	}

	// Create an IndexConnection
	idxConnection, err := pc.Index(pinecone.NewIndexConnParams{Host: idx.Host, Namespace: ""})
	if err != nil {
		log.Printf("Failed to create IndexConnection for Host %v: %v", idx.Host, err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Internal server error"})
		return
	}

	// Query by vector values
	res, err := idxConnection.QueryByVectorValues(ctx, &pinecone.QueryByVectorValuesRequest{
		Vector:        queryEmbedding,
		TopK:          3,
		IncludeValues: true,
	})
	if err != nil {
		log.Printf("Error encountered when querying by vector: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to query index"})
		return
	}

	// Fetch and compile context texts
	var contextTexts []string
	for _, match := range res.Matches {
		fetchRes, err := idxConnection.FetchVectors(ctx, []string{match.Vector.Id})
		if err != nil {
			log.Printf("Failed to fetch vector for ID %s: %v", match.Vector.Id, err)
			continue
		}
		if text, ok := fetchRes.Vectors[match.Vector.Id].Metadata.Fields["text"]; ok {
			contextTexts = append(contextTexts, text.GetStringValue())
		}
	}

	// Join the context texts
	context := strings.Join(contextTexts, "\n\n")

	// Generate the answer using the query and context
	answer, err := generateAnswer(query, context)

	if err != nil {
		log.Printf("Failed to generate answer: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to generate answer"})
		return
	}

	answer = strings.ReplaceAll(answer, "`", "")
	// answer = strings.TrimSpace(answer)

	// Return the response directly as JSON
	c.Data(http.StatusOK, "application/json", []byte(answer))
}

