package personal_forms

import (
	"context"
	utils "server/config/firebase"
	"github.com/gin-gonic/gin"
	"net/http"
	"cloud.google.com/go/firestore"
	// model "server/models/forms/personal_forms"
	"strings"
)

// var client *firestore.Client

func init() {
	client = utils.InitFirestore() // Initialize Firestore client
}

func CreateLoanDetails(c *gin.Context) {
	userID := c.Param("userId")
	ctx := context.Background()

	// Extract form-data arrays for multiple loan entries
	loanTypes := c.PostFormArray("loanType")
	lenders := c.PostFormArray("lender")
	sanctionedAmounts := c.PostFormArray("sanctionedAmount")
	outstandingAmounts := c.PostFormArray("outstandingAmount")
	emiAmounts := c.PostFormArray("emiAmount")

	// Ensure all arrays have the same length
	if len(loanTypes) != len(lenders) || len(lenders) != len(sanctionedAmounts) ||
		len(sanctionedAmounts) != len(outstandingAmounts) || len(outstandingAmounts) != len(emiAmounts) {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Mismatched array lengths for loan details"})
		return
	}

	// Build an array of loan details from the form-data arrays
	var loans []map[string]interface{}
	for i := range loanTypes {
		loan := map[string]interface{}{
			"loanType":          loanTypes[i],
			"lender":            lenders[i],
			"sanctionedAmount":  sanctionedAmounts[i],
			"outstandingAmount": outstandingAmounts[i],
			"emiAmount":         emiAmounts[i],
		}
		loans = append(loans, loan)
	}

	// Retrieve the current user loans
	docRef := client.Collection("loan_details").Doc(userID)
	_, err := docRef.Get(ctx)
	if err != nil && strings.Contains(err.Error(), "not found") {
		// If user doesn't exist, create a new record with camelCase keys in map
		_, err = docRef.Set(ctx, map[string]interface{}{
			"userId": userID,   // Explicitly setting to camelCase
			"loans":  loans,
		})
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create loan details", "details": err.Error()})
			return
		}
	} else if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve loan details", "details": err.Error()})
		return
	} else {
		// If the user already exists, prevent adding new loan details
		c.JSON(http.StatusConflict, gin.H{"error": "Loan details already exist for this user"})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "Loan details created successfully"})
}


func GetCreditInfo(c *gin.Context) {
	userID := c.Param("userId")
	ctx := context.Background()

	// Retrieve user loan details from Firestore
	docRef := client.Collection("loan_details").Doc(userID)
	doc, err := docRef.Get(ctx)
	if err != nil {
		if strings.Contains(err.Error(), "not found") {
			c.JSON(http.StatusNotFound, gin.H{"error": "No loan details found for this user"})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve loan details", "details": err.Error()})
		return
	}

	// Convert the document to a map
	var userCreditInfo map[string]interface{}
	if err := doc.DataTo(&userCreditInfo); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse loan details", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, userCreditInfo)
}

func UpdateCreditInfo(c *gin.Context) {
	userID := c.Param("userId")
	ctx := context.Background()

	// Extract form-data arrays for multiple loan entries
	loanTypes := c.PostFormArray("loanType")
	lenders := c.PostFormArray("lender")
	sanctionedAmounts := c.PostFormArray("sanctionedAmount")
	outstandingAmounts := c.PostFormArray("outstandingAmount")
	emiAmounts := c.PostFormArray("emiAmount")

	// Ensure all arrays have the same length
	if len(loanTypes) != len(lenders) || len(lenders) != len(sanctionedAmounts) ||
		len(sanctionedAmounts) != len(outstandingAmounts) || len(outstandingAmounts) != len(emiAmounts) {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Mismatched array lengths for loan details"})
		return
	}

	// Build an array of loan details from the form-data arrays
	var loans []map[string]interface{}
	for i := range loanTypes {
		loan := map[string]interface{}{
			"loanType":          loanTypes[i],
			"lender":            lenders[i],
			"sanctionedAmount":  sanctionedAmounts[i],
			"outstandingAmount": outstandingAmounts[i],
			"emiAmount":         emiAmounts[i],
		}
		loans = append(loans, loan)
	}

	// Update the user's loan details
	docRef := client.Collection("loan_details").Doc(userID)
	_, err := docRef.Set(ctx, map[string]interface{}{
		"userId": userID,
		"loans":  loans,
	}, firestore.MergeAll) // Merge to keep existing fields if needed
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update loan details", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Loan details updated successfully"})
}

func DeleteCreditInfo(c *gin.Context) {
	userID := c.Param("userId")
	ctx := context.Background()

	// Delete user loan details from Firestore
	docRef := client.Collection("loan_details").Doc(userID)
	_, err := docRef.Delete(ctx)
	if err != nil {
		if strings.Contains(err.Error(), "not found") {
			c.JSON(http.StatusNotFound, gin.H{"error": "No loan details found for this user"})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete loan details", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Loan details deleted successfully"})
}
