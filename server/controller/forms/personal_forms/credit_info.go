package personal_forms

import (
	"context"
	utils "server/config/firebase"
	"github.com/gin-gonic/gin"
	"net/http"
	"cloud.google.com/go/firestore"
	// model "server/models/forms/personal_forms"
	"time"
	"strings"
)

// var client *firestore.Client

func init() {
	client = utils.InitFirestore() // Initialize Firestore client
}

func CreateLoanDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId") // Assuming you want to use applicationId from the route parameters
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

	// Generate a random form ID
	formId, _ := utils.GenerateRandomString(16)

	// Retrieve or create loan details for the user
	docRef := client.Collection("personal_credit_info").Doc(profileId) // Use profileId as the document ID
	_, err := docRef.Get(ctx)
	if err != nil && strings.Contains(err.Error(), "not found") {
		// If the document doesn't exist, create a new one
		_, err = docRef.Set(ctx, map[string]interface{}{
			"loans":         loans,
			"profileId":     profileId,
			"applicationId": applicationId,
			"formId":        formId, // Use the generated form ID
			"timestamp":     time.Now(),
		})
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create loan details", "details": err.Error()})
			return
		}
	} else if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve loan details", "details": err.Error()})
		return
	} else {
		// If the document already exists, prevent adding new loan details
		c.JSON(http.StatusConflict, gin.H{"error": "Loan details already exist for this profile"})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "Loan details created successfully"})
}




func GetCreditInfo(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Query Firestore for loan details using profileId and applicationId
	query := client.Collection("personal_credit_info").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Limit(1) // Limit to one document since profileId and applicationId should be unique together

	docs, err := query.Documents(ctx).GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve loan details", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No loan details found for this profileId and applicationId"})
		return
	}

	// Convert the document to a map
	var userCreditInfo map[string]interface{}
	if err := docs[0].DataTo(&userCreditInfo); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse loan details", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, userCreditInfo)
}

func UpdateCreditInfo(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
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

	// Retrieve the user's loan details
	docRef := client.Collection("personal_credit_info").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Limit(1)

	// Get all matching documents
	docs, err := docRef.Documents(ctx).GetAll()
	if err != nil || len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "Loan details not found"})
		return
	}

	// Assuming we found the document, get the first one
	doc := docs[0]

	// Retrieve existing fields
	existingData := doc.Data()
	formId := existingData["formId"].(string)
	existingProfileId := existingData["profileId"].(string)
	existingApplicationId := existingData["applicationId"].(string)

	// Update the document while keeping profileId, applicationId, and formId unchanged
	_, err = client.Collection("personal_credit_info").Doc(doc.Ref.ID).Set(ctx, map[string]interface{}{
		"loans":             loans,
		"profileId":         existingProfileId,      // Keep existing profileId
		"applicationId":     existingApplicationId,  // Keep existing applicationId
		"formId":            formId,                 // Keep existing formId
		"timestamp":         time.Now(),             // Update timestamp to now
	}, firestore.MergeAll) // Merge to keep existing fields if needed
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update loan details", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Loan details updated successfully"})
}



func DeleteCreditInfo(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Query Firestore for loan details using profileId and applicationId
	query := client.Collection("personal_credit_info").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Limit(1) // Limit to one document

	docs, err := query.Documents(ctx).GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve loan details", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No loan details found for this profileId and applicationId"})
		return
	}

	// Delete the loan details document
	_, err = docs[0].Ref.Delete(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete loan details", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Loan details deleted successfully"})
}
