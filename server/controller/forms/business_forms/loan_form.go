package business_forms

import (
	"context"
	"net/http"
	utils "server/config/firebase"
	model "server/models/forms/business_forms" // Update with your actual model package path

	"cloud.google.com/go/firestore"
	"github.com/gin-gonic/gin"
)

// var client *firestore.Client // Assume you have initialized Firestore client elsewhere

func init() {
	client = utils.InitFirestore() // Initialize Firestore client
}

func SubmitLoanApplicationDetails(c *gin.Context) {
	userID := c.Param("userId")
	loanID := c.Param("loanId")
	ctx := context.Background()

	// Bind the request to LoanApplication model
	var loanApplication model.LoanApplication
	if err := c.ShouldBindJSON(&loanApplication); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	// Store the loan application in Firestore
	docRef := client.Collection("business_loan_applications").Doc(userID).Collection("applications").Doc(loanID)
	_, err := docRef.Set(ctx, map[string]interface{}{
		"loanPurpose":        loanApplication.LoanPurpose,
		"loanAmountRequired": loanApplication.LoanAmountRequired,
		"tenure":             loanApplication.Tenure,
		"retirementAge":      loanApplication.RetirementAge,
		"q1":                 loanApplication.Q1,
		"q2":                 loanApplication.Q2,
		"q3":                 loanApplication.Q3,
		"q4":                 loanApplication.Q4,
		"q5":                 loanApplication.Q5,
		"repaymentMethod":    loanApplication.RepaymentMethod,
	})
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to submit loan application", "details": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "Loan application submitted successfully"})
}

func GetLoanApplicationDetails(c *gin.Context) {
	userID := c.Param("userId")
	loanID := c.Param("loanId")
	ctx := context.Background()

	docRef := client.Collection("business_loan_applications").Doc(userID).Collection("applications").Doc(loanID)
	doc, err := docRef.Get(ctx)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Loan application not found"})
		return
	}

	var loanApplication model.LoanApplication
	if err := doc.DataTo(&loanApplication); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse loan application", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, loanApplication)
}

func UpdateLoanApplicationDetails(c *gin.Context) {
	userID := c.Param("userId")
	loanID := c.Param("loanId")
	ctx := context.Background()

	var loanApplication model.LoanApplication
	if err := c.ShouldBindJSON(&loanApplication); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	docRef := client.Collection("business_loan_applications").Doc(userID).Collection("applications").Doc(loanID)
	_, err := docRef.Set(ctx, map[string]interface{}{
		"loanPurpose":        loanApplication.LoanPurpose,
		"loanAmountRequired": loanApplication.LoanAmountRequired,
		"tenure":             loanApplication.Tenure,
		"retirementAge":      loanApplication.RetirementAge,
		"q1":                 loanApplication.Q1,
		"q2":                 loanApplication.Q2,
		"q3":                 loanApplication.Q3,
		"q4":                 loanApplication.Q4,
		"q5":                 loanApplication.Q5,
		"repaymentMethod":    loanApplication.RepaymentMethod,
	}, firestore.MergeAll) // Use MergeAll to update specific fields
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update loan application", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Loan application updated successfully"})
}

func DeleteLoanApplicationDetails(c *gin.Context) {
	userID := c.Param("userId")
	loanID := c.Param("loanId")
	ctx := context.Background()

	docRef := client.Collection("business_loan_applications").Doc(userID).Collection("applications").Doc(loanID)
	_, err := docRef.Delete(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete loan application", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Loan application deleted successfully"})
}
