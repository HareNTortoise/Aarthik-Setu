package business_forms

import (
	"context"
	"encoding/json"
	"net/http"
	utils "server/config/firebase"
	model "server/models/forms/business_forms"
	"time"

	"cloud.google.com/go/firestore"
	"github.com/gin-gonic/gin"
)

// Initialize Firestore client
// var client *firestore.Client

func init() {
	client = utils.InitFirestore()
}

// CreateGSTDetails handles the creation of GST details for a business (form-data).
func CreateGSTDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")

	// Context for Firestore
	ctx := context.Background()

	// Check if the GST details already exist
	query := client.Collection("business_gst_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)
	existingDocs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to check existing GST details", "details": err.Error()})
		return
	}
	if len(existingDocs) > 0 {
		// If details are already present, return an error
		c.JSON(http.StatusConflict, gin.H{"error": "GST Details already exist"})
		return
	}

	// Extract GST details from form-data
	businessID := c.PostForm("business_id")
	gstNumbers := c.PostFormArray("gst_number") // Changed to PostFormArray
	userNames := c.PostFormArray("user_name")   // Changed to PostFormArray
	filingStatus := c.PostForm("filing_status")

	// Create a GSTDetail struct
	gstDetail := model.GSTDetails{
		BusinessID:   businessID,
		GSTNumber:    gstNumbers, // Use the slice directly
		UserName:     userNames,  // Use the slice directly
		FilingStatus: filingStatus,
		CreatedAt:    time.Now(),
	}

	// Marshal the GST details to JSON and then into a map
	gstDetailsMap := map[string]interface{}{}
	data, err := json.Marshal(gstDetail)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to marshal GST details to JSON", "details": err.Error()})
		return
	}
	// Unmarshal JSON back into a map to ensure lowercase keys
	if err := json.Unmarshal(data, &gstDetailsMap); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to unmarshal JSON to map", "details": err.Error()})
		return
	}
	formId, err := utils.GenerateRandomString(16)

	// Add the GST details to Firestore
	_, _, err = client.Collection("business_gst_details").Add(ctx, map[string]interface{}{
		"gst_details":   gstDetailsMap,
		"profileId":     profileId,
		"applicationId": applicationId,
		"formId":        formId,
	})
	err = utils.UpdateFirestoreDocument(ctx, "applications", applicationId, "business_gst_form_id", formId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update application with formId", "details": err.Error()})
		return
	}
	// Check for errors in Firestore operation
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to add GST details to Firestore", "details": err.Error()})
		return
	}

	// Return success response
	c.JSON(http.StatusCreated, gin.H{"gst_details": gstDetail, "message": "GST details created successfully"})
}

// GetGSTDetails retrieves the GST details for a specific business from Firestore.
func GetGSTDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Query Firestore to retrieve the GST details for the business
	query := client.Collection("business_gst_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)
	docs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve GST details", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No GST details found for this business"})
		return
	}

	// Assuming one document per business, retrieve the first one
	gstDetails := docs[0].Data()["gst_details"].(map[string]interface{})
	formId := docs[0].Data()["formId"]

	// Return the GST details in the response
	c.JSON(http.StatusOK, gin.H{"gst_details": gstDetails, "formId": formId})
}

// UpdateGSTDetails updates the GST details for a specific business.
func UpdateGSTDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Extract new GST details from form-data
	gstNumbers := c.PostFormArray("gst_number") // Changed to PostFormArray
	userNames := c.PostFormArray("user_name")   // Changed to PostFormArray
	filingStatus := c.PostForm("filing_status")

	// Create a GSTDetail struct
	updatedGSTDetail := model.GSTDetails{
		GSTNumber:    gstNumbers, // Use the slice directly
		UserName:     userNames,  // Use the slice directly
		FilingStatus: filingStatus,
	}

	// Query Firestore to find the business's document
	query := client.Collection("business_gst_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)
	docs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to query GST details", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No GST details found for this business"})
		return
	}

	// Update the document with new GST details
	docRef := docs[0].Ref
	_, err = docRef.Update(ctx, []firestore.Update{
		{Path: "gst_details", Value: updatedGSTDetail},
	})

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update GST details", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"gst_details": updatedGSTDetail, "message": "GST details updated successfully"})
}

// DeleteGSTDetails deletes the GST details for a specific business.
func DeleteGSTDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Query Firestore to find the business's document
	query := client.Collection("business_gst_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)
	docs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to query GST details", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No GST details found for this business"})
		return
	}

	// Delete the document
	docRef := docs[0].Ref
	_, err = docRef.Delete(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete GST details", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "GST details deleted successfully"})
}
