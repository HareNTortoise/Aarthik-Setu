package info_extraction

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strings"
	// "time"
	"github.com/gin-gonic/gin"
	"github.com/google/generative-ai-go/genai"
	"google.golang.org/api/option"
	utils "server/config/firebase"
	prompts "server/prompts"
	// "cloud.google.com/go/firestore"
	// "strings"
	// "time"

)

// var db_client *firestore.Client

func init(){
	db_client = utils.InitFirestore()
}

func SuggestLenders(c *gin.Context) {
	applicationId := c.Param("applicationId")
	profileId := c.Param("profileId")

	ctx := context.Background()

	// Retrieving bank details
	bankDetailsDoc, err := db_client.Collection("BankDetailsExtracted").Where("profileId", "==", profileId).Where("applicationId", "==", applicationId).Documents(ctx).GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error retrieving bank details"})
		return
	}

	// Retrieving ITR info
	itrInfoDoc, err := db_client.Collection("ITRDetailsExtracted").Where("profileId", "==", profileId).Where("applicationId", "==", applicationId).Documents(ctx).GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error retrieving ITR info"})
		return
	}

	// Retrieving loan application
	var loanApplication map[string]interface{}
	loanAppDoc, err := db_client.Collection("personal_loan_applications").Where("profileId", "==", profileId).Where("applicationId", "==", applicationId).Limit(1).Documents(ctx).GetAll()
	if err != nil {
		loanAppDoc, err = db_client.Collection("business_loan_applications").Where("profileId", "==", profileId).Where("applicationId", "==", applicationId).Limit(1).Documents(ctx).GetAll()
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Error retrieving loan application"})
			return
		}
	}
	if len(loanAppDoc) != 0 {
		loanAppDoc[0].DataTo(&loanApplication)
	} else {
		c.JSON(http.StatusNotFound, gin.H{"error": "No matching loan application found"})
		return
	}

	// Retrieving lenders list
	lendersListDocs, err := db_client.Collection("LendersList").Documents(ctx).GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error retrieving lenders list"})
		return
	}

	// Collect lenders list data as a string
	var lendersList []map[string]interface{}
	for _, doc := range lendersListDocs {
		lendersList = append(lendersList, doc.Data())
	}
	// Convert lenders list to a readable string format for text file
	lendersDataString, err := json.MarshalIndent(lendersList, "", "  ")
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error converting lenders list to string"})
		return
	}

	// Save lenders data as a text file
	tempFilePath := "lenders_temp.txt"
	if err := os.WriteFile(tempFilePath, lendersDataString, 0644); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error writing lenders data to temp file"})
		return
	}
	defer os.Remove(tempFilePath)

	// Read the lenders text file into memory
	lendersFileBytes, err := os.ReadFile(tempFilePath)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not read lenders file"})
		return
	}

	// Prepare data for Gemini API
	var bankDetails map[string]interface{}
	if len(bankDetailsDoc) > 0 {
		bankDetails = bankDetailsDoc[0].Data()
	} else {
		c.JSON(http.StatusNotFound, gin.H{"error": "No matching bank details found"})
		return
	}
	var itrInfo map[string]interface{}
	if len(itrInfoDoc) > 0 {
		itrInfo = itrInfoDoc[0].Data()
	} else {
		c.JSON(http.StatusNotFound, gin.H{"error": "No matching ITR info found"})
		return
	}

	// Create the prompt
	// promptTemplate := fmt.Sprintf(`Based on the following information:
	// - Bank Details: %v
	// - ITR Info: %v
	// - Loan Application: %v
	// Analyze and suggest the top 10 most suitable loan lenders for the seeker from the lenders listed in this text file. Provide the list of lenders in JSON format. Dont give any text in the form of explanation along with the json`, bankDetails, itrInfo, loanApplication)

	promptTemplate := prompts.GenerateLenderPrompt(bankDetails, itrInfo, loanApplication)

	client, err := genai.NewClient(ctx, option.WithAPIKey(os.Getenv("GEMINI_API_KEY")))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error creating Gemini client"})
		return
	}

	model := client.GenerativeModel("gemini-1.5-flash")

	// Send prompt and lenders text file to Gemini as text/plain
	extractionPrompt := []genai.Part{
		genai.Text(promptTemplate),
		genai.Blob{MIMEType: "text/plain", Data: lendersFileBytes}, // Send lenders text as plain text
	}
	geminiResp, err := model.GenerateContent(ctx, extractionPrompt...)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error generating lender suggestions", "details": err.Error(),})
		return
	}

	// Process the Gemini response
	for _, ct := range geminiResp.Candidates {
		var output genai.Text
		for _, part := range ct.Content.Parts {
			output += part.(genai.Text)
		}
		outputString := strings.TrimPrefix(fmt.Sprintf("%v", output), "```json\n")
		outputString = strings.TrimSuffix(outputString, "\n```")
		fmt.Println(outputString)
		var rawData json.RawMessage
		if err := json.Unmarshal([]byte(outputString), &rawData); err != nil {
			fmt.Println("Failed to unmarshal JSON:", outputString)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Error parsing extracted JSON", "details": err.Error()})
			return
		}
		c.JSON(http.StatusOK, rawData)
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "No lender suggestions found"})
}
