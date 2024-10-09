package info_extraction

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"os"

	models "server/models/credit_score" // Adjust with your actual module path

	"github.com/gin-gonic/gin"
	"github.com/google/generative-ai-go/genai"
	"google.golang.org/api/option"

	prompts "server/prompts" // Adjust the import path as needed
)

// CalculateCreditScore handles the credit score calculation request.
func CalculateCreditScore(c *gin.Context) {
	// Get profileId and applicationId from URL parameters
	profileID := c.Param("profileId")
	applicationID := c.Param("applicationId")

	// If not in URL, check headers
	if profileID == "" {
		profileID = c.GetHeader("profileId")
	}
	if applicationID == "" {
		applicationID = c.GetHeader("applicationId")
	}

	// Validate that we have both IDs
	if profileID == "" || applicationID == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Missing profileId or applicationId"})
		return
	}

	// Debugging statements
	fmt.Printf("Received Profile ID: %s\n", profileID)
	fmt.Printf("Received Application ID: %s\n", applicationID)

	// Create a CreditScoreRequest object
	request := models.CreditScoreRequest{
		ProfileID:     profileID,
		ApplicationID: applicationID,
	}

	// Calculate credit score
	creditScore, recommendations, err := calculateCreditScore(profileID, applicationID, request)
	if err != nil {
		fmt.Printf("Error calculating credit score: %v\n", err) // Debugging
		c.JSON(http.StatusInternalServerError, models.CreditScoreResponse{
			Error: err.Error(),
		})
		return
	}

	// Return the credit score response
	c.JSON(http.StatusOK, models.CreditScoreResponse{
		CreditScore:     creditScore,
		Recommendations: recommendations,
	})
}

// calculateCreditScore computes the credit score based on bank and ITR information.
func calculateCreditScore(profileId, applicationId string, request models.CreditScoreRequest) (float64, string, error) {
	ctx := context.Background()

	// Retrieve bank details
	bankDetailsDoc, err := db_client.Collection("BankDetailsExtracted").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx).
		GetAll()
	if err != nil {
		return 0, "", fmt.Errorf("error retrieving bank details: %v", err)
	}

	// Debugging statements
	fmt.Printf("Retrieved %d bank detail documents for Profile ID: %s, Application ID: %s\n", len(bankDetailsDoc), profileId, applicationId)

	// Retrieve ITR info
	itrInfoDoc, err := db_client.Collection("ITRDetailsExtracted").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx).
		GetAll()
	if err != nil {
		return 0, "", fmt.Errorf("error retrieving ITR info: %v", err)
	}

	// Debugging statements
	fmt.Printf("Retrieved %d ITR info documents for Profile ID: %s, Application ID: %s\n", len(itrInfoDoc), profileId, applicationId)

	// Extract bank details and ITR info
	var bankDetails map[string]interface{}
	var itrInfo map[string]interface{}
	if len(bankDetailsDoc) > 0 {
		bankDetails = bankDetailsDoc[0].Data()
		fmt.Printf("Bank Details: %+v\n", bankDetails) // Debugging
	} else {
		return 0, "", fmt.Errorf("no matching bank details found")
	}

	if len(itrInfoDoc) > 0 {
		itrInfo = itrInfoDoc[0].Data()
		fmt.Printf("ITR Info: %+v\n", itrInfo) // Debugging
	} else {
		return 0, "", fmt.Errorf("no matching ITR info found")
	}

	// Calculate scores
	itrScore, err := calculateITRScore(itrInfo)
	if err != nil {
		return 0, "", err
	}
	fmt.Printf("Calculated ITR Score: %.2f\n", itrScore) // Debugging statement

	bankScore, err := calculateBankStatementScore(bankDetails)
	if err != nil {
		return 0, "", err
	}
	fmt.Printf("Calculated Bank Statement Score: %.2f\n", bankScore) // Debugging statement

	taxScore := calculateTaxComplianceScore(itrInfo)
	fmt.Printf("Calculated Tax Compliance Score: %.2f\n", taxScore) // Debugging statement

	// Final credit score
	finalCreditScore := itrScore + bankScore + taxScore
	fmt.Printf("Final Credit Score: %.2f\n", finalCreditScore) // Debugging statement

	// Prepare data for Gemini
	bankDetailsString, err := json.MarshalIndent(bankDetails, "", "  ")
	if err != nil {
		return 0, "", fmt.Errorf("error converting bank details to string: %v", err)
	}
	fmt.Printf("Serialized Bank Details: %s\n", bankDetailsString) // Debugging statement

	itrInfoString, err := json.MarshalIndent(itrInfo, "", "  ")
	if err != nil {
		return 0, "", fmt.Errorf("error converting ITR info to string: %v", err)
	}
	fmt.Printf("Serialized ITR Info: %s\n", itrInfoString) // Debugging statement

	// Prepare prompt for Gemini
	promptTemplate := prompts.GenerateCreditScoreImprovementPrompt(finalCreditScore, string(bankDetailsString), string(itrInfoString))
	fmt.Printf("Prompt Template for Gemini: %s\n", promptTemplate) // Debugging statement

	client, err := genai.NewClient(ctx, option.WithAPIKey(os.Getenv("GEMINI_API_KEY")))
	if err != nil {
		return 0, "", fmt.Errorf("error creating Gemini client: %v", err)
	}

	model := client.GenerativeModel("gemini-1.5-flash")

	// Send prompt to Gemini for recommendations
	extractionPrompt := []genai.Part{
		genai.Text(promptTemplate),
	}

	geminiResp, err := model.GenerateContent(ctx, extractionPrompt...)
	if err != nil {
		return 0, "", fmt.Errorf("error generating recommendations from Gemini: %v", err)
	}

	// Process the Gemini response
	var recommendations string
	for _, ct := range geminiResp.Candidates {
		var output genai.Text
		for _, part := range ct.Content.Parts {
			output += part.(genai.Text)
		}
		recommendations = string(output)
	}
	fmt.Printf("Generated Recommendations from Gemini: %s\n", recommendations) // Debugging statement

	// Return the final credit score and recommendations from Gemini
	return finalCreditScore, recommendations, nil
}

// calculateITRScore calculates the score based on ITR information.
func calculateITRScore(itrInfo map[string]interface{}) (float64, error) {
	// Extract values from ITR JSON
	revenue, ok := itrInfo["Revenue (Turnover)"].(float64)
	if !ok {
		return 0, fmt.Errorf("missing or invalid Revenue (Turnover)")
	}
	pbt, ok := itrInfo["Profit before tax"].(float64)
	if !ok {
		return 0, fmt.Errorf("missing or invalid Profit before tax")
	}
	pat, ok := itrInfo["Profit after tax"].(float64)
	if !ok {
		return 0, fmt.Errorf("missing or invalid Profit after tax")
	}
	currentLiabilities, ok := itrInfo["Total Current liabilities"].(float64)
	if !ok {
		return 0, fmt.Errorf("missing or invalid Total Current liabilities")
	}
	cashEquivalents, ok := itrInfo["Total Cash and cash equivalents"].(float64)
	if !ok {
		return 0, fmt.Errorf("missing or invalid Total Cash and cash equivalents")
	}
	longTermBorrowings, ok := itrInfo["Total Long term borrowings"].(float64)
	if !ok {
		return 0, fmt.Errorf("missing or invalid Total Long term borrowings")
	}
	tradeReceivables, ok := itrInfo["Total Trade receivables"].(float64)
	if !ok {
		return 0, fmt.Errorf("missing or invalid Total Trade receivables")
	}
	inventory, ok := itrInfo["Total Inventories"].(float64)
	if !ok {
		return 0, fmt.Errorf("missing or invalid Total Inventories")
	}
	taxPaid, ok := itrInfo["Tax Paid/Deferred Tax"].(map[string]interface{})["Tax Paid"].(float64)
	if !ok {
		return 0, fmt.Errorf("missing or invalid Tax Paid")
	}

	// Calculate the ITR score
	itrScore := (revenue*0.20 + pbt*0.15 + pat*0.10 + currentLiabilities*0.10 +
		cashEquivalents*0.05 + longTermBorrowings*0.10 + tradeReceivables*0.05 +
		inventory*0.05 + taxPaid*0.05) * 0.55

	fmt.Printf("Calculated ITR Score: %.2f\n", itrScore) // Debugging statement
	return itrScore, nil
}

// calculateBankStatementScore calculates the score based on bank statement data.
func calculateBankStatementScore(bankDetails map[string]interface{}) (float64, error) {
	// Extract necessary values from bank details JSON
	balance, ok := bankDetails["Balance"].(float64)
	if !ok {
		return 0, fmt.Errorf("missing or invalid Balance")
	}
	income, ok := bankDetails["Income"].(float64)
	if !ok {
		return 0, fmt.Errorf("missing or invalid Income")
	}
	expenses, ok := bankDetails["Expenses"].(float64)
	if !ok {
		return 0, fmt.Errorf("missing or invalid Expenses")
	}

	// Calculate bank statement score
	bankScore := (balance*0.50 + income*0.25 - expenses*0.25) * 0.45
	fmt.Printf("Calculated Bank Statement Score: %.2f\n", bankScore) // Debugging statement
	return bankScore, nil
}

// calculateTaxComplianceScore calculates the tax compliance score.
func calculateTaxComplianceScore(itrInfo map[string]interface{}) float64 {
	// Assume a basic calculation based on provided ITR info
	taxComplianceScore := 0.0
	if itrInfo["Tax Compliance"].(bool) {
		taxComplianceScore = 100.0 // Full score for compliance
	} else {
		taxComplianceScore = 50.0 // Partial score for non-compliance
	}
	fmt.Printf("Calculated Tax Compliance Score: %.2f\n", taxComplianceScore) // Debugging statement
	return taxComplianceScore
}
