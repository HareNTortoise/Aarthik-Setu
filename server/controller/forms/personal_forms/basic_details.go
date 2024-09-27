package personal_forms

import (
	"context"
	"net/http"
	utils "server/config/firebase"
	model "server/models/forms/personal_forms"
	"time"
	"strconv"
	"cloud.google.com/go/firestore"
	"github.com/gin-gonic/gin"
	"log"
)

// var client *firestore.Client

func init() {
	client = utils.InitFirestore() // Initialize Firestore client
}
func getStringPointer(value string) *string {
	if value == "" {
		return nil
	}
	return &value
}
func ParseDate(dateStr string) (time.Time, error) {
	return time.Parse("2006-01-02", dateStr) // Adjust the layout according to the date format used in your form
}
func convertUserDetailToMap(userDetail model.UserDetail) map[string]interface{} {
	return map[string]interface{}{
		"salutation":               userDetail.Salutation,
		"firstName":                userDetail.FirstName,
		"middleName":               userDetail.MiddleName,
		"lastName":                 userDetail.LastName,
		"dob":                      userDetail.Dob,
		"pan":                      userDetail.Pan,
		"gender":                   userDetail.Gender,
		"category":                 userDetail.Category,
		"mobile":                   userDetail.Mobile,
		"telephone":                userDetail.Telephone,
		"emailPersonal":            userDetail.EmailPersonal,
		"fatherName":               userDetail.FatherName,
		"educationQualification":   userDetail.EducationQualification,
		"netWorth":                 userDetail.NetWorth,
		"nationality":              userDetail.Nationality,
		"dependent":                userDetail.Dependent,
		"maritalStatus":            userDetail.MaritalStatus,
		"profileId":                userDetail.ProfileId,
		"applicationId":            userDetail.ApplicationId,
		"timestamp":                userDetail.Timestamp,
		"formId":                   userDetail.FormId,
	}
}


func CreateUserDetail(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	log.Println("profileId", profileId)
	log.Println("applicationId", applicationId)
	// Create a UserDetail instance
	var userDetail model.UserDetail

	// Manually extract form data
	userDetail.Salutation = c.PostForm("salutation")
	userDetail.FirstName = c.PostForm("firstName")
	userDetail.MiddleName = getStringPointer(c.PostForm("middleName"))
	userDetail.LastName = c.PostForm("lastName")
	userDetail.Dob, _ = ParseDate(c.PostForm("dob")) // Assuming the date format is YYYY-MM-DD
	userDetail.Pan = c.PostForm("pan")
	userDetail.Gender = c.PostForm("gender")
	userDetail.Category = c.PostForm("category")
	userDetail.Mobile = c.PostForm("mobile")
	userDetail.Telephone = c.PostForm("telephone")
	userDetail.EmailPersonal = c.PostForm("emailPersonal")
	userDetail.FatherName = c.PostForm("fatherName")
	userDetail.EducationQualification = c.PostForm("educationQualification")
	netWorthStr := c.PostForm("netWorth")
	if netWorth, err := strconv.ParseFloat(netWorthStr, 64); err == nil {
		userDetail.NetWorth = netWorth
	}
	userDetail.Nationality = c.PostForm("nationality")
	userDetail.Dependent = c.PostForm("dependent")
	userDetail.MaritalStatus = c.PostForm("maritalStatus")
	userDetail.ProfileId = profileId
	userDetail.ApplicationId = applicationId
	userDetail.Timestamp = time.Now()
	userDetail.FormId, _ = utils.GenerateRandomString(16) // Generate formId

	// Context for Firestore
	ctx := context.Background()

	// Query the database to check if the user detail already exists for the profileId and applicationId
	query := client.Collection("personal_basic_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)

	existingDocs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to check existing user details", "details": err.Error()})
		return
	}

	if len(existingDocs) > 0 {
		// If user details already exist, return an error
		c.JSON(http.StatusConflict, gin.H{"error": "User details already exist for the given profileId and applicationId"})
		return
	}

	// Add the new user detail to Firestore
	_,_, err = client.Collection("personal_basic_details").Add(ctx, convertUserDetailToMap(userDetail))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create user detail", "details": err.Error()})
		return
	}

	// Return success response
	c.JSON(http.StatusCreated, gin.H{"message": "User detail created successfully"})
}



func GetUserDetail(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Query Firestore using profileId and applicationId
	query := client.Collection("personal_basic_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)

	docs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve user detail", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "User detail not found"})
		return
	}

	var userDetail model.UserDetail
	if err := docs[0].DataTo(&userDetail); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse user detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, userDetail)
}
func UpdateUserDetail(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")

	// Create a UserDetail instance
	var userDetail model.UserDetail

	// Manually extract form data
	userDetail.Salutation = c.PostForm("salutation")
	userDetail.FirstName = c.PostForm("firstName")
	userDetail.MiddleName = getStringPointer(c.PostForm("middleName"))
	userDetail.LastName = c.PostForm("lastName")
	var err error
	userDetail.Dob, err = ParseDate(c.PostForm("dob")) // Assuming the date format is YYYY-MM-DD
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid date format", "details": err.Error()})
		return
	}
	userDetail.Pan = c.PostForm("pan")
	userDetail.Gender = c.PostForm("gender")
	userDetail.Category = c.PostForm("category")
	userDetail.Mobile = c.PostForm("mobile")
	userDetail.Telephone = c.PostForm("telephone")
	userDetail.EmailPersonal = c.PostForm("emailPersonal")
	userDetail.FatherName = c.PostForm("fatherName")
	userDetail.EducationQualification = c.PostForm("educationQualification")
	netWorthStr := c.PostForm("netWorth")
	if netWorth, err := strconv.ParseFloat(netWorthStr, 64); err == nil {
		userDetail.NetWorth = netWorth
	}
	userDetail.Nationality = c.PostForm("nationality")
	userDetail.Dependent = c.PostForm("dependent")
	userDetail.MaritalStatus = c.PostForm("maritalStatus")
	userDetail.ProfileId = profileId
	userDetail.ApplicationId = applicationId
	userDetail.Timestamp = time.Now()

	// Query Firestore using profileId and applicationId
	ctx := context.Background()
	query := client.Collection("personal_basic_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)

	docs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve user detail", "details": err.Error()})
		return
	}
	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "User detail not found"})
		return
	}
	formId := docs[0].Data()["formId"].(string)

	// Convert userDetail to a map and update the document
	userDetailMap := convertUserDetailToMap(userDetail)
	userDetailMap["formId"] = formId

	_, err = docs[0].Ref.Set(ctx, userDetailMap, firestore.MergeAll)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update user detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "User detail updated successfully"})
}

func DeleteUserDetail(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Query Firestore using profileId and applicationId
	query := client.Collection("personal_basic_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)

	docs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve user detail", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "User detail not found"})
		return
	}

	// Delete the document
	_, err = docs[0].Ref.Delete(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete user detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "User detail deleted successfully"})
}
