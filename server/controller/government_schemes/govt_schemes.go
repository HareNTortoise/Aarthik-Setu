package government_schemes

import (
	"encoding/json"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"strconv"

	"github.com/gin-gonic/gin"
)

// Scheme represents the structure of a government scheme
type Scheme struct {
	RelatedScheme      string `json:"relatedScheme"`
	Description        string `json:"description"`
	NatureOfAssistance string `json:"natureOfAssistance"`
	WhoCanApply        string `json:"whoCanApply"`
	HowToApply         string `json:"howToApply"`
}

// LoadSchemes loads the schemes from the JSON file
func LoadSchemes(filename string) ([]Scheme, error) {
	log.Printf("Loading schemes from file: %s", filename)

	jsonData, err := os.ReadFile(filename)
	if err != nil {
		log.Printf("Failed to read file %s: %v", filename, err)
		return nil, err
	}
	log.Printf("Successfully read data from %s", filename)

	var schemes []Scheme
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
		c.JSON(http.StatusOK, []Scheme{}) // Return empty slice if offset is out of range
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
