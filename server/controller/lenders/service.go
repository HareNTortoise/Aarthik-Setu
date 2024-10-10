package lenders

import (
	"context"
	"fmt"
	"log"
	"math"
	utils "server/config/firebase"
	"strconv"
	"strings"
	"time"

	"cloud.google.com/go/firestore"
)

var db_client *firestore.Client

// LoanApplication represents the structure of a loan application.
type LoanApplication struct {
	LoanPurpose                                       string    `json:"loanPurpose" form:"loanPurpose"`
	LoanAmountRequired                                string    `json:"loanAmountRequired" form:"loanAmountRequired"`
	Tenure                                            string    `json:"tenure" form:"tenure"`
	RetirementAge                                     string    `json:"retirementAge" form:"retirementAge"`
	EmiBySalaryAccount                                bool      `json:"_emiBySalaryAccount" form:"_emiBySalaryAccount"`
	PayOutstandingByTerminalPayments                  bool      `json:"payOutstandingByTerminalPayments" form:"_payOutstandingByTerminalPayments"`
	PaySalaryInSalaryAccount                          bool      `json:"_paySalaryInSalaryAccount" form:"paySalaryInSalaryAccount"`
	IssueLetterToYourEmployerToPayOutstandingLoan     bool      `json:"issueLetterToYourEmployerToPayOutstandingLoan" form:"issueLetterToYourEmployerToPayOutstandingLoan"`
	IssueLetterToYourEmployerToNotChangeSalaryAccount bool      `json:"issueLetterToYourEmployerToNotChangeSalaryAccount" form:"issueLetterToYourEmployerToNotChangeSalaryAccount"`
	RepaymentMethod                                   string    `json:"repaymentMethod" form:"repaymentMethod"`
	Timestamp                                         time.Time `json:"timestamp" form:"timestamp"`
	FormId                                            string    `json:"formId" form:"formId"`
	ProfileId                                         string    `json:"profileId" form:"profileId"`
	ApplicationId                                     string    `json:"applicationId" form:"applicationId"`
}

// Lender represents the structure of a lender.
type Lender struct {
	LenderName          string   `json:"lender_name"`
	LenderType          string   `json:"lender_type"`
	Position            string   `json:"position"`
	Location            string   `json:"location"`
	LoanType            string   `json:"loan_type"`
	LoanAmountRange     string   `json:"loan_amount_range"`
	InterestRate        string   `json:"interest_rate"`
	LoanTerm            string   `json:"loan_term"`
	EligibilityCriteria string   `json:"eligibility_criteria"`
	CollateralRequired  bool     `json:"collateral_required"`
	ApplicationDeadline string   `json:"application_deadline"`
	Remote              bool     `json:"remote"`
	Seniority           string   `json:"seniority"`
	ExperienceLevel     int      `json:"experience_level"`
	SkillsRequired      int      `json:"skills_required"`
	IndustryExperience  int      `json:"industry_experience"`
	FairMatchScore      int      `json:"fair_match_score"`
	H1bSponsor          bool     `json:"h1b_sponsor"`
	Benefits            []string `json:"benefits"`
	LoanDescription     string   `json:"loan_description"`
	ApplicationStatus   string   `json:"application_status"`
	ApplicantCount      int      `json:"applicant_count"`
	ImageUrl            string   `json:"image_url"`
}

// init initializes the Firestore client
func init() {
	var err error
	db_client = utils.InitFirestore()
	if err != nil {
		log.Fatalf("Failed to initialize Firestore: %v", err)
	}
	log.Println("Firestore client initialized successfully.")
}

// RetrieveLoanApplication retrieves the loan application details from the database.
func RetrieveLoanApplication(profileId, applicationId string) (LoanApplication, error) {
	ctx := context.Background()

	log.Printf("Retrieving loan application for Profile ID: %s, Application ID: %s\n", profileId, applicationId)

	// Check for business loan application
	businessLoanAppDoc, err := db_client.Collection("business_loan_applications").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx).
		GetAll()
	if err != nil {
		log.Printf("Error retrieving business loan application: %v\n", err)
		return LoanApplication{}, fmt.Errorf("error retrieving business loan application: %v", err)
	}

	// Check for personal loan application
	personalLoanAppDoc, err := db_client.Collection("personal_loan_applications").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx).
		GetAll()
	if err != nil {
		log.Printf("Error retrieving personal loan application: %v\n", err)
		return LoanApplication{}, fmt.Errorf("error retrieving personal loan application: %v", err)
	}

	// If both are found, pick the business loan application
	if len(businessLoanAppDoc) > 0 && len(personalLoanAppDoc) > 0 {
		log.Println("Both business and personal loan applications found, returning business loan application.")
		return convertLoanApplication(businessLoanAppDoc[0].Data()), nil
	} else if len(businessLoanAppDoc) > 0 {
		log.Println("Business loan application found, returning business loan application.")
		return convertLoanApplication(businessLoanAppDoc[0].Data()), nil
	} else if len(personalLoanAppDoc) > 0 {
		log.Println("Personal loan application found, returning personal loan application.")
		return convertLoanApplication(personalLoanAppDoc[0].Data()), nil
	} else {
		log.Println("No matching loan application found.")
		return LoanApplication{}, fmt.Errorf("no matching loan application found")
	}
}

// CalculateMonthlyPayment calculates the monthly payment using the formula
func CalculateMonthlyPayment(principal float64, annualRate float64, years int) float64 {
	monthlyRate := annualRate / 12
	n := years * 12

	if monthlyRate == 0 {
		return principal / float64(n) // For zero interest case
	}

	monthlyPayment := principal * (monthlyRate * math.Pow(1+monthlyRate, float64(n))) / (math.Pow(1+monthlyRate, float64(n)) - 1)
	return monthlyPayment
}

// CalculateTotalInterest calculates the total interest paid over the life of the loan
func CalculateTotalInterest(principal float64, monthlyPayment float64, years int) float64 {
	totalPaid := monthlyPayment * float64(years*12)
	totalInterest := totalPaid - principal
	return totalInterest
}

// GenerateAmortizationSchedule generates a detailed amortization schedule
func GenerateAmortizationSchedule(principal float64, annualRate float64, years int) []map[string]interface{} {
	monthlyRate := annualRate / 12
	n := years * 12

	schedule := make([]map[string]interface{}, n)

	for i := 0; i < n; i++ {
		interestPayment := principal * monthlyRate
		principalPayment := CalculateMonthlyPayment(principal, annualRate, years) - interestPayment
		remainingBalance := principal - principalPayment

		schedule[i] = map[string]interface{}{
			"PaymentNumber":    i + 1,
			"PrincipalPayment": principalPayment,
			"InterestPayment":  interestPayment,
			"TotalPayment":     principalPayment + interestPayment,
			"RemainingBalance": remainingBalance,
		}

		principal = remainingBalance // Decrease principal by the amount paid
	}

	return schedule
}

// EstimateLoanRepaymentTime estimates the loan repayment time and monthly payment based on the lender's terms and loan application details.
func EstimateLoanRepaymentTime(lender Lender, loanApp LoanApplication) (string, float64, float64, []map[string]interface{}, error) {
	// Parse loan term from lender
	loanTermParts := strings.Split(lender.LoanTerm, " - ")
	if len(loanTermParts) != 2 {
		return "", 0, 0, nil, fmt.Errorf("invalid loan term format: %s", lender.LoanTerm)
	}

	// Helper function to extract numeric values from the term string
	extractYears := func(term string) (int, error) {
		parts := strings.Fields(term)
		if len(parts) == 0 {
			return 0, fmt.Errorf("invalid loan term: %s", term)
		}
		years, err := strconv.Atoi(parts[0])
		if err != nil {
			return 0, fmt.Errorf("error parsing loan term: %v", err)
		}
		return years, nil
	}

	// Extract min and max terms as years
	minTerm, err := extractYears(strings.TrimSpace(loanTermParts[0]))
	if err != nil {
		return "", 0, 0, nil, fmt.Errorf("error parsing minimum loan term: %v", err)
	}

	maxTerm, err := extractYears(strings.TrimSpace(loanTermParts[1]))
	if err != nil {
		return "", 0, 0, nil, fmt.Errorf("error parsing maximum loan term: %v", err)
	}

	// Extract loan amount from loan application
	loanAmount, err := strconv.ParseFloat(strings.ReplaceAll(loanApp.LoanAmountRequired, "₹", ""), 64)
	if err != nil {
		return "", 0, 0, nil, fmt.Errorf("error parsing loan amount: %v", err)
	}

	// Extract interest rate from lender
	interestRateParts := strings.Split(lender.InterestRate, " - ")
	if len(interestRateParts) != 2 {
		return "", 0, 0, nil, fmt.Errorf("invalid interest rate format: %s", lender.InterestRate)
	}

	minRate, err := strconv.ParseFloat(strings.Trim(strings.ReplaceAll(interestRateParts[0], "%", ""), " "), 64)
	if err != nil {
		return "", 0, 0, nil, fmt.Errorf("error parsing minimum interest rate: %v", err)
	}

	maxRate, err := strconv.ParseFloat(strings.Trim(strings.ReplaceAll(interestRateParts[1], "%", ""), " "), 64)
	if err != nil {
		return "", 0, 0, nil, fmt.Errorf("error parsing maximum interest rate: %v", err)
	}

	// Calculate average interest rate
	averageInterestRate := (minRate + maxRate) / 2 / 100 // Convert to decimal

	// Calculate monthly payments for both terms
	minMonthlyPayment := CalculateMonthlyPayment(loanAmount, averageInterestRate, minTerm)
	maxMonthlyPayment := CalculateMonthlyPayment(loanAmount, averageInterestRate, maxTerm)

	// Generate amortization schedules
	minAmortizationSchedule := GenerateAmortizationSchedule(loanAmount, averageInterestRate, minTerm)
	// maxAmortizationSchedule := GenerateAmortizationSchedule(loanAmount, averageInterestRate, maxTerm)

	// Construct the estimated loan term string
	estimatedTime := fmt.Sprintf("Min Term: %d years, Max Term: %d years", minTerm, maxTerm)

	return estimatedTime, minMonthlyPayment, maxMonthlyPayment, minAmortizationSchedule, nil
}
func convertLoanApplication(data map[string]interface{}) LoanApplication {
	loanApp := LoanApplication{}

	// Safe type assertion with default value
	if val, ok := data["loanPurpose"].(string); ok {
		loanApp.LoanPurpose = val
		log.Printf("Loaded loan purpose: %s\n", val)
	}

	if val, ok := data["loanAmountRequired"].(string); ok {
		loanApp.LoanAmountRequired = val
		log.Printf("Loaded loan amount required: %s\n", val)
	}

	if val, ok := data["tenure"].(string); ok {
		loanApp.Tenure = val
		log.Printf("Loaded tenure: %s\n", val)
	}

	if val, ok := data["retirementAge"].(string); ok {
		loanApp.RetirementAge = val
		log.Printf("Loaded retirement age: %s\n", val)
	}

	if val, ok := data["emiBySalaryAccount"].(bool); ok {
		loanApp.EmiBySalaryAccount = val
		log.Printf("Loaded EMI by salary account: %t\n", val)
	}

	if val, ok := data["payOutstandingByTerminalPayments"].(bool); ok {
		loanApp.PayOutstandingByTerminalPayments = val
		log.Printf("Loaded pay outstanding by terminal payments: %t\n", val)
	}

	if val, ok := data["paySalaryInSalaryAccount"].(bool); ok {
		loanApp.PaySalaryInSalaryAccount = val
		log.Printf("Loaded pay salary in salary account: %t\n", val)
	}

	if val, ok := data["issueLetterToYourEmployerToPayOutstandingLoan"].(bool); ok {
		loanApp.IssueLetterToYourEmployerToPayOutstandingLoan = val
		log.Printf("Loaded issue letter to employer to pay outstanding loan: %t\n", val)
	}

	if val, ok := data["issueLetterToYourEmployerToNotChangeSalaryAccount"].(bool); ok {
		loanApp.IssueLetterToYourEmployerToNotChangeSalaryAccount = val
		log.Printf("Loaded issue letter to employer to not change salary account: %t\n", val)
	}

	if val, ok := data["repaymentMethod"].(string); ok {
		loanApp.RepaymentMethod = val
		log.Printf("Loaded repayment method: %s\n", val)
	}

	if val, ok := data["timestamp"].(time.Time); ok {
		loanApp.Timestamp = val
		log.Printf("Loaded timestamp: %s\n", val)
	}

	if val, ok := data["formId"].(string); ok {
		loanApp.FormId = val
		log.Printf("Loaded form ID: %s\n", val)
	}

	if val, ok := data["profileId"].(string); ok {
		loanApp.ProfileId = val
		log.Printf("Loaded profile ID: %s\n", val)
	}

	if val, ok := data["applicationId"].(string); ok {
		loanApp.ApplicationId = val
		log.Printf("Loaded application ID: %s\n", val)
	}

	return loanApp
}
