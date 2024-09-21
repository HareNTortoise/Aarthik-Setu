package itr_forms

import (
	"context"
	"net/http"
	"strconv"
	"time"
	"fmt"
	"strings"
	"errors"
	"cloud.google.com/go/firestore"
	"github.com/gin-gonic/gin"
	"server/models/forms/personal_forms/itr_forms"
	utils "server/config/firebase"
)

// Firestore client (global or injected)
var client *firestore.Client

func init() {
	client = utils.InitFirestore() // Initialize Firestore client
}

// ParseDate is a helper function to parse date in form-data
func ParseDate(dateStr string) (time.Time, error) {
	return time.Parse("2006-01-02", dateStr) // Adjust the layout according to the date format used in your form
}

// CreateManualITR handles the creation of a new Manual ITR form in Firestore with form-data
// func CreateManualITR(c *gin.Context) {
// 	var form itr_forms.ManualITR

// 	// Bind form-data input
// 	form.FirstName = c.PostForm("firstName")
// 	form.MiddleName = getStringPointer(c.PostForm("middleName"))
// 	form.LastName = c.PostForm("lastName")

// 	dobStr := c.PostForm("dob")
// 	dob, err := ParseDate(dobStr)
// 	if err != nil {
// 		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid date format for dob"})
// 		return
// 	}
// 	form.DOB = dob

// 	form.PAN = c.PostForm("pan")
// 	form.Mobile = c.PostForm("mobile")
// 	form.Email = c.PostForm("email")
// 	form.AddressLine1 = c.PostForm("addressLine1")
// 	form.AddressLine2 = getStringPointer(c.PostForm("addressLine2"))
// 	form.Landmark = c.PostForm("landmark")
// 	form.Country = c.PostForm("country")
// 	form.PinCode = c.PostForm("pinCode")
// 	form.State = c.PostForm("state")
// 	form.City = c.PostForm("city")
// 	form.Village = getStringPointer(c.PostForm("village"))
// 	form.District = getStringPointer(c.PostForm("district"))
// 	form.SubDistrict = getStringPointer(c.PostForm("subDistrict"))

// 	// Parse netAnnualIncome map from form-data (expecting key-value pairs in the form of "startYear-endYear" -> "income")
// 	form.NetAnnualIncome = make(map[itr_forms.IncomeRange]float64)
// 	for _, key := range c.PostFormArray("income_keys") {
// 		startYear, endYear, income, err := parseIncomeRange(c, key)
// 		if err != nil {
// 			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
// 			return
// 		}
// 		form.NetAnnualIncome[itr_forms.IncomeRange{StartYear: startYear, EndYear: endYear}] = income
// 	}

// 	// Save to Firestore
// 	ctx := context.Background()
// 	_, _, err = client.Collection("manual_itr_forms").Add(ctx, form)
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Failed to create ITR form. Firebase Issue %v", err)})
// 		return
// 	}

// 	c.JSON(http.StatusCreated, gin.H{"message": "ITR form created successfully"})
// }

// CreateManualITR handles the creation of a new Manual ITR form in Firestore with form-data
func CreateManualITR(c *gin.Context) {
	var form itr_forms.ManualITR

	// Bind form-data input
	form.FirstName = c.PostForm("firstName")
	form.MiddleName = getStringPointer(c.PostForm("middleName"))
	form.LastName = c.PostForm("lastName")

	dobStr := c.PostForm("dob")
	dob, err := ParseDate(dobStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid date format for dob"})
		return
	}
	form.DOB = dob

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

	// Prepare a new map for Firestore with string keys
	netAnnualIncomeFirestore := make(map[string]float64)

	// Parse netAnnualIncome map from form-data
	for _, key := range c.PostFormArray("income_keys") {
		startYear, endYear, income, err := parseIncomeRange(c, key)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		// Convert IncomeRange to string key
		keyStr := fmt.Sprintf("%d-%d", startYear, endYear)
		netAnnualIncomeFirestore[keyStr] = income
	}

	// Save to Firestore
	ctx := context.Background()
	_, _, err = client.Collection("manual_itr_forms").Add(ctx, map[string]interface{}{
		"FirstName":        form.FirstName,
		"MiddleName":       form.MiddleName,
		"LastName":         form.LastName,
		"DOB":              form.DOB,
		"PAN":              form.PAN,
		"Mobile":           form.Mobile,
		"Email":            form.Email,
		"AddressLine1":     form.AddressLine1,
		"AddressLine2":     form.AddressLine2,
		"Landmark":         form.Landmark,
		"Country":          form.Country,
		"PinCode":          form.PinCode,
		"State":            form.State,
		"City":             form.City,
		"Village":          form.Village,
		"District":         form.District,
		"SubDistrict":      form.SubDistrict,
		"NetAnnualIncome": netAnnualIncomeFirestore, // Use the new map here
	})
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Failed to create ITR form. Firebase Issue %v", err)})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "ITR form created successfully"})
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

// Helper function to handle optional form-data fields
func getStringPointer(value string) *string {
	if value == "" {
		return nil
	}
	return &value
}

// Other CRUD functions (Get, Update, Delete) remain mostly the same, except for updates where you'll bind form-data inputs again like in Create.
