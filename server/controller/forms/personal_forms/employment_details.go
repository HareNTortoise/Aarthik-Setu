package personal_forms

import (
	"context"
	"net/http"
	"github.com/gin-gonic/gin"
	model "server/models/forms/personal_forms"
	utils "server/config/firebase"
	"cloud.google.com/go/firestore"
)

// var client *firestore.Client

func init() {
	client = utils.InitFirestore() // Initialize Firestore client
}

func CreateEmploymentDetail(c *gin.Context) {
	userID := c.Param("userId")

	var employmentDetail model.EmploymentDetail

	// Manually extract form data
	employmentDetail.EmploymentType = c.PostForm("employmentType")
	employmentDetail.EmployerStatus = c.PostForm("employerStatus")
	employmentDetail.Designation = c.PostForm("designation")
	employmentDetail.ModeOfSalary = c.PostForm("modeOfSalary")
	employmentDetail.GrossMonthlyIncome = c.PostForm("grossMonthlyIncome")
	employmentDetail.NetMonthlyIncome = c.PostForm("netMonthlyIncome")

	ctx := context.Background()
	_, err := client.Collection("employment_details").Doc(userID).Set(ctx, employmentDetail)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create employment detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "Employment detail created successfully"})
}

func GetEmploymentDetail(c *gin.Context) {
	userID := c.Param("userId")
	ctx := context.Background()

	doc, err := client.Collection("employment_details").Doc(userID).Get(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve employment detail", "details": err.Error()})
		return
	}

	if !doc.Exists() {
		c.JSON(http.StatusNotFound, gin.H{"error": "Employment detail not found"})
		return
	}

	var employmentDetail model.EmploymentDetail
	if err := doc.DataTo(&employmentDetail); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse employment detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, employmentDetail)
}

func UpdateEmploymentDetail(c *gin.Context) {
	userID := c.Param("userId")

	var employmentDetail model.EmploymentDetail

	// Manually extract form data
	employmentDetail.EmploymentType = c.PostForm("employmentType")
	employmentDetail.EmployerStatus = c.PostForm("employerStatus")
	employmentDetail.Designation = c.PostForm("designation")
	employmentDetail.ModeOfSalary = c.PostForm("modeOfSalary")
	employmentDetail.GrossMonthlyIncome = c.PostForm("grossMonthlyIncome")
	employmentDetail.NetMonthlyIncome = c.PostForm("netMonthlyIncome")

	// Convert employmentDetail to a map
	employmentDetailMap := map[string]interface{}{
		"employment_type":      employmentDetail.EmploymentType,
		"employer_status":      employmentDetail.EmployerStatus,
		"designation":          employmentDetail.Designation,
		"mode_of_salary":       employmentDetail.ModeOfSalary,
		"gross_monthly_income": employmentDetail.GrossMonthlyIncome,
		"net_monthly_income":   employmentDetail.NetMonthlyIncome,
	}

	ctx := context.Background()
	_, err := client.Collection("employment_details").Doc(userID).Set(ctx, employmentDetailMap, firestore.MergeAll)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update employment detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Employment detail updated successfully"})
}

func DeleteEmploymentDetail(c *gin.Context) {
	userID := c.Param("userId")
	ctx := context.Background()

	docRef := client.Collection("employment_details").Doc(userID)
	doc, err := docRef.Get(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve employment detail", "details": err.Error()})
		return
	}

	if !doc.Exists() {
		c.JSON(http.StatusNotFound, gin.H{"error": "Employment detail not found"})
		return
	}

	_, err = docRef.Delete(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete employment detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Employment detail deleted successfully"})
}
