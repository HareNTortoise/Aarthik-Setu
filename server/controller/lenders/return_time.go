package lenders

import (
	"bytes"
	"io"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

// GetLendersForProfile handles the request to get lender details based on loan application.
func EstimateLoanTime(c *gin.Context) {
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

	// Retrieve loan application details
	loanApp, err := RetrieveLoanApplication(profileID, applicationID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Log the incoming request body
	body, err := io.ReadAll(c.Request.Body)
	if err != nil {
		log.Printf("Error reading request body: %v\n", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Failed to read request"})
		return
	}

	// Reset the body so it can be read again
	c.Request.Body = io.NopCloser(bytes.NewBuffer(body))
	log.Printf("Received request body: %s\n", body)

	// Retrieve the single lender's details from the request body
	var lender Lender
	if err := c.BindJSON(&lender); err != nil {
		log.Printf("Error binding JSON: %v\n", err)                // Log the error for debugging
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()}) // Return specific error
		return
	}

	estimatedTime, minMonthlyPayment, maxMonthlyPayment, minAmortizationSchedule, err := EstimateLoanRepaymentTime(lender, loanApp)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Respond with estimated repayment time, monthly payments, and amortization schedule
	c.JSON(http.StatusOK, gin.H{
		"estimated_time":            estimatedTime,
		"min_monthly_payment":       minMonthlyPayment,
		"max_monthly_payment":       maxMonthlyPayment,
		"min_amortization_schedule": minAmortizationSchedule,
		// "max_amortization_schedule": minAmortizationSchedule,
		// Note: You can also include maxAmortizationSchedule if needed
	})
}
