package government_schemes

import (
	"encoding/json"
	"net/http"
	"os"

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
	// Use os.ReadFile instead of ioutil.ReadFile
	jsonData, err := os.ReadFile(filename)
	if err != nil {
		return nil, err
	}

	// Unmarshal the JSON data into a slice of Scheme
	var schemes []Scheme
	err = json.Unmarshal(jsonData, &schemes)
	if err != nil {
		return nil, err
	}

	return schemes, nil
}

// GetSchemes is the handler for the /schemes endpoint
func GetGovtSchemes(c *gin.Context) {
	// Load the schemes from the file
	schemes, err := LoadSchemes("govt_schemes.json")
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to read or parse JSON file"})
		return
	}

	// Return the schemes in JSON format
	c.JSON(http.StatusOK, schemes)
}
