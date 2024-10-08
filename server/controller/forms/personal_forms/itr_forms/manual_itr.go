package itr_forms

import (
	"context"
	"errors"
	"fmt"
	"net/http"
	utils "server/config/firebase"
	"server/models/forms/personal_forms/itr_forms"
	"strconv"
	"strings"
	"time"

	"cloud.google.com/go/firestore"
	"github.com/gin-gonic/gin"
)

// Helper function to handle optional form-data fields
func getStringPointer(value string) *string {
	if value == "" {
		return nil
	}
	return &value
}

// parseIncomeRange parses the form-data income fields into startYear, endYear, and income
func parseIncomeRange(c *gin.Context, key string) (int, int, float64, error) {
	years := key // Expecting keys like "2020-2021"
	yearRange := strings.Split(years, "-")
	if len(yearRange) != 2 {
		return 0, 0, 0, errors.New("invalid year range format")
	}

	startYear, err := strconv.Atoi(yearRange[0])
	if err != nil {
		return 0, 0, 0, errors.New("invalid start year")
	}

	endYear, err := strconv.Atoi(yearRange[1])
	if err != nil {
		return 0, 0, 0, errors.New("invalid end year")
	}

	incomeStr := c.PostForm("income_" + key)
	income, err := strconv.ParseFloat(incomeStr, 64)
	if err != nil {
		return 0, 0, 0, errors.New("invalid income value")
	}

	return startYear, endYear, income, nil
}
var client *firestore.Client
func init() {
	client = utils.InitFirestore() // Initialize Firestore client
}

// ParseDate is a helper function to parse date in form-data
func ParseDate(dateStr string) (time.Time, error) {
	return time.Parse("2006-01-02", dateStr) // Adjust the layout according to the date format used in your form
}


//POST /personal/itr
func CreateManualITR(c *gin.Context) {
	var form itr_forms.ManualITR

	// Extract form data for profileId and applicationId
	form.ProfileId = c.Param("profileId")
	form.ApplicationId = c.Param("applicationId")

	// Validate profileId and applicationId
	if form.ProfileId == "" || form.ApplicationId == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Profile ID and Application ID are required"})
		return
	}

	// Check if the combination of profileId and applicationId already exists
	ctx := context.Background()
	query := client.Collection("personal_manual_itr_forms").
		Where("profileId", "==", form.ProfileId).
		Where("applicationId", "==", form.ApplicationId).
		Limit(1)
	docs, err := query.Documents(ctx).GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Error checking existing data: %v", err)})
		return
	}
	if len(docs) > 0 {
		c.JSON(http.StatusConflict, gin.H{"error": "ITR form already exists for this profile and application"})
		return
	}

	// Bind the rest of the form data
	form.FirstName = c.PostForm("firstName")
	form.MiddleName = getStringPointer(c.PostForm("middleName"))
	form.LastName = c.PostForm("lastName")
	dobStr := c.PostForm("dob")

	// Parse the date of birth
	dob, err := ParseDate(dobStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid date format for dob"})
		return
	}
	form.DOB = dob

	// More form data binding
	form.PAN = c.PostForm("pan")
	form.Mobile = c.PostForm("mobile")
	form.Email = c.PostForm("email")
	form.AddressLine1 = c.PostForm("addressLine1")
	form.AddressLine2 = getStringPointer(c.PostForm("addressLine2"))
	form.Landmark = c.PostForm("landmark")
	form.Country = c.PostForm("country")
	form.PinCode = c.PostForm("pinCode")
	form.State = c.PostForm("state")
	form.City = c.PostForm("city")
	form.Village = getStringPointer(c.PostForm("village"))
	form.District = getStringPointer(c.PostForm("district"))
	form.SubDistrict = getStringPointer(c.PostForm("subDistrict"))

	// Parsing income details
	netAnnualIncomeFirestore := make(map[string]float64)
	for _, key := range c.PostFormArray("income_keys") {
		startYear, endYear, income, err := parseIncomeRange(c, key)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		keyStr := fmt.Sprintf("%d-%d", startYear, endYear)
		netAnnualIncomeFirestore[keyStr] = income
	}

	// Generate a random formId
	form.FormId, _ = utils.GenerateRandomString(16)

	// Add the data to Firestore
	_, _, err = client.Collection("personal_manual_itr_forms").Add(ctx, map[string]interface{}{
		"profileId":         form.ProfileId,
		"applicationId":     form.ApplicationId,
		"firstName":         form.FirstName,
		"middleName":        form.MiddleName,
		"lastName":          form.LastName,
		"dob":               form.DOB,
		"pan":               form.PAN,
		"mobile":            form.Mobile,
		"email":             form.Email,
		"addressLine1":      form.AddressLine1,
		"addressLine2":      form.AddressLine2,
		"landmark":          form.Landmark,
		"country":           form.Country,
		"pinCode":           form.PinCode,
		"state":             form.State,
		"city":              form.City,
		"village":           form.Village,
		"district":          form.District,
		"subDistrict":       form.SubDistrict,
		"netAnnualIncome":   netAnnualIncomeFirestore,
		"formId":            form.FormId,
	})

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Failed to create ITR form. Firestore error: %v", err)})
		return
	}

	err= utils.UpdateFirestoreDocument(ctx, "applications", form.ApplicationId, "manual_itr_form_id", form.FormId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update application with formId", "details": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "ITR form created successfully"})
}




//GET /personal/itr/:id
func GetManualITR(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")

	// Validate profileId and applicationId
	if profileId == "" || applicationId == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Profile ID and Application ID are required"})
		return
	}

	ctx := context.Background()

	// Query to fetch the manual ITR form based on profileId and applicationId
	query := client.Collection("personal_manual_itr_forms").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Limit(1)

	docs, err := query.Documents(ctx).GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Error retrieving data: %v", err)})
		return
	}
	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "Form not found for the provided profileId and applicationId"})
		return
	}

	// Assuming you want to return the first document found
	var itrForm map[string]interface{}
	if err := docs[0].DataTo(&itrForm); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to convert document to data"})
		return
	}

	c.JSON(http.StatusOK, itrForm)
}

// //UPDATE /personal/itr
func UpdateManualITR(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	var updatedForm itr_forms.ManualITR

	// Validate profileId and applicationId
	if profileId == "" || applicationId == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Profile ID and Application ID are required"})
		return
	}

	ctx := context.Background()

	// Query to check if the form exists
	query := client.Collection("personal_manual_itr_forms").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Limit(1)

	docs, err := query.Documents(ctx).GetAll()
	if err != nil || len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "Form not found for the provided profileId and applicationId"})
		return
	}

	// Retain the existing formId
	formId := docs[0].Data()["formId"]

	// Bind form-data input (similar to CreateManualITR)
	updatedForm.ProfileId = profileId
	updatedForm.ApplicationId = applicationId
	updatedForm.FormId = formId.(string) // Retain the formId

	updatedForm.FirstName = c.PostForm("firstName")
	updatedForm.MiddleName = getStringPointer(c.PostForm("middleName"))
	updatedForm.LastName = c.PostForm("lastName")

	dobStr := c.PostForm("dob")
	dob, err := ParseDate(dobStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid date format for dob"})
		return
	}
	updatedForm.DOB = dob

	updatedForm.PAN = c.PostForm("pan")
	updatedForm.Mobile = c.PostForm("mobile")
	updatedForm.Email = c.PostForm("email")
	updatedForm.AddressLine1 = c.PostForm("addressLine1")
	updatedForm.AddressLine2 = getStringPointer(c.PostForm("addressLine2"))
	updatedForm.Landmark = c.PostForm("landmark")
	updatedForm.Country = c.PostForm("country")
	updatedForm.PinCode = c.PostForm("pinCode")
	updatedForm.State = c.PostForm("state")
	updatedForm.City = c.PostForm("city")
	updatedForm.Village = getStringPointer(c.PostForm("village"))
	updatedForm.District = getStringPointer(c.PostForm("district"))
	updatedForm.SubDistrict = getStringPointer(c.PostForm("subDistrict"))

	// Handle netAnnualIncome form-data
	netAnnualIncomeFirestore := make(map[string]float64)
	for _, key := range c.PostFormArray("income_keys") {
		startYear, endYear, income, err := parseIncomeRange(c, key)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		keyStr := fmt.Sprintf("%d-%d", startYear, endYear)
		netAnnualIncomeFirestore[keyStr] = income
	}

	// Update Firestore document
	docRef := docs[0].Ref
	_, err = docRef.Set(ctx, map[string]interface{}{
		"profileId":        updatedForm.ProfileId,
		"applicationId":    updatedForm.ApplicationId,
		"formId":           updatedForm.FormId, // Keep existing formId
		"firstName":        updatedForm.FirstName,
		"middleName":       updatedForm.MiddleName,
		"lastName":         updatedForm.LastName,
		"dob":              updatedForm.DOB,
		"pan":              updatedForm.PAN,
		"mobile":           updatedForm.Mobile,
		"email":            updatedForm.Email,
		"addressLine1":     updatedForm.AddressLine1,
		"addressLine2":     updatedForm.AddressLine2,
		"landmark":         updatedForm.Landmark,
		"country":          updatedForm.Country,
		"pinCode":          updatedForm.PinCode,
		"state":            updatedForm.State,
		"city":             updatedForm.City,
		"village":          updatedForm.Village,
		"district":         updatedForm.District,
		"subDistrict":      updatedForm.SubDistrict,
		"netAnnualIncome":  netAnnualIncomeFirestore,
	}, firestore.MergeAll)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Failed to update ITR form. Firebase Issue %v", err)})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "ITR form updated successfully"})
}


// Other CRUD functions (Get, Update, Delete) remain mostly the same, except for updates where you'll bind form-data inputs again like in Create.
