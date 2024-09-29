package info_extraction

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/google/generative-ai-go/genai"
	"google.golang.org/api/option"
	// "regexp"
)

func GetITRDetails(c *gin.Context) {
	file, err := c.FormFile("file")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Failed to retrieve file"})
		return
	}

	tempFilePath := "uploads/" + file.Filename
	if err := c.SaveUploadedFile(file, tempFilePath); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not save file"})
		return
	}
	defer os.Remove(tempFilePath) // Clean up the temporary file after processing

	// Read the saved audio file into memory
	bytes, err := os.ReadFile(tempFilePath)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not read audio file"})
		return
	}

	client, err := genai.NewClient(context.Background(), option.WithAPIKey(os.Getenv("GEMINI_API_KEY")))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not create GenAI client"})
		return
	}

	model := client.GenerativeModel("gemini-1.5-flash")

	promptTemplate := fmt.Sprintf(`Extract below metrics from the Income Tax Return in Json format (json):
						- Revenue (Turnover)
						- Profit before tax
						- Profit after tax
						- Total Current liabilities
						- Total Cash and cash equivalents
						- Total Long term borrowings
						- Total Trade receivables
						- Total Inventories
						- Tax Paid/Deferred Tax`)

	extractionPrompt := []genai.Part{
		genai.Blob{MIMEType: "application/pdf", Data: bytes},
		genai.Text(promptTemplate),
	}
	ctx := context.Background()
	extractionResp, err := model.GenerateContent(ctx, extractionPrompt...)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error extracting data"})
		return
	}
	for _, ct := range extractionResp.Candidates {
		if ct.Content != nil {
			// Concatenate all parts into a single string
			var output genai.Text
			for _, part := range ct.Content.Parts {
				output += part.(genai.Text)
			}
			outputString := fmt.Sprintf("%v", output)
			// Remove any formatting and parse the JSON
			outputString = strings.TrimPrefix(outputString, "```json\n")
			outputString = strings.TrimSuffix(outputString, "\n```")
			fmt.Println(outputString)
			var extractedData map[string]interface{}
			if err := json.Unmarshal([]byte(outputString), &extractedData); err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "Error parsing extracted JSON"})
				return
			}

			// Return the extracted JSON directly
			c.JSON(http.StatusOK, extractedData)
			return
		}
	}
	c.JSON(http.StatusOK, gin.H{"extractedData": "Done"})
}
