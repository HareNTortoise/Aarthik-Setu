package gen_ai

import (
	"encoding/json"
	"net/http"

	"github.com/gin-gonic/gin"
)

func AudioFormFiller(c *gin.Context) {
	// Get the audio file
	audioFile, err := c.FormFile("audioFile")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Audio file is required"})
		return
	}

	// Get the form structure JSON
	formStructure := c.PostForm("formFields")
	if formStructure == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Form structure JSON is required"})
		return
	}

	// Parse the form structure JSON
	var formFields map[string]interface{}
	if err := json.Unmarshal([]byte(formStructure), &formFields); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid form structure JSON"})
		return
	}

	// Read the audio file content (if necessary for processing)
	audioFileContent, err := audioFile.Open()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to read audio file"})
		return
	}
	defer audioFileContent.Close()

	// Process the audio file and fill the form
	filledForm, err := FillFormFromAudio(audioFileContent, formFields)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to process audio and fill form"})
		return
	}

	c.JSON(http.StatusOK, filledForm)
}
