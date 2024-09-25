package personal_forms

import (
	"context"
	"net/http"
	"github.com/gin-gonic/gin"
	model "server/models/forms/personal_forms"
	utils "server/config/firebase"
	"cloud.google.com/go/firestore"
	"time"
)

// var client *firestore.Client

func init() {
	client = utils.InitFirestore() // Initialize Firestore client
}

func CreateEmploymentDetail(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")

	var employmentDetail model.EmploymentDetail

	// Manually extract form data
	employmentDetail.EmploymentType = c.PostForm("employmentType")
	employmentDetail.EmployerStatus = c.PostForm("employerStatus")
	employmentDetail.Designation = c.PostForm("designation")
	employmentDetail.ModeOfSalary = c.PostForm("modeOfSalary")
	employmentDetail.GrossMonthlyIncome = c.PostForm("grossMonthlyIncome")
	employmentDetail.NetMonthlyIncome = c.PostForm("netMonthlyIncome")
	employmentDetail.ProfileId = profileId
	employmentDetail.ApplicationId = applicationId
	employmentDetail.Timestamp = time.Now()
	employmentDetail.FormId,_ = utils.GenerateRandomString(16)

	// Check for required fields
	if employmentDetail.EmploymentType == "" || employmentDetail.EmployerStatus == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Employment type and employer status are required"})
		return
	}

	// Check if employment details already exist
	ctx := context.Background()
	docRef := client.Collection("personal_employment_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Limit(1)

	docSnap, err := docRef.Documents(ctx).GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to check for existing employment details", "details": err.Error()})
		return
	}

	if len(docSnap) > 0 {
		c.JSON(http.StatusConflict, gin.H{"error": "Employment details already exist for this profile and application"})
		return
	}

	// Prepare employment detail map for Firestore
	employmentDetailMap := map[string]interface{}{
		"employment_type":      employmentDetail.EmploymentType,
		"employer_status":      employmentDetail.EmployerStatus,
		"designation":          employmentDetail.Designation,
		"mode_of_salary":       employmentDetail.ModeOfSalary,
		"gross_monthly_income": employmentDetail.GrossMonthlyIncome,
		"net_monthly_income":   employmentDetail.NetMonthlyIncome,
		"profileId":            employmentDetail.ProfileId,
		"applicationId":        employmentDetail.ApplicationId,
		"timestamp":            employmentDetail.Timestamp,
		"formId": 			    employmentDetail.FormId,
	}

	// Add a new document with an auto-generated ID
	_, _, err = client.Collection("personal_employment_details").Add(ctx, employmentDetailMap)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create employment detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "Employment detail created successfully"})
}


func GetEmploymentDetail(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Query the employment_details collection
	docRef := client.Collection("personal_employment_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Limit(1) // Limit to one document since profileId and applicationId should uniquely identify the record

	docSnap, err := docRef.Documents(ctx).GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve employment detail", "details": err.Error()})
		return
	}

	if len(docSnap) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "Employment detail not found"})
		return
	}

	// Use a map to manually assign the values from the first document found
	data := docSnap[0].Data()
	employmentDetail := map[string]interface{}{
		"employment_type":      data["employment_type"],
		"employer_status":      data["employer_status"],
		"designation":          data["designation"],
		"mode_of_salary":       data["mode_of_salary"],
		"gross_monthly_income": data["gross_monthly_income"],
		"net_monthly_income":   data["net_monthly_income"],
		"profileId":           data["profileId"],
		"applicationId":       data["applicationId"],
		"timestamp":           data["timestamp"],
		"formId":              data["formId"],
	}

	c.JSON(http.StatusOK, employmentDetail)
}

func UpdateEmploymentDetail(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")

	var employmentDetail model.EmploymentDetail

	// Manually extract form data
	employmentDetail.EmploymentType = c.PostForm("employmentType")
	employmentDetail.EmployerStatus = c.PostForm("employerStatus")
	employmentDetail.Designation = c.PostForm("designation")
	employmentDetail.ModeOfSalary = c.PostForm("modeOfSalary")
	employmentDetail.GrossMonthlyIncome = c.PostForm("grossMonthlyIncome")
	employmentDetail.NetMonthlyIncome = c.PostForm("netMonthlyIncome")

	// Convert employmentDetail to a map
	// employmentDetailMap := map[string]interface{}{
	// 	"employment_type":      employmentDetail.EmploymentType,
	// 	"employer_status":      employmentDetail.EmployerStatus,
	// 	"designation":          employmentDetail.Designation,
	// 	"mode_of_salary":       employmentDetail.ModeOfSalary,
	// 	"gross_monthly_income": employmentDetail.GrossMonthlyIncome,
	// 	"net_monthly_income":   employmentDetail.NetMonthlyIncome,
	// 	"timestamp":            time.Now(), // Update timestamp to now
	// }

	ctx := context.Background()

	// Get the document reference for the employment details
	docRef := client.Collection("personal_employment_details").Where("profileId", "==", profileId).Where("applicationId", "==", applicationId).Limit(1)

	// Retrieve the document
	docs, err := docRef.Documents(ctx).GetAll()
	if err != nil || len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "Employment detail not found"})
		return
	}

	// Get the existing document's data
	existingData := docs[0].Data()
	formId := existingData["formId"] // Keep the existing formId
	existingProfileId := existingData["profileId"] // Keep existing profileId
	existingApplicationId := existingData["applicationId"] // Keep existing applicationId

	// Prepare the updated map, merging new and existing data
	updatedData := map[string]interface{}{
		"employment_type":      employmentDetail.EmploymentType,
		"employer_status":      employmentDetail.EmployerStatus,
		"designation":          employmentDetail.Designation,
		"mode_of_salary":       employmentDetail.ModeOfSalary,
		"gross_monthly_income": employmentDetail.GrossMonthlyIncome,
		"net_monthly_income":   employmentDetail.NetMonthlyIncome,
		"profileId":           existingProfileId,     // Keep existing profileId
		"applicationId":       existingApplicationId,  // Keep existing applicationId
		"formId":              formId,                 // Keep existing formId
		"timestamp":           time.Now(),             // Update timestamp to now
	}

	// Update the employment details in Firestore
	_, err = client.Collection("personal_employment_details").Doc(docs[0].Ref.ID).Set(ctx, updatedData, firestore.MergeAll)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update employment detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Employment detail updated successfully"})
}


func DeleteEmploymentDetail(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Retrieve the document reference based on profileId and applicationId
	docRef := client.Collection("personal_employment_details").Where("profileId", "==", profileId).Where("applicationId", "==", applicationId).Limit(1)

	// Get the document
	docs, err := docRef.Documents(ctx).GetAll()
	if err != nil || len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "Employment detail not found"})
		return
	}

	// Delete the document
	_, err = client.Collection("personal_employment_details").Doc(docs[0].Ref.ID).Delete(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete employment detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Employment detail deleted successfully"})
}