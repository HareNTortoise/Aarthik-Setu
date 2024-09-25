package business_forms

import (
	"context"
	"encoding/json"
	"net/http"
	utils "server/config/firebase"
	model "server/models/forms/business_forms"
	"strconv"
	"time"

	"cloud.google.com/go/firestore"
	"github.com/gin-gonic/gin"
)

// Initialize Firestore client
// var client *firestore.Client

func init() {
	client = utils.InitFirestore()
}

// CreateBusinessDetails handles the creation of business details (form-data).
func CreateDeclareGSTBusinessDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")

	// Context for Firestore
	ctx := context.Background()

	// Check if the business details already exist
	query := client.Collection("business_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)
	existingDocs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to check existing business details", "details": err.Error()})
		return
	}
	if len(existingDocs) > 0 {
		// If details are already present, return an error
		c.JSON(http.StatusConflict, gin.H{"error": "Business Details already exist"})
		return
	}

	// Extract business details from form-data
	businessID := c.PostForm("business_id")
	constitution := c.PostForm("constitution")
	state := c.PostForm("state")
	city := c.PostForm("city")
	numberOfCustomersStr := c.PostForm("number_of_customers")
	PAN := c.PostForm("pan")
	highestSaleStr := c.PostForm("highest_sale")

	// Convert numberOfCustomers and highestSale from string to their respective types
	numberOfCustomers, err := strconv.Atoi(numberOfCustomersStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid number of customers", "details": err.Error()})
		return
	}

	highestSale, err := strconv.ParseFloat(highestSaleStr, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid highest sale", "details": err.Error()})
		return
	}

	// Create a BusinessDetails struct
	businessDetail := model.BusinessDetails{
		BusinessID:        businessID,
		Constitution:      constitution,
		State:             state,
		City:              city,
		NumberOfCustomers: numberOfCustomers,
		PAN:               PAN,
		HighestSale:       highestSale,
		Sales:             make(map[string]float64), // Initialize the sales map
		CreatedAt:         time.Now(),
		UpdatedAt:         time.Now(),
	}

	// Marshal the business details to JSON and then into a map
	businessDetailsMap := map[string]interface{}{}
	data, err := json.Marshal(businessDetail)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to marshal business details to JSON", "details": err.Error()})
		return
	}
	// Unmarshal JSON back into a map to ensure lowercase keys
	if err := json.Unmarshal(data, &businessDetailsMap); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to unmarshal JSON to map", "details": err.Error()})
		return
	}

	// Add the business details to Firestore
	_, _, err = client.Collection("business_details").Add(ctx, map[string]interface{}{
		"business_details": businessDetailsMap,
		"profileId":        profileId,
		"applicationId":    applicationId,
	})

	// Check for errors in Firestore operation
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to add business details to Firestore", "details": err.Error()})
		return
	}

	// Return success response
	c.JSON(http.StatusCreated, gin.H{"message": "Business details created successfully"})
}

// GetBusinessDetails retrieves the business details for a specific business from Firestore.
func GetDeclareGSTBusinessDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Query Firestore to retrieve the business details
	query := client.Collection("business_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)
	docs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve business details", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No business details found for this business"})
		return
	}

	// Assuming one document per business, retrieve the first one
	businessDetails := docs[0].Data()["business_details"].(map[string]interface{})

	// Return the business details in the response
	c.JSON(http.StatusOK, gin.H{"business_details": businessDetails})
}

// UpdateBusinessDetails updates the business details for a specific business.
func UpdateDeclareGSTBusinessDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Extract new business details from form-data
	businessID := c.PostForm("business_id")
	constitution := c.PostForm("constitution")
	state := c.PostForm("state")
	city := c.PostForm("city")
	numberOfCustomersStr := c.PostForm("number_of_customers")
	PAN := c.PostForm("pan")
	highestSaleStr := c.PostForm("highest_sale")

	// Convert numberOfCustomers and highestSale from string to their respective types
	numberOfCustomers, err := strconv.Atoi(numberOfCustomersStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid number of customers", "details": err.Error()})
		return
	}

	highestSale, err := strconv.ParseFloat(highestSaleStr, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid highest sale", "details": err.Error()})
		return
	}

	// Create a BusinessDetails struct for updating
	updatedBusinessDetail := model.BusinessDetails{
		BusinessID:        businessID,
		Constitution:      constitution,
		State:             state,
		City:              city,
		NumberOfCustomers: numberOfCustomers,
		PAN:               PAN,
		HighestSale:       highestSale,
		UpdatedAt:         time.Now(),
	}

	// Query Firestore to find the business's document
	query := client.Collection("business_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)
	docs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to query business details", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No business details found for this business"})
		return
	}

	// Update the document with new business details
	docRef := docs[0].Ref
	_, err = docRef.Update(ctx, []firestore.Update{
		{Path: "business_details", Value: updatedBusinessDetail},
	})

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update business details", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Business details updated successfully"})
}

// DeleteBusinessDetails deletes the business details for a specific business.
func DeleteDeclareGSTBusinessDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Query Firestore to find the business's document
	query := client.Collection("business_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)
	docs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to query business details", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No business details found for this business"})
		return
	}

	// Delete the document
	docRef := docs[0].Ref
	_, err = docRef.Delete(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete business details", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Business details deleted successfully"})
}
