package schemes

import (
	"context"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"time"

	utils "server/config/firebase"

	"cloud.google.com/go/firestore"
	"github.com/gin-gonic/gin"
	"github.com/go-resty/resty/v2"
	"github.com/pkg/errors"
)

var dbClient *firestore.Client

// LoanApplication represents the structure of a loan application.
type LoanApplication struct {
	LoanPurpose        string    `json:"loanPurpose"`
	LoanAmountRequired string    `json:"loanAmountRequired"`
	Tenure             string    `json:"tenure"`
	RetirementAge      string    `json:"retirementAge"`
	RepaymentMethod    string    `json:"repaymentMethod"`
	Timestamp          time.Time `json:"timestamp"`
	ProfileId          string    `json:"profileId"`
	ApplicationId      string    `json:"applicationId"`
}

// Scheme represents the structure of a government scheme.
type Scheme struct {
	RelatedScheme      string `json:"relatedScheme"`
	Description        string `json:"description"`
	NatureOfAssistance string `json:"natureOfAssistance"`
	WhoCanApply        string `json:"whoCanApply"`
	HowToApply         string `json:"howToApply"`
}

// SchemeResponse represents the structured response format for schemes.
type SchemeResponse struct {
	RelatedScheme      string `json:"relatedScheme"`
	Description        string `json:"description"`
	NatureOfAssistance string `json:"natureOfAssistance"`
	WhoCanApply        string `json:"whoCanApply"`
	HowToApply         string `json:"howToApply"`
}

// init initializes the Firestore client.
func init() {
	var err error
	dbClient = utils.InitFirestore()
	if err != nil {
		log.Fatalf("Failed to initialize Firestore: %v", err)
	}
	log.Println("Firestore client initialized successfully.")
}

// LoadSchemesFromFile loads the schemes from the scheme.json file.
func LoadSchemesFromFile(filePath string) ([]Scheme, error) {
	log.Printf("Loading schemes from file: %s", filePath)
	file, err := os.Open(filePath)
	if err != nil {
		return nil, errors.Wrap(err, "failed to open schemes file")
	}
	defer file.Close()

	byteValue, err := io.ReadAll(file) // Updated to use io.ReadAll
	if err != nil {
		return nil, errors.Wrap(err, "failed to read schemes file")
	}

	var schemes []Scheme
	if err := json.Unmarshal(byteValue, &schemes); err != nil {
		return nil, errors.Wrap(err, "failed to parse schemes JSON")
	}

	log.Printf("Successfully loaded %d schemes from %s", len(schemes), filePath)
	return schemes, nil
}

// RetrieveLoanApplication retrieves loan application details from the database.
func RetrieveLoanApplication(ctx context.Context, profileId, applicationId string) (LoanApplication, error) {
	log.Printf("Retrieving loan application for Profile ID: %s, Application ID: %s", profileId, applicationId)

	var loanApp LoanApplication

	loanApps := []string{"business_loan_applications", "personal_loan_applications"}
	for _, appType := range loanApps {
		log.Printf("Checking collection: %s", appType)
		loanAppDoc, err := dbClient.Collection(appType).
			Where("profileId", "==", profileId).
			Where("applicationId", "==", applicationId).
			Documents(ctx).
			GetAll()

		if err != nil {
			return loanApp, errors.Wrap(err, fmt.Sprintf("error retrieving %s", appType))
		}

		if len(loanAppDoc) > 0 {
			log.Printf("%s found, returning loan application.", appType)
			return convertLoanApplication(loanAppDoc[0].Data()), nil
		} else {
			log.Printf("No loan application found in %s for Profile ID: %s, Application ID: %s", appType, profileId, applicationId)
		}
	}

	log.Println("No matching loan application found.")
	return loanApp, fmt.Errorf("no matching loan application found")
}

// convertLoanApplication converts raw data into a LoanApplication struct.
func convertLoanApplication(data map[string]interface{}) LoanApplication {
	log.Println("Converting loan application data to struct.")
	loanApp := LoanApplication{}

	// Use type assertions to safely extract fields
	if val, ok := data["loanPurpose"].(string); ok {
		loanApp.LoanPurpose = val
		log.Printf("Loaded LoanPurpose: %s", loanApp.LoanPurpose)
	}

	if val, ok := data["loanAmountRequired"].(string); ok {
		loanApp.LoanAmountRequired = val
		log.Printf("Loaded LoanAmountRequired: %s", loanApp.LoanAmountRequired)
	}

	if val, ok := data["tenure"].(string); ok {
		loanApp.Tenure = val
		log.Printf("Loaded Tenure: %s", loanApp.Tenure)
	}

	if val, ok := data["retirementAge"].(string); ok {
		loanApp.RetirementAge = val
		log.Printf("Loaded RetirementAge: %s", loanApp.RetirementAge)
	}

	if val, ok := data["repaymentMethod"].(string); ok {
		loanApp.RepaymentMethod = val
		log.Printf("Loaded RepaymentMethod: %s", loanApp.RepaymentMethod)
	}

	if val, ok := data["timestamp"].(time.Time); ok {
		loanApp.Timestamp = val
		log.Printf("Loaded Timestamp: %s", loanApp.Timestamp)
	}

	if val, ok := data["profileId"].(string); ok {
		loanApp.ProfileId = val
		log.Printf("Loaded ProfileId: %s", loanApp.ProfileId)
	}

	if val, ok := data["applicationId"].(string); ok {
		loanApp.ApplicationId = val
		log.Printf("Loaded ApplicationId: %s", loanApp.ApplicationId)
	}

	return loanApp
}

// generateAnswers generates an answer using the Gemini API.
func generateAnswers(query string, context string) (string, error) {
	log.Printf("Generating answers for query: %s", query)
	GEMINI_API_KEY := os.Getenv("GEMINI_API_KEY")
	if GEMINI_API_KEY == "" {
		return "", fmt.Errorf("GEMINI_API_KEY environment variable not set")
	}

	client := resty.New()
	prompt := fmt.Sprintf("Based on a loan application with the purpose of '%s', requiring '%s', for a tenure of '%s', suggest suitable government schemes location is India. Provide any scheme. do not ask more information",
		query, context)
	requestBody := map[string]interface{}{
		"contents": []map[string]interface{}{
			{
				"parts": []map[string]interface{}{
					{"text": prompt},
				},
			},
		},
	}

	log.Printf("Sending request to Gemini API with prompt: %s", prompt)
	res, err := client.R().
		SetQueryParam("key", GEMINI_API_KEY).
		SetHeader("Content-Type", "application/json").
		SetBody(requestBody).
		Post("https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent")

	if err != nil {
		return "", err
	}

	if res.StatusCode() != http.StatusOK {
		return "", fmt.Errorf("failed to generate answer: %s", res.String())
	}

	var result map[string]interface{}
	err = json.Unmarshal(res.Body(), &result)
	if err != nil {
		return "", fmt.Errorf("failed to parse generation response: %v", err)
	}

	candidates, ok := result["candidates"].([]interface{})
	if !ok || len(candidates) == 0 {
		return "", fmt.Errorf("unexpected response format")
	}

	content, ok := candidates[0].(map[string]interface{})["content"].(map[string]interface{})
	if !ok {
		return "", fmt.Errorf("unexpected content format")
	}

	parts, ok := content["parts"].([]interface{})
	if !ok || len(parts) == 0 {
		return "", fmt.Errorf("unexpected parts format")
	}

	text, ok := parts[0].(map[string]interface{})["text"].(string)
	if !ok {
		return "", fmt.Errorf("unexpected text format")
	}

	log.Printf("Generated response: %s", text)
	return text, nil
}

// SuggestSchemeInfo handles the API request and response for finding the best schemes.
func SuggestSchemeInfo(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")

	log.Printf("Received request to suggest schemes for Profile ID: %s, Application ID: %s", profileId, applicationId)

	if profileId == "" || applicationId == "" {
		log.Println("Error: Missing profileId or applicationId")
		c.JSON(http.StatusBadRequest, gin.H{"error": "Missing profileId or applicationId"})
		return
	}

	// Hardcoded JSON data
	response := gin.H{
		"message": "Schemes based on your loan application",
		"schemes": []map[string]string{
			{
				"relatedScheme":      "Kisan Credit Card (KCC) Scheme",
				"description":        "Provides timely and adequate credit support to farmers for their short-term credit needs for cultivation and other agricultural activities.",
				"natureOfAssistance": "Short-term credit facility",
				"whoCanApply":        "Cultivating farmers, both owners and tenants; Share Croppers; Self Help Groups (SHGs) of farmers",
				"howToApply":         "Approach any Bank, Regional Rural Bank (RRB), or Cooperative Bank that offers KCC.",
			},
			{
				"relatedScheme":      "Pradhan Mantri Kisan Samman Nidhi (PM-KISAN)",
				"description":        "Provides income support to all Farmer families across India with cultivable land holding in their name.",
				"natureOfAssistance": "Direct Benefit Transfer (DBT) of Rs. 6,000 per year in three equal installments.",
				"whoCanApply":        "All landholding farmers' families.",
				"howToApply":         "Contact your local Patwari/Revenue officer or visit the PM-KISAN website.",
			},
			{
				"relatedScheme":      "Agriculture Infrastructure Fund (AIF)",
				"description":        "Provides medium - long term debt financing facility for investment in viable projects for post-harvest management infrastructure and community farming assets.",
				"natureOfAssistance": "Financial assistance in the form of loans",
				"whoCanApply":        "Farmers, FPOs, FPCs, Agri-entrepreneurs, Agri-tech players, SHGs, Central/State Agencies, etc.",
				"howToApply":         "Contact your nearest bank branch or visit the AIF scheme website.",
			},
			{
				"relatedScheme":      "Pradhan Mantri Fasal Bima Yojana (PMFBY)",
				"description":        "Provides insurance coverage and financial support to farmers in case of crop failure due to natural calamities, pests & diseases.",
				"natureOfAssistance": "Crop insurance coverage",
				"whoCanApply":        "All farmers (both loanee and non-loanee) growing notified crops in a notified area.",
				"howToApply":         "Through designated banks, insurance companies, or online portals.",
			},
			{
				"relatedScheme":      "Dairy Entrepreneurship Development Scheme (DEDS)",
				"description":        "Supports setting up of dairy farms for milk production and provides financial assistance for activities like purchase of milch animals, construction of sheds, etc.",
				"natureOfAssistance": "Back-ended capital subsidy",
				"whoCanApply":        "Farmers, individual entrepreneurs, and groups of farmers",
				"howToApply":         "Contact the nearest District Animal Husbandry office or the National Bank for Agriculture and Rural Development (NABARD).",
			},
		},
	}

	// Return the hardcoded schemes with a message as JSON response
	c.JSON(http.StatusOK, response)
}

// // processSchemesResponse takes the raw response and formats it into the desired structure.
// func processSchemesResponse(rawResponse string) []map[string]string {
// 	// Split the raw response by schemes (using a suitable delimiter)
// 	schemesData := strings.Split(rawResponse, "**") // Assuming each scheme starts with "**"

// 	var schemes []map[string]string

// 	// Iterate over each scheme and extract the necessary details
// 	for _, scheme := range schemesData {
// 		if scheme == "" {
// 			continue
// 		}

// 		var relatedScheme, description, natureOfAssistance, whoCanApply, howToApply string

// 		// Extract the scheme details
// 		// Here you would need to parse the `scheme` string to extract details
// 		// For this example, let's assume we split by lines for simplicity
// 		lines := strings.Split(scheme, "\n")
// 		for _, line := range lines {
// 			if strings.Contains(line, "Description:") {
// 				description = strings.TrimSpace(strings.TrimPrefix(line, "* **Description:**"))
// 			} else if strings.Contains(line, "Nature of Assistance:") {
// 				natureOfAssistance = strings.TrimSpace(strings.TrimPrefix(line, "* **Nature of Assistance:**"))
// 			} else if strings.Contains(line, "Eligibility Criteria:") {
// 				whoCanApply = strings.TrimSpace(strings.TrimPrefix(line, "* **Eligibility Criteria:**"))
// 			} else if strings.Contains(line, "How to Apply:") {
// 				howToApply = strings.TrimSpace(strings.TrimPrefix(line, "* **How to Apply:**"))
// 			} else if strings.Contains(line, "Scheme:") {
// 				relatedScheme = strings.TrimSpace(strings.TrimPrefix(line, "**"))
// 			}
// 		}

// 		// Add the scheme to the array if it contains a relatedScheme
// 		if relatedScheme != "" {
// 			schemes = append(schemes, map[string]string{
// 				"relatedScheme":      relatedScheme,
// 				"description":        description,
// 				"natureOfAssistance": natureOfAssistance,
// 				"whoCanApply":        whoCanApply,
// 				"howToApply":         howToApply,
// 			})
// 		}
// 	}

// 	return schemes
// }
