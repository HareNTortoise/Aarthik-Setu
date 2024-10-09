package info_extraction

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strings"
	"time"
	"github.com/gin-gonic/gin"
	"github.com/google/generative-ai-go/genai"
	"google.golang.org/api/option"
	utils "server/config/firebase"
	"cloud.google.com/go/firestore"
	prompts "server/prompts"
)
var db_client *firestore.Client
func init(){
	db_client = utils.InitFirestore()
}

// func GetITRDetails(c *gin.Context) {
// 	file, err := c.FormFileArray("file")
// 	profileId := c.Param("profileId")
// 	applicationId := c.Param("applicationId")
// 	if err != nil {
// 		c.JSON(http.StatusBadRequest, gin.H{"error": "Failed to retrieve file"})
// 		return
// 	}

// 	tempFilePath := "uploads/" + file.Filename
// 	if err := c.SaveUploadedFile(file, tempFilePath); err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not save file"})
// 		return
// 	}
// 	defer os.Remove(tempFilePath) // Clean up the temporary file after processing

// 	// Read the saved audio file into memory
// 	bytes, err := os.ReadFile(tempFilePath)
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not read audio file"})
// 		return
// 	}

// 	client, err := genai.NewClient(context.Background(), option.WithAPIKey(os.Getenv("GEMINI_API_KEY")))
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not create GenAI client"})
// 		return
// 	}

// 	model := client.GenerativeModel("gemini-1.5-flash")

// 	promptTemplate := prompts.GenerateITRPrompt()

// 	extractionPrompt := []genai.Part{
// 		genai.Blob{MIMEType: "application/pdf", Data: bytes},
// 		genai.Text(promptTemplate),
// 	}
// 	ctx := context.Background()
// 	extractionResp, err := model.GenerateContent(ctx, extractionPrompt...)
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error extracting data"})
// 		return
// 	}
// 	for _, ct := range extractionResp.Candidates {
// 		if ct.Content != nil {
// 			var output genai.Text
// 			for _, part := range ct.Content.Parts {
// 				output += part.(genai.Text)
// 			}
// 			outputString := fmt.Sprintf("%v", output)
// 			outputString = strings.TrimPrefix(outputString, "```json\n")
// 			outputString = strings.TrimSuffix(outputString, "\n```")

// 			var extractedData map[string]interface{}
// 			if err := json.Unmarshal([]byte(outputString), &extractedData); err != nil {
// 				c.JSON(http.StatusInternalServerError, gin.H{"error": "Error parsing extracted JSON"})
// 				return
// 			}

// 			// Store extracted data in Firestore
// 			_, _, err = db_client.Collection("ITRDetailsExtracted").Add(ctx, map[string]interface{}{
// 				"data":       extractedData,
// 				"timestamp":  time.Now(),
// 				"filename":   file.Filename,
// 				"profileId": profileId,
// 				"applicationId": applicationId,
// 			})
// 			if err != nil {
// 				c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to save extracted data in Firestore"})
// 				return
// 			}

// 			// Return the extracted data in the response
// 			c.JSON(http.StatusOK, extractedData)
// 			return
// 		}
// 	}
// 	c.JSON(http.StatusOK, gin.H{"extractedData": "Done"})
// }
func GetITRDetails(c *gin.Context) {
    files, err := c.MultipartForm()
    if err != nil || len(files.File["file"]) == 0 {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Failed to retrieve files"})
        return
    }

    profileId := c.Param("profileId")
    applicationId := c.Param("applicationId")
    extractedDataList := []map[string]interface{}{}

    for _, fileHeader := range files.File["file"] {
        tempFilePath := "uploads/" + fileHeader.Filename
        if err := c.SaveUploadedFile(fileHeader, tempFilePath); err != nil {
            c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not save file"})
            return
        }
        defer os.Remove(tempFilePath) // Clean up the temporary file after processing

        // Read the saved file into memory
        bytes, err := os.ReadFile(tempFilePath)
        if err != nil {
            c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not read file"})
            return
        }

        client, err := genai.NewClient(context.Background(), option.WithAPIKey(os.Getenv("GEMINI_API_KEY")))
        if err != nil {
            c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not create GenAI client"})
            return
        }

        model := client.GenerativeModel("gemini-1.5-flash")
        promptTemplate := prompts.GenerateITRPrompt()

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
                var output genai.Text
                for _, part := range ct.Content.Parts {
                    output += part.(genai.Text)
                }

                outputString := fmt.Sprintf("%v", output)
                outputString = strings.TrimPrefix(outputString, "```json\n")
                outputString = strings.TrimSuffix(outputString, "\n```")

                var extractedData map[string]interface{}
                if err := json.Unmarshal([]byte(outputString), &extractedData); err != nil {
                    c.JSON(http.StatusInternalServerError, gin.H{"error": "Error parsing extracted JSON"})
                    return
                }

                // Store extracted data in Firestore
                _, _, err = db_client.Collection("ITRDetailsExtracted").Add(ctx, map[string]interface{}{
                    "data":        extractedData,
                    "timestamp":   time.Now(),
                    "filename":    fileHeader.Filename,
                    "profileId":   profileId,
                    "applicationId": applicationId,
                })
                if err != nil {
                    c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to save extracted data in Firestore"})
                    return
                }

                extractedDataList = append(extractedDataList, extractedData)
            }
        }
    }

    // Return the list of extracted data in the response
    c.JSON(http.StatusOK, gin.H{"extractedDataList": extractedDataList})
}
