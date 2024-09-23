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

func CreateUserDetail(c *gin.Context) {
	userID := c.Param("userId")

	// Create a UserDetail instance
	var userDetail model.UserDetail

	// Manually extract form data
	userDetail.Salutation = c.PostForm("salutation")
	userDetail.FirstName = c.PostForm("firstName")
	userDetail.MiddleName = getStringPointer(c.PostForm("middleName"))
	userDetail.LastName = c.PostForm("lastName")
	userDetail.Dob, _ = ParseDate(c.PostForm("dob"))// Assuming the date format is YYYY-MM-DD
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

	ctx := context.Background()
	_, err := client.Collection("user_details").Doc(userID).Set(ctx, userDetail)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create user detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "User detail created successfully"})
}


func GetUserDetail(c *gin.Context) {
	userID := c.Param("userId")
	ctx := context.Background()

	doc, err := client.Collection("user_details").Doc(userID).Get(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve user detail", "details": err.Error()})
		return
	}

	if !doc.Exists() {
		c.JSON(http.StatusNotFound, gin.H{"error": "User detail not found"})
		return
	}

	var userDetail model.UserDetail
	if err := doc.DataTo(&userDetail); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse user detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, userDetail)
}

func UpdateUserDetail(c *gin.Context) {
	userID := c.Param("userId")

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

	// Convert userDetail to a map
	userDetailMap := map[string]interface{}{
		"salutation":               userDetail.Salutation,
		"first_name":               userDetail.FirstName,
		"middle_name":              userDetail.MiddleName,
		"last_name":                userDetail.LastName,
		"dob":                      userDetail.Dob,
		"pan":                      userDetail.Pan,
		"gender":                   userDetail.Gender,
		"category":                 userDetail.Category,
		"mobile":                   userDetail.Mobile,
		"telephone":                userDetail.Telephone,
		"email_personal":           userDetail.EmailPersonal,
		"father_name":              userDetail.FatherName,
		"education_qualification":  userDetail.EducationQualification,
		"net_worth":                userDetail.NetWorth,
		"nationality":              userDetail.Nationality,
		"dependent":                userDetail.Dependent,
		"marital_status":           userDetail.MaritalStatus,
	}

	ctx := context.Background()
	_, err = client.Collection("user_details").Doc(userID).Set(ctx, userDetailMap, firestore.MergeAll)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update user detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "User detail updated successfully"})
}



func DeleteUserDetail(c *gin.Context) {
	userID := c.Param("userId")
	ctx := context.Background()

	docRef := client.Collection("user_details").Doc(userID)
	doc, err := docRef.Get(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve user detail", "details": err.Error()})
		return
	}

	if !doc.Exists() {
		c.JSON(http.StatusNotFound, gin.H{"error": "User detail not found"})
		return
	}

	_, err = docRef.Delete(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete user detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "User detail deleted successfully"})
}
