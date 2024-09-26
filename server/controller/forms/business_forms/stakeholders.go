package business_forms

import (
	"context"
	"encoding/json"
	"net/http"
	utils "server/config/firebase"
	model "server/models/forms/business_forms" // Adjust import based on actual file structure

	"cloud.google.com/go/firestore"
	"github.com/gin-gonic/gin"
)

// Initialize Firestore client
// var client *firestore.Client

func init() {
	client = utils.InitFirestore()
}

// CreateStakeholdersDetails handles the creation of stakeholder details for a business.
func CreateStakeholdersDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")

	// Context for Firestore
	ctx := context.Background()

	// Check if the stakeholder details already exist
	query := client.Collection("business_stakeholders_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)
	existingDocs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to check existing stakeholder details", "details": err.Error()})
		return
	}
	if len(existingDocs) > 0 {
		c.JSON(http.StatusConflict, gin.H{"error": "Stakeholder Details already exist"})
		return
	}

	// Parse the business details JSON data
	businessJSON := c.PostForm("business_details")
	var businessDetail model.BusinessDetail
	err = json.Unmarshal([]byte(businessJSON), &businessDetail)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid business details", "details": err.Error()})
		return
	}

	// Extract stakeholder details from form-data
	stakeholdersJSON := c.PostForm("stakeholders") // Expecting a JSON array as string
	var stakeholders []model.Stakeholder
	err = json.Unmarshal([]byte(stakeholdersJSON), &stakeholders)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid stakeholder details", "details": err.Error()})
		return
	}

	// Prepare data for Firestore
	formId, err := utils.GenerateRandomString(16)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to generate form ID", "details": err.Error()})
		return
	}

	// Add the stakeholder details to Firestore
	_, _, err = client.Collection("business_stakeholders_details").Add(ctx, map[string]interface{}{
		"business_details": businessDetail,
		"stakeholders":     stakeholders,
		"profileId":        profileId,
		"applicationId":    applicationId,
		"formId":           formId,
	})

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to add stakeholder details to Firestore", "details": err.Error()})
		return
	}

	// Return success response
	c.JSON(http.StatusCreated, gin.H{"message": "Stakeholder details created successfully"})
}

// GetStakeholdersDetails retrieves the stakeholder details for a specific business from Firestore.
func GetStakeholdersDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Query Firestore to retrieve the stakeholder details for the business
	query := client.Collection("business_stakeholders_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)
	docs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve stakeholder details", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No stakeholder details found for this business"})
		return
	}

	// Assuming one document per business, retrieve the first one
	doc := docs[0].Data()

	// Parse the Firestore document fields
	businessDetails, ok := doc["business_details"]
	if !ok {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Missing business details in Firestore document"})
		return
	}
	stakeholders, ok := doc["stakeholders"]
	if !ok {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Missing stakeholders in Firestore document"})
		return
	}
	formId, ok := doc["formId"]
	if !ok {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Missing formId in Firestore document"})
		return
	}

	// Return the stakeholder details in the response
	c.JSON(http.StatusOK, gin.H{
		"business_details": businessDetails,
		"stakeholders":     stakeholders,
		"formId":           formId,
	})
}

// UpdateStakeholdersDetails updates the stakeholder details for a specific business.
func UpdateStakeholdersDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Extract new stakeholder details from form-data
	stakeholdersJSON := c.PostForm("stakeholders") // Expecting a JSON array as string
	var updatedStakeholders []model.Stakeholder
	err := json.Unmarshal([]byte(stakeholdersJSON), &updatedStakeholders)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid stakeholder details", "details": err.Error()})
		return
	}

	// Query Firestore to find the business's document
	query := client.Collection("business_stakeholders_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)
	docs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to query stakeholder details", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No stakeholder details found for this business"})
		return
	}

	// Update the document with new stakeholder details
	docRef := docs[0].Ref
	_, err = docRef.Update(ctx, []firestore.Update{
		{Path: "stakeholders", Value: updatedStakeholders},
	})

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update stakeholder details", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Stakeholder details updated successfully"})
}

// DeleteStakeholdersDetails deletes the stakeholder details for a specific business.
func DeleteStakeholdersDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Query Firestore to find the business's document
	query := client.Collection("business_stakeholders_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)
	docs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to query stakeholder details", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No stakeholder details found for this business"})
		return
	}

	// Delete the document
	docRef := docs[0].Ref
	_, err = docRef.Delete(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete stakeholder details", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Stakeholder details deleted successfully"})
}
