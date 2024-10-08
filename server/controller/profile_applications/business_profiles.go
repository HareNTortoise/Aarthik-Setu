package profile_applications

import (
	"context"
	"net/http"
	utils "server/config/firebase"
	"time"

	"cloud.google.com/go/firestore"
	"github.com/gin-gonic/gin"
)

var client *firestore.Client

func init() {
	client = utils.InitFirestore() // Initialize Firestore client
}

// Create new Profile
func CreateBusinessProfile(c *gin.Context) {
	userId := c.Param("userId")
	name := c.PostForm("name")
	pan := c.PostForm("pan")
	ctx := context.Background()

	id, _ := utils.GenerateRandomString(16)
	// Check if the user's bank details already exist
	query := client.Collection("business_profiles").
		Where("pan", "==", pan).
		Where("userId", "==", userId).
		Documents(ctx)
	existingDocs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to check existing profile", "details": err.Error()})
		return
	}
	if len(existingDocs) > 0 {
		// If details are already present, return an error
		c.JSON(http.StatusConflict, gin.H{"error": "Profile already exists"})
		return
	}
	createdAt := time.Now()
	_, err = client.Collection("business_profiles").Doc(id).Set(ctx, map[string]interface{}{
		"userId":    userId,
		"id":        id,
		"name":      name,
		"pan":       pan,
		"createdAt": createdAt,
		"updatedAt": createdAt,
	})
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create profile", "details": err.Error()})
		return
	}

	// Return created profile data
	c.JSON(http.StatusCreated, gin.H{
		"message": "Profile created successfully",
		"profile": map[string]interface{}{
			"userId":    userId,
			"id":        id,
			"name":      name,
			"pan":       pan,
			"createdAt": createdAt,
			"updatedAt": createdAt,
		},
	})
}

func GetBusinessProfiles(c *gin.Context) {
	userId := c.Param("userId")
	ctx := context.Background()

	// Query profiles by userId
	query := client.Collection("business_profiles").Where("userId", "==", userId).Documents(ctx)
	profiles, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve profiles", "details": err.Error()})
		return
	}

	if len(profiles) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No profiles found"})
		return
	}

	// Prepare response
	var result []map[string]interface{}
	for _, doc := range profiles {
		result = append(result, doc.Data())
	}

	c.JSON(http.StatusOK, result)
}

func UpdateBusinessProfile(c *gin.Context) {
	userId := c.Param("userId")
	id := c.Param("profileId")
	name := c.PostForm("name")
	pan := c.PostForm("pan")
	ctx := context.Background()

	// Check if the profile exists
	docRef := client.Collection("business_profiles").Doc(id)
	doc, err := docRef.Get(ctx)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Profile not found", "details": err.Error()})
		return
	}

	// Ensure the profile belongs to the correct user
	if doc.Data()["userId"] != userId {
		c.JSON(http.StatusForbidden, gin.H{"error": "You are not authorized to update this profile"})
		return
	}

	// Update profile fields
	updatedAt := time.Now()
	_, err = docRef.Update(ctx, []firestore.Update{
		{Path: "name", Value: name},
		{Path: "pan", Value: pan},
		{Path: "updatedAt", Value: updatedAt},
	})
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update profile", "details": err.Error()})
		return
	}

	// Prepare the updated profile data
	updatedProfile := map[string]interface{}{
		"userId":    userId,
		"id":        id,
		"name":      name,
		"pan":       pan,
		"createdAt": doc.Data()["createdAt"],
		"updatedAt": updatedAt,
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "Profile updated successfully",
		"profile": updatedProfile,
	})
}

func DeleteBusinessProfile(c *gin.Context) {
	userId := c.Param("userId")
	id := c.Param("profileId")
	ctx := context.Background()

	// Check if id is empty
	if id == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Profile ID cannot be empty"})
		return
	}

	// Get the document reference
	docRef := client.Collection("business_profiles").Doc(id)
	doc, err := docRef.Get(ctx)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Profile not found", "details": err.Error()})
		return
	}

	// Ensure the profile belongs to the correct user
	if doc.Data()["userId"] != userId {
		c.JSON(http.StatusForbidden, gin.H{"error": "You are not authorized to delete this profile"})
		return
	}

	// Delete the profile
	_, err = docRef.Delete(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete profile", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Profile deleted successfully"})
}
