package info_extraction

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strconv"
	"strings"

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

	// Optimized Credit Score Calculation (Similar to CIBIL Score):
	//
	// 1. Normalize ITR and Bank Scores:
	//    - Normalize the ITR score to range between 0 and 500 (using min-max scaling).
	//    - Normalize the Bank score to range between 0 and 500.
	// 2. Combine Normalized Scores:
	//    - Multiply the normalized ITR score by a weight (e.g., 0.6) to give it higher importance.
	//    - Multiply the normalized Bank score by a weight (e.g., 0.4).
	//    - Add the weighted scores to get the final credit score.
	// 3. Scale the Final Score:
	//    - Multiply the final credit score by 2 to scale it to a range of 0 - 1000.
	//    - Shift the final score by 100 to make it range from 100 - 1000.

	// Normalize ITR Score:
	// Normalize the ITR Score to a range of 0 to 1
	normalizedITRScore := itrScore / maxITRScore

	// Normalize Bank Statement Score:
	normalizedBankScore := (bankScore - minBankScore) / (maxBankScore - minBankScore)

	// Combine Normalized Scores with Weights:
	finalScore := (normalizedITRScore * 0.6) + (normalizedBankScore * 0.4)

	// Scale the Final Score:
	finalCreditScore := finalScore * 850 // Scale the score to a range of 0 - 850

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

func calculateITRScore(itrInfo map[string]interface{}) (float64, error) {
	// Debugging: Print the ITR Info map
	fmt.Printf("ITR Info map: %+v\n", itrInfo["data"])

	// Access the nested "data" map from itrInfo
	data, ok := itrInfo["data"].(map[string]interface{})
	if !ok {
		return 0, fmt.Errorf("missing or invalid 'data' in ITR info")
	}

	// Helper function to remove commas and convert string to float
	parseFloatWithCommas := func(s string) (float64, error) {
		// Remove commas
		s = strings.ReplaceAll(s, ",", "")
		return strconv.ParseFloat(s, 64)
	}

	// Initialize variables to store extracted values
	var revenue, pbt, pat, currentLiabilities, cashEquivalents, longTermBorrowings, tradeReceivables, inventory, taxPaid float64
	var err error

	// Extract "Turnover" from the nested "data" map
	switch v := data["Turnover"].(type) {
	case float64:
		revenue = v
	case string:
		revenue, err = parseFloatWithCommas(v)
		if err != nil {
			return 0, fmt.Errorf("unable to parse Turnover: %v", err)
		}
	default:
		return 0, fmt.Errorf("missing or invalid Revenue (Turnover)")
	}

	// Extract "Profit before tax"
	switch v := data["Profit before tax"].(type) {
	case float64:
		pbt = v
	case string:
		pbt, err = parseFloatWithCommas(v)
		if err != nil {
			return 0, fmt.Errorf("unable to parse Profit before tax: %v", err)
		}
	case nil:
		pbt = 0 // Handle nil value
	default:
		return 0, fmt.Errorf("missing or invalid Profit before tax")
	}

	// Extract "Profit after tax"
	switch v := data["Profit after tax"].(type) {
	case float64:
		pat = v
	case string:
		pat, err = parseFloatWithCommas(v)
		if err != nil {
			return 0, fmt.Errorf("unable to parse Profit after tax: %v", err)
		}
	case nil:
		pat = 0 // Handle nil value
	default:
		return 0, fmt.Errorf("missing or invalid Profit after tax")
	}

	// Extract "Total Current liabilities"
	switch v := data["Total Current liabilities"].(type) {
	case float64:
		currentLiabilities = v
	case string:
		currentLiabilities, err = parseFloatWithCommas(v)
		if err != nil {
			return 0, fmt.Errorf("unable to parse Total Current liabilities: %v", err)
		}
	case nil:
		currentLiabilities = 0 // Handle nil value
	default:
		return 0, fmt.Errorf("missing or invalid Total Current liabilities")
	}

	// Extract "Total Cash and cash equivalents"
	switch v := data["Total Cash and cash equivalents"].(type) {
	case float64:
		cashEquivalents = v
	case string:
		cashEquivalents, err = parseFloatWithCommas(v)
		if err != nil {
			return 0, fmt.Errorf("unable to parse Total Cash and cash equivalents: %v", err)
		}
	case nil:
		cashEquivalents = 0 // Handle nil value
	default:
		return 0, fmt.Errorf("missing or invalid Total Cash and cash equivalents")
	}

	// Extract "Total Long term borrowings"
	switch v := data["Total Long term borrowings"].(type) {
	case float64:
		longTermBorrowings = v
	case string:
		longTermBorrowings, err = parseFloatWithCommas(v)
		if err != nil {
			return 0, fmt.Errorf("unable to parse Total Long term borrowings: %v", err)
		}
	case nil:
		longTermBorrowings = 0 // Handle nil value
	default:
		return 0, fmt.Errorf("missing or invalid Total Long term borrowings")
	}

	// Extract "Total Trade receivables"
	switch v := data["Total Trade receivables"].(type) {
	case float64:
		tradeReceivables = v
	case string:
		tradeReceivables, err = parseFloatWithCommas(v)
		if err != nil {
			return 0, fmt.Errorf("unable to parse Total Trade receivables: %v", err)
		}
	case nil:
		tradeReceivables = 0 // Handle nil value
	default:
		return 0, fmt.Errorf("missing or invalid Total Trade receivables")
	}

	// Extract "Total Inventories"
	switch v := data["Total Inventories"].(type) {
	case float64:
		inventory = v
	case string:
		inventory, err = parseFloatWithCommas(v)
		if err != nil {
			return 0, fmt.Errorf("unable to parse Total Inventories: %v", err)
		}
	case nil:
		inventory = 0 // Handle nil value
	default:
		return 0, fmt.Errorf("missing or invalid Total Inventories")
	}

	switch v := data["Tax Paid"].(type) {
	case float64:
		taxPaid = v
	case string:
		taxPaid, err = parseFloatWithCommas(v)
		if err != nil {
			return 0, fmt.Errorf("unable to parse Tax Paid: %v", err)
		}
	case nil:
		taxPaid = 0 // Handle nil value
	default:
		return 0, fmt.Errorf("missing or invalid Tax Paid")
	}

	// Calculate the ITR score
	itrScore := (revenue*0.20 + pbt*0.15 + pat*0.10 + currentLiabilities*0.10 +
		cashEquivalents*0.05 + longTermBorrowings*0.10 + tradeReceivables*0.05 +
		inventory*0.05 + taxPaid*0.05) / 1000000 * 5 * 5

	fmt.Printf("Calculated ITR Score: %.2f\n", itrScore) // Debugging statement
	return itrScore, nil
}

// calculateBankStatementScore calculates the score based on bank statement details.
func calculateBankStatementScore(bankDetails map[string]interface{}) (float64, error) {
	// Debugging: Print the structure of the bankDetails map
	fmt.Printf("Bank Details map: %+v\n", bankDetails)

	// Access the "data" map from bankDetails
	data, ok := bankDetails["data"].(map[string]interface{})
	if !ok {
		return 0, fmt.Errorf("missing or invalid 'data' in Bank Details")
	}

	// Helper function to extract ratings from nested maps
	getRating := func(item map[string]interface{}) (float64, error) {
		rating, ok := item["Rating"].(float64)
		if !ok {
			return 0, fmt.Errorf("missing or invalid Rating")
		}
		return rating, nil
	}

	// Extract ratings for each field
	averageBalanceMap, ok := data["Average Balance"].(map[string]interface{})
	if !ok {
		return 0, fmt.Errorf("missing or invalid 'Average Balance' data")
	}
	averageBalance, err := getRating(averageBalanceMap)
	if err != nil {
		return 0, err
	}

	incomeMap, ok := data["Deposit Amount"].(map[string]interface{})
	if !ok {
		return 0, fmt.Errorf("missing or invalid 'Deposit Amount' data")
	}
	income, err := getRating(incomeMap)
	if err != nil {
		return 0, err
	}

	expensesMap, ok := data["Withdrawal Amount"].(map[string]interface{})
	if !ok {
		return 0, fmt.Errorf("missing or invalid 'Withdrawal Amount' data")
	}
	expenses, err := getRating(expensesMap)
	if err != nil {
		return 0, err
	}

	// Calculate the bank statement score
	bankScore := (averageBalance*0.50 + income*0.25 - expenses*0.25) * 0.45
	fmt.Printf("Calculated Bank Statement Score: %.2f\n", bankScore) // Debugging statement
	return bankScore, nil
}

// Define minimum and maximum possible scores for normalization
const (
	minITRScore  = 0
	maxITRScore  = 1000
	minBankScore = 0
	maxBankScore = 1000
)
