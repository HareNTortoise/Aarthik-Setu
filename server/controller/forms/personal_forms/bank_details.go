package personal_forms

import (
	"context"
	"encoding/json"
	"net/http"
	utils "server/config/firebase"
	model "server/models/forms/personal_forms"
	"time"
	"cloud.google.com/go/firestore"
	"github.com/gin-gonic/gin"
)

var client *firestore.Client

func init() {
	client = utils.InitFirestore() // Initialize Firestore client
}

// CreateBankDetails handles the creation of bank details for a user (form-data).
func CreateBankDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")

	// Context for Firestore
	ctx := context.Background()

	// Check if the user's bank details already exist
	query := client.Collection("personal_bank_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)
	existingDocs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to check existing bank details", "details": err.Error()})
		return
	}
	if len(existingDocs) > 0 {
		// If details are already present, return an error
		c.JSON(http.StatusConflict, gin.H{"error": "Bank Details already exist"})
		return
	}

	// Extract bank details from form-data
	bankNames := c.PostFormArray("bank_name")
	joiningMonths := c.PostFormArray("joining_month")
	joiningYears := c.PostFormArray("joining_year")

	// Ensure that the number of entries for each field matches
	if len(bankNames) != len(joiningMonths) || len(bankNames) != len(joiningYears) {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Mismatched form data lengths"})
		return
	}

	// Create a slice of BankDetail structs
	var bankDetails []model.BankDetail
	for i := range bankNames {
		bankDetail := model.BankDetail{
			BankName:     bankNames[i],
			JoiningMonth: joiningMonths[i],
			JoiningYear:  joiningYears[i],
		}
		bankDetails = append(bankDetails, bankDetail)
	}

	// Marshal the bankDetails slice to JSON and then into a map
	bankDetailsMap := []map[string]interface{}{}
	data, err := json.Marshal(bankDetails)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to marshal bank details to JSON", "details": err.Error()})
		return
	}
	// Unmarshal JSON back into a map to ensure lowercase keys
	if err := json.Unmarshal(data, &bankDetailsMap); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to unmarshal JSON to map", "details": err.Error()})
		return
	}
	formId, err := utils.GenerateRandomString(16)
	// Add the bank details to Firestore
	_, _, err = client.Collection("personal_bank_details").Add(ctx, map[string]interface{}{
		"bank_details": bankDetailsMap,
		"profileId":       profileId,
		"applicationId": applicationId,
		"formId": formId,
		"timestamp":time.Now(),
	})

	// Check for errors in Firestore operation
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to add bank details to Firestore", "details": err.Error()})
		return
	}
	err= utils.UpdateFirestoreDocument(ctx, "applications", applicationId, "bank_details_form_id", formId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update application with formId", "details": err.Error()})
		return
	}
	// Return success response
	c.JSON(http.StatusCreated, gin.H{"message": "Bank details created successfully"})
}

// GetBankDetails retrieves the bank details for a specific user from Firestore.
func GetBankDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Query Firestore to retrieve the bank details for the user
	query := client.Collection("personal_bank_details").
	Where("profileId", "==", profileId).
	Where("applicationId","==",applicationId).
	Documents(ctx)
	docs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve bank details", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No bank details found for this user"})
		return
	}

	// Assuming one document per user, retrieve the first one
	bankDetails := docs[0].Data()["bank_details"]
	formId := docs[0].Data()["formId"]

	// Return the bank details in the response
	c.JSON(http.StatusOK, gin.H{"bank_details": bankDetails,
		"formId": formId})
}

// UpdateBankDetails updates the bank details for a specific user.
func UpdateBankDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Extract new bank details from form-data
	bankNames := c.PostFormArray("bank_name")
	joiningMonths := c.PostFormArray("joining_month")
	joiningYears := c.PostFormArray("joining_year")

	// Ensure that the number of entries for each field matches
	if len(bankNames) != len(joiningMonths) || len(bankNames) != len(joiningYears) {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Mismatched form data lengths"})
		return
	}

	// Create a slice of BankDetail structs
	var updatedBankDetails []model.BankDetail
	for i := range bankNames {
		bankDetail := model.BankDetail{
			BankName:     bankNames[i],
			JoiningMonth: joiningMonths[i],
			JoiningYear:  joiningYears[i],
		}
		updatedBankDetails = append(updatedBankDetails, bankDetail)
	}

	// Query Firestore to find the user's document
	query := client.Collection("personal_bank_details").
	Where("profileId", "==", profileId).
	Where("applicationId","==",applicationId).
	Documents(ctx)
	docs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to query bank details", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No bank details found for this user"})
		return
	}

	// Update the document with new bank details
	docRef := docs[0].Ref
	_, err = docRef.Set(ctx, map[string]interface{}{
		"bank_details": updatedBankDetails,
		"timestamp":    time.Now(),
	}, firestore.MergeAll)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update bank details", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Bank details updated successfully"})
}

// DeleteBankDetails deletes the bank details for a specific user.
func DeleteBankDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Query Firestore to find the user's document
	query := client.Collection("personal_bank_details").
	Where("profileId", "==", profileId).
	Where("applicationId","==",applicationId).
	Documents(ctx)
	docs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to query bank details", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No bank details found for this user"})
		return
	}

	// Delete the document
	docRef := docs[0].Ref
	_, err = docRef.Delete(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete bank details", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Bank details deleted successfully"})
}
