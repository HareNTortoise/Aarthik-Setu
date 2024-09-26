package business_forms

import (
	"context"
	"encoding/json"
	"log"
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

func CreateDeclareGSTBusinessDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")

	// Context for Firestore
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
		"January", "February", "March", "April", "May", "June", "July",
		"August", "September", "October", "November", "December",
	}

	// Loop through each month and only add sales data if provided
	for _, month := range months {
		saleStr := c.PostForm("sales[" + month + "]")
		if saleStr != "" { // Only parse and add the sale if it exists in form-data
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
		Sales:             sales, // Only the provided months will be included in the map
		CreatedAt:         time.Now(),
		UpdatedAt:         time.Now(),
	}

	// Marshal the business details to JSON and store in Firestore
	businessDetailsMap := map[string]interface{}{}
	data, err := json.Marshal(businessDetail)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to marshal business details to JSON", "details": err.Error()})
		return
	}
	if err := json.Unmarshal(data, &businessDetailsMap); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to unmarshal JSON to map", "details": err.Error()})
		return
	}

	// Add the business details to Firestore
	_, _, err = client.Collection("declare_business_details").Add(ctx, map[string]interface{}{
		"declare_business_details": businessDetailsMap,
		"profileId":                profileId,
		"applicationId":            applicationId,
	})

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to add business details to Firestore", "details": err.Error()})
		return
	}

	// Return success response
	c.JSON(http.StatusCreated, gin.H{"message": "Business details created successfully"})
}

// GetDeclareGSTBusinessDetails handles retrieving business details by profile and application ID.
func GetDeclareGSTBusinessDetails(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")

	// Debugging: Log the profileId and applicationId being queried
	log.Printf("Fetching business details for profileId: %s, applicationId: %s", profileId, applicationId)

	// Context for Firestore
	ctx := context.Background()

	// Query Firestore for the business details
	iter := client.Collection("declare_business_details").Where("profileId", "==", profileId).Where("applicationId", "==", applicationId).Documents(ctx)
	doc, err := iter.Next()

	// Debugging: Check if the document query returned an error
	if err != nil {
		log.Printf("Error fetching business details for profileId: %s, applicationId: %s, error: %v", profileId, applicationId, err)
		c.JSON(http.StatusNotFound, gin.H{"error": "Business details not found"})
		return
	}

	// Debugging: Log that a document was found
	log.Printf("Document found for profileId: %s, applicationId: %s", profileId, applicationId)

	// Map the document data to a BusinessDetails struct
	var businessDetail model.BusinessDetails
	if err := doc.DataTo(&businessDetail); err != nil {
		// Debugging: Log the parsing error
		log.Printf("Error parsing business details for document with profileId: %s, applicationId: %s, error: %v", profileId, applicationId, err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse business details", "details": err.Error()})
		return
	}

	// Debugging: Log the successfully fetched business details
	log.Printf("Fetched business details: %+v", businessDetail)

	// Return the business details
	c.JSON(http.StatusOK, businessDetail)
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

	c.JSON(http.StatusOK, gin.H{"message": "Business details updated successfully"})
}

// DeleteBusinessDetails deletes the business details for a specific business.
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
