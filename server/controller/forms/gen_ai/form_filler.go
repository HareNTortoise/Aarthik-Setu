package gen_ai

import (
	"github.com/gin-gonic/gin"
	"github.com/google/generative-ai-go/genai"
	"context"
	"fmt"
	"net/http"
	"os"
	"google.golang.org/api/option"
	"strings"
	"encoding/json"
	"regexp"
)
func getMimeType(fileName string) string {
    re := regexp.MustCompile(`\.(wav|mp3|aiff|aac|ogg|flac)$`)
    match := re.FindStringSubmatch(fileName)
    if len(match) == 0 {
        return "" // Return empty if no match found
    }

    switch strings.ToLower(match[1]) {
    case "wav":
        return "audio/wav"
    case "mp3":
        return "audio/mp3"
    case "aiff":
        return "audio/aiff"
    case "aac":
        return "audio/aac"
    case "ogg":
        return "audio/ogg"
    case "flac":
        return "audio/flac"
    default:
        return "" // Fallback
    }
}
func AudioFormFiller(c *gin.Context) {
    audioFile, err := c.FormFile("audioFile")
    if err != nil {
        // Handle error if the file is not found or there's an issue
        c.JSON(http.StatusBadRequest, gin.H{"error": "Could not retrieve audio file"})
        return
    }

    // Save the uploaded file temporarily
    tempFilePath := "uploads/" + audioFile.Filename
    if err := c.SaveUploadedFile(audioFile, tempFilePath); err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not save audio file"})
        return
    }
    defer os.Remove(tempFilePath) // Clean up the temporary file after processing

    // Read the saved audio file into memory
    bytes, err := os.ReadFile(tempFilePath)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not read audio file"})
        return
    }

    ctx := context.Background()
    client, err := genai.NewClient(ctx, option.WithAPIKey(os.Getenv("GEMINI_API_KEY")))
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not create API client"})
        return
    }

    model := client.GenerativeModel("gemini-1.5-flash")

   
    fields := c.PostForm("formFields") 
    var requiredFields []string
    if err := json.Unmarshal([]byte(fields), &requiredFields); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid form fields"})
        return
    }

    promptTemplate := fmt.Sprintf("Extract the following information from the audio file:\n%s\n\nPlease analyze the audio and provide the details in json format", 
        strings.Join(requiredFields, ", "))

	mimeType := getMimeType(audioFile.Filename)
    extractionPrompt := []genai.Part{
        genai.Blob{MIMEType: mimeType, Data: bytes}, 
        genai.Text(promptTemplate),
    }

    // Call the model with the audio data and extraction prompt
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
