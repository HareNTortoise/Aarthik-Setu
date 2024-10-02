package government_schemes

import (
	"encoding/json"
	"log"
	"net/http"
	"os"
	"path/filepath"

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

	// Use os.ReadFile instead of ioutil.ReadFile
	jsonData, err := os.ReadFile(filename)
	if err != nil {
		log.Printf("Failed to read file %s: %v", filename, err)
		return nil, err
	}
	log.Printf("Successfully read data from %s", filename)

	// Unmarshal the JSON data into a slice of Scheme
	var schemes []Scheme
	err = json.Unmarshal(jsonData, &schemes)
	if err != nil {
		log.Printf("Failed to unmarshal JSON data: %v", err)
		return nil, err
	}
	log.Printf("Successfully loaded %d schemes", len(schemes))

	return schemes, nil
}

// GetGovtSchemes is the handler for the /schemes endpoint
func GetGovtSchemes(c *gin.Context) {
	log.Println("Received request to get government schemes")

	// Get the current working directory
	cwd, err := os.Getwd()
	if err != nil {
		log.Fatalf("Failed to get current working directory: %v", err)
	}
	log.Printf("Current working directory: %s", cwd)

	// Define the path to the JSON file relative to the current working directory
	filePath := filepath.Join(cwd, "schemes.json") // Adjust the path as needed
	log.Printf("Path to JSON file: %s", filePath)

	// Check if the file exists
	if _, err := os.Stat(filePath); os.IsNotExist(err) {
		log.Printf("The file does not exist at the specified path: %s", filePath)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "JSON file not found"})
		return
	} else {
		log.Println("The file exists.")
	}

	// Load the schemes from the file
	schemes, err := LoadSchemes(filePath)
	if err != nil {
		log.Printf("Error loading schemes: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to read or parse JSON file"})
		return
	}

	// Log the count of schemes loaded
	log.Printf("Successfully loaded %d schemes", len(schemes))

	// Return the schemes in JSON format
	log.Printf("Returning %d schemes to the client", len(schemes))
	c.JSON(http.StatusOK, schemes)
}
