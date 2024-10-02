package schemes

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"log"
	"github.com/pinecone-io/go-pinecone/pinecone"
	"github.com/go-resty/resty/v2"
	"strings"
	"github.com/gin-gonic/gin"
	"net/http"
)


func embedQuery(query string) (map[string]interface{}, error) {
	GEMINI_API_KEY := os.Getenv("GEMINI_API_KEY")
	client := resty.New()
	requestBody := map[string]interface{}{
		"model": "models/embedding-001",
		"content": map[string]interface{}{
			"parts": []map[string]string{
				{"text": query},
			},
		},
	}

	// Make the request to the Google Gemini API to generate embeddings
	res, err := client.R().
		SetHeader("Content-Type", "application/json").
		SetBody(requestBody).
		Post("https://generativelanguage.googleapis.com/v1beta/models/embedding-001:embedContent?key=" + GEMINI_API_KEY)

	if err != nil {
		return nil, err
	}

	// Check for successful response
	if res.StatusCode() != 200 {
		return nil, fmt.Errorf("failed to embed query: %s", res.String())
	}

	var result map[string]interface{}
	err = json.Unmarshal(res.Body(), &result)
	return result, err
}

func generateAnswer(ctx context.Context, query string, context string) (string, error) {
	client := resty.New()
	
	prompt := fmt.Sprintf("You are a financial advisor who has information from a document publically available, issued by the government of India. Give response in a professional manner and dont begin with the statements like \"as a financial advisor...\".:\n\nContext: %s\n\nQuestion: %s\nAnswer:", context, query)

	requestBody := map[string]interface{}{
		"contents": []map[string]interface{}{
			{
				"parts": []map[string]interface{}{
					{"text": prompt},
				},
			},
		},
	}
	GEMINI_API_KEY := os.Getenv("GEMINI_API_KEY")
	res, err := client.R().
		SetQueryParam("key", GEMINI_API_KEY).
		SetHeader("Content-Type", "application/json").
		SetBody(requestBody).
		Post("https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent")

	if err != nil {
		return "", err
	}

	if res.StatusCode() != 200 {
		return "", fmt.Errorf("failed to generate answer: %s", res.String())
	}

	var result map[string]interface{}
	err = json.Unmarshal(res.Body(), &result)
	if err != nil {
		return "", err
	}

	candidates, ok := result["candidates"].([]interface{})
	if !ok || len(candidates) == 0 {
		return "", fmt.Errorf("unexpected response format")
	}

	content, ok := candidates[0].(map[string]interface{})["content"].(map[string]interface{})
	if !ok {
		return "", fmt.Errorf("unexpected content format")
	}

	parts, ok := content["parts"].([]interface{})
	if !ok || len(parts) == 0 {
		return "", fmt.Errorf("unexpected parts format")
	}

	text, ok := parts[0].(map[string]interface{})["text"].(string)
	if !ok {
		return "", fmt.Errorf("unexpected text format")
	}

	return text, nil
}

type QueryRequest struct {
	Query string `json:"query"` // Field to hold the query from the JSON body
}

func ProvideSchemeInfo(c *gin.Context) {
	var reqBody QueryRequest

	// Bind the JSON body to the struct
	if err := c.ShouldBindJSON(&reqBody); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request body"})
		return
	}

	// Use the query from the request body
	query := reqBody.Query
	
	PINECONE_API_KEY := os.Getenv("PINECONE_API_KEY")
	INDEX_NAME := os.Getenv("INDEX_NAME")
	clientParams := pinecone.NewClientParams{
		ApiKey: PINECONE_API_KEY,
	}

	pc, err := pinecone.NewClient(clientParams)
	if err != nil {
		log.Fatalf("Failed to create Client: %v", err)
	} 
	ctx := context.Background()

	idx, err := pc.DescribeIndex(ctx, INDEX_NAME)
	if err != nil {
		log.Fatalf("Failed to describe index \"%v\": %v", INDEX_NAME, err)
	}

	queryVector, err := embedQuery(query)
	if err != nil {
		log.Fatalf("Failed to embed query: %v", err)
	}
	embeddingMap, ok := queryVector["embedding"].(map[string]interface{})
	if !ok {
		log.Fatalf("Failed to extract embedding from response")
	}

	values, ok := embeddingMap["values"].([]interface{})
	if !ok {
		log.Fatalf("Failed to extract values from embedding")
	}

	// Convert values to a slice of float32
	var queryEmbedding []float32
	for _, v := range values {
		if floatVal, ok := v.(float64); ok {
			queryEmbedding = append(queryEmbedding, float32(floatVal))
		} else {
			log.Fatalf("Unexpected type for embedding value: %T", v)
		}
	}

	// Create an IndexConnection
	idxConnection, err := pc.Index(pinecone.NewIndexConnParams{Host: idx.Host, Namespace: ""})
	if err != nil {
		log.Fatalf("Failed to create IndexConnection for Host %v: %v", idx.Host, err)
	}

	// Query by vector values
	res, err := idxConnection.QueryByVectorValues(ctx, &pinecone.QueryByVectorValuesRequest{
		Vector:        queryEmbedding, // Pass the actual embedding values here
		TopK:          3,
		IncludeValues: true,
	})
	if err != nil {
		log.Fatalf("Error encountered when querying by vector: %v", err)
	} 
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

	context := strings.Join(contextTexts, "\n\n")
	// fmt.Println(context)

	answer, err := generateAnswer(ctx, query, context)
	if err != nil {
		log.Fatalf("Failed to generate answer: %v", err)
	}
	c.JSON(200, gin.H{"query": query, "answer": answer})
	// return 
}