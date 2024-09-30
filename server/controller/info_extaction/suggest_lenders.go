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
	// "cloud.google.com/go/firestore"
	// "strings"
	// "time"

)

// db_client *firestore.Client

func init(){
	db_client = utils.InitFirestore()
}

func SuggestLenders(c *gin.Context){
	applicationId := c.Param("applicationId")
	profileId := c.Param("profileId")
	
	ctx := context.Background()
	// pro
	bankDetailsDoc, err := db_client.Collection("BankDetailsExtracted").Where("profileId", "==", profileId).Where("applicationId", "==", applicationId).Documents(ctx).GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error retrieving bank details"})
		return
	}

	itrInfoDoc,err := db_client.Collection("ITRInfoExtracted").Where("profileId", "==", profileId).Where("applicationId", "==", applicationId).Documents(ctx).GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error retrieving ITR info"})
		return
	}

	var loanApplication map[string]interface{}
	loanAppDoc,_ := db_client.Collection("personal_loan_applications").Where("profileId", "==", profileId).Where("applicationId", "==", applicationId).Limit(1).Documents(ctx).GetAll()
	if err != nil { // If personal loan doesn't exist, check for business loan application
		loanAppDoc,_= db_client.Collection("business_loan_applications").Where("profileId", "==", profileId).Where("applicationId", "==", applicationId).Limit(1).Documents(ctx).GetAll()
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Error retrieving loan application"})
			return
		}
	}
	loanAppDoc[0].DataTo(&loanApplication)

	lendersListDocs, err := db_client.Collection("LendersList").Documents(ctx).GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error retrieving lenders list"})
		return
	}

	tempFilePath := "lenders_temp.json"
	var lendersList []map[string]interface{}

	// Collect all lender data into a list
	for _, doc := range lendersListDocs {
		lendersList = append(lendersList, doc.Data())
	}

	// Write the lenders list to a temporary JSON file
	lendersFile, err := os.Create(tempFilePath)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not create lenders temp file"})
		return
	}
	defer lendersFile.Close()
	defer os.Remove(tempFilePath)

	lendersData, err := json.Marshal(lendersList)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error converting lenders list to JSON"})
		return
	}

	if _, err := lendersFile.Write(lendersData); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error writing lenders data to temp file"})
		return
	}

	var bankDetails map[string]interface{}
	if len(bankDetailsDoc) > 0 {
		bankDetails = bankDetailsDoc[0].Data() // Access the first document
	} else {
		c.JSON(http.StatusNotFound, gin.H{"error": "No matching bank details found"})
		return
	}
	var itrInfo map[string]interface{}
	if len(itrInfoDoc) > 0 {
		itrInfo =itrInfoDoc[0].Data() // Access the first document
	} else {
		c.JSON(http.StatusNotFound, gin.H{"error": "No matching bank details found"})
		return
	}

	// Combine the data into a single prompt for Gemini
	promptTemplate := fmt.Sprintf(`Based on the following information:
	- Bank Details: %v
	- ITR Info: %v
	- Loan Application: %v
	Analyze and suggest the top 10 most suitable loan lenders for the seeker from the lenders listed in this JSON file.Give the list of lenders in json format`, bankDetails, itrInfo, loanApplication)
	client, err := genai.NewClient(ctx, option.WithAPIKey(os.Getenv("GEMINI_API_KEY")))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error creating Gemini client"})
		return
	}

	model := client.GenerativeModel("gemini-1.5-flash")

	// Step 5: Send prompt and lenders JSON file to Gemini
	extractionPrompt := []genai.Part{
		genai.Text(promptTemplate),
		genai.Blob{MIMEType: "application/json", Data: lendersData}, // Send lenders JSON to Gemini
	}
	geminiResp, err := model.GenerateContent(ctx, extractionPrompt...)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error generating lender suggestions"})
		return
	}

	// Step 6: Parse Gemini response and return suggestions
	for _, ct := range geminiResp.Candidates {
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
		c.JSON(http.StatusOK, extractedData)
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "No lender suggestions found"})

}