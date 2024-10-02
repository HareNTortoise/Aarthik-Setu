package business_forms

import (
	"context"
	"log"
	"net/http"
	"strconv"
	"time"

	utils "server/config/firebase"
	model "server/models/forms/business_forms"

	"cloud.google.com/go/firestore"
	"github.com/gin-gonic/gin"
)

// Initialize Firestore client
var client *firestore.Client

func init() {
	client = utils.InitFirestore()
}

// CreateDeclareGSTBusinessDetails handles creating business details.
func CreateDeclareGSTBusinessDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Extract business details from form-data
	businessID := c.PostForm("business_id")
	constitution := c.PostForm("constitution")
	state := c.PostForm("state")
	city := c.PostForm("city")

	numberOfCustomers, err := strconv.Atoi(c.PostForm("number_of_customers"))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid number of customers"})
		return
	}

	PAN := c.PostForm("pan")
	highestSale, err := strconv.ParseFloat(c.PostForm("highest_sale"), 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid highest sale value"})
		return
	}

	// Parse month-wise sales data from form (optional sales data)
	sales := make(map[string]float64)
	months := []string{
		"January", "February", "March", "April", "May", "June",
		"July", "August", "September", "October", "November", "December",
	}

	// Loop through each month and only add sales data if provided
	for _, month := range months {
		saleStr := c.PostForm("sales[" + month + "]")
		if saleStr != "" {
			sale, err := strconv.ParseFloat(saleStr, 64)
			if err != nil {
				c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid sales data for " + month})
				return
			}
			sales[month] = sale
		}
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
		Sales:             sales,
		CreatedAt:         time.Now(),
		UpdatedAt:         time.Now(),
	}

	// Add the business details to Firestore
	formId, _ := utils.GenerateRandomString(16)
	_, _, err = client.Collection("declare_business_details").Add(ctx, map[string]interface{}{
		"declare_business_details": businessDetail,
		"profileId":                profileId,
		"applicationId":            applicationId,
		"formId":                   formId,
	})

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to add business details to Firestore", "details": err.Error()})
		return
	}

	err = utils.UpdateFirestoreDocument(ctx, "applications", applicationId, "business_details_form_id", formId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update application with formId", "details": err.Error()})
		return
	}

	// Return success response with created business details
	c.JSON(http.StatusCreated, gin.H{"message": "Business details created successfully", "businessDetails": businessDetail})
}

// GetDeclareGSTBusinessDetails handles retrieving business details by profile and application ID.
func GetDeclareGSTBusinessDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	log.Printf("Fetching business details for profileId: %s, applicationId: %s", profileId, applicationId)

	// Query Firestore for the business details
	iter := client.Collection("declare_business_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).Documents(ctx)

	doc, err := iter.Next()
	if err != nil {
		log.Printf("Error fetching business details for profileId: %s, applicationId: %s, error: %v", profileId, applicationId, err)
		c.JSON(http.StatusNotFound, gin.H{"error": "Business details not found"})
		return
	}

	log.Printf("Document found for profileId: %s, applicationId: %s", profileId, applicationId)

	// Get the raw document data
	data := doc.Data()
	declareBusinessDetails, ok := data["declare_business_details"].(map[string]interface{})
	if !ok {
		log.Printf("Error: 'declare_business_details' field not found or not a map in document for profileId: %s, applicationId: %s", profileId, applicationId)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "'declare_business_details' field is missing or invalid"})
		return
	}

	// Return the business details
	c.JSON(http.StatusOK, declareBusinessDetails)
}

// UpdateDeclareGSTBusinessDetails updates the business details for a specific business.
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
	query := client.Collection("declare_business_details").
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
		{Path: "declare_business_details", Value: updatedBusinessDetail},
	})

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update business details", "details": err.Error()})
		return
	}

	// Return success response with updated business details
	c.JSON(http.StatusOK, gin.H{"message": "Business details updated successfully", "businessDetails": updatedBusinessDetail})
}

// DeleteDeclareGSTBusinessDetails deletes the business details for a specific business.
func DeleteDeclareGSTBusinessDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Query Firestore to find the business's document
	query := client.Collection("declare_business_details").
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
