package schemes

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"
	"path/filepath"
	"github.com/gin-gonic/gin"
	"github.com/go-resty/resty/v2"
	"github.com/pinecone-io/go-pinecone/pinecone"
	"strconv"
	schemes_model "server/models/schemes"
	prompts "server/prompts"
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

func generateAnswer(query string, context string) (string, error) {
	client := resty.New()
	prompt := prompts.GenerateFinancialAdvisorPrompt(query, context)
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

	// Bind the form data to the struct
	if err := c.ShouldBind(&reqBody); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid form data"})
		return
	}

	// Alternatively, if you are manually handling form data, you can do:
	query := c.PostForm("query")

	// Fetching environment variables
	PINECONE_API_KEY := os.Getenv("PINECONE_API_KEY")
	INDEX_NAME := os.Getenv("INDEX_NAME")
	clientParams := pinecone.NewClientParams{
		ApiKey: PINECONE_API_KEY,
	}

	// Creating Pinecone client
	pc, err := pinecone.NewClient(clientParams)
	if err != nil {
		log.Fatalf("Failed to create Client: %v", err)
	}
	ctx := context.Background()

	// Describe the index
	idx, err := pc.DescribeIndex(ctx, INDEX_NAME)
	if err != nil {
		log.Fatalf("Failed to describe index \"%v\": %v", INDEX_NAME, err)
	}

	// Embed the query
	queryVector, err := embedQuery(query)
	if err != nil {
		log.Fatalf("Failed to embed query: %v", err)
	}
	embeddingMap, ok := queryVector["embedding"].(map[string]interface{})
	if !ok {
		log.Fatalf("Failed to extract embedding from response")
	}

	// Extract the values from the embedding
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
		log.Fatalf("Failed to generate answer: %v", err)
	}

	// Return the response as JSON
	c.JSON(200, gin.H{"query": query, "answer": answer})
}


// LoadSchemes loads the schemes from the JSON file
func LoadSchemes(filename string) ([]schemes_model.Scheme, error) {
	log.Printf("Loading schemes from file: %s", filename)

	jsonData, err := os.ReadFile(filename)
	if err != nil {
		log.Printf("Failed to read file %s: %v", filename, err)
		return nil, err
	}
	log.Printf("Successfully read data from %s", filename)

	var schemes []schemes_model.Scheme
	err = json.Unmarshal(jsonData, &schemes)
	if err != nil {
		log.Printf("Failed to unmarshal JSON data: %v", err)
		return nil, err
	}
	log.Printf("Successfully loaded %d schemes", len(schemes))

	return schemes, nil
}

// GetGovtSchemes is the handler for the /govt_schemes endpoint
func GetGovtSchemes(c *gin.Context) {
	log.Println("Received request to get government schemes")

	cwd, err := os.Getwd()
	if err != nil {
		log.Fatalf("Failed to get current working directory: %v", err)
	}
	log.Printf("Current working directory: %s", cwd)

	filePath := filepath.Join(cwd, "schemes.json") // Adjust the path as needed
	log.Printf("Path to JSON file: %s", filePath)

	if _, err := os.Stat(filePath); os.IsNotExist(err) {
		log.Printf("The file does not exist at the specified path: %s", filePath)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "JSON file not found"})
		return
	}

	schemes, err := LoadSchemes(filePath)
	if err != nil {
		log.Printf("Error loading schemes: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to read or parse JSON file"})
		return
	}

	// Get limit and offset from query parameters
	limitStr := c.Query("limit")
	offsetStr := c.Query("offset")

	limit := 10 // Default limit
	offset := 0 // Default offset

	// Parse limit
	if limitStr != "" {
		if l, err := strconv.Atoi(limitStr); err == nil && l > 0 {
			limit = l
		}
	}

	// Parse offset
	if offsetStr != "" {
		if o, err := strconv.Atoi(offsetStr); err == nil && o >= 0 {
			offset = o
		}
	}

	// Apply pagination
	if offset > len(schemes) {
		c.JSON(http.StatusOK, []schemes_model.Scheme{}) // Return empty slice if offset is out of range
		return
	}

	// Slice the schemes for pagination
	end := offset + limit
	if end > len(schemes) {
		end = len(schemes) // Ensure we don't exceed the slice length
	}

	paginatedSchemes := schemes[offset:end]

	// Return the schemes in JSON format
	log.Printf("Returning %d schemes to the client", len(paginatedSchemes))
	c.JSON(http.StatusOK, paginatedSchemes)
}
