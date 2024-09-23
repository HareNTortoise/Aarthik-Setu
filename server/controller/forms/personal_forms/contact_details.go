package personal_forms

import (
	"context"
	"net/http"
	"time"
	"github.com/gin-gonic/gin"
	utils "server/config/firebase"
	model "server/models/forms/personal_forms"
	"cloud.google.com/go/firestore"
)

// var client *firestore.Client

func init() {
	client = utils.InitFirestore() // Initialize Firestore client
}

func CreateResidenceDetail(c *gin.Context) {
	userID := c.Param("userId")

	var residenceDetail model.ResidenceDetail

	// Manually extract form data
	residenceDetail.PremisesName = c.PostForm("premisesName")
	residenceDetail.StreetName = c.PostForm("streetName")
	residenceDetail.Landmark = c.PostForm("landmark")
	residenceDetail.Country = c.PostForm("country")
	residenceDetail.State = c.PostForm("state")
	residenceDetail.City = c.PostForm("city")
	residenceDetail.PinCode = c.PostForm("pinCode")
	residenceDetail.Village = c.PostForm("village")
	residenceDetail.District = c.PostForm("district")
	residenceDetail.SubDistrict = c.PostForm("subDistrict")
	residenceDetail.TypeOfResidence = c.PostForm("typeOfResidence")
	residenceDetail.ResidenceSince, _ = time.Parse("2006-01-02", c.PostForm("residenceSince")) // Assuming format YYYY-MM-DD

	residenceDetailMap := map[string]interface{}{
		"premises_name":      residenceDetail.PremisesName,
		"street_name":        residenceDetail.StreetName,
		"landmark":           residenceDetail.Landmark,
		"country":            residenceDetail.Country,
		"state":              residenceDetail.State,
		"city":               residenceDetail.City,
		"pin_code":           residenceDetail.PinCode,
		"village":            residenceDetail.Village,
		"district":           residenceDetail.District,
		"sub_district":       residenceDetail.SubDistrict,
		"type_of_residence":  residenceDetail.TypeOfResidence,
		"residence_since":    residenceDetail.ResidenceSince,
	}

	ctx := context.Background()
	_, err := client.Collection("contact_details").Doc(userID).Set(ctx, residenceDetailMap)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create residence detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "Residence detail created successfully"})
}

func GetResidenceDetail(c *gin.Context) {
	userID := c.Param("userId")
	ctx := context.Background()

	doc, err := client.Collection("contact_details").Doc(userID).Get(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve residence detail", "details": err.Error()})
		return
	}

	if !doc.Exists() {
		c.JSON(http.StatusNotFound, gin.H{"error": "Residence detail not found"})
		return
	}

	// Manually assign variables from the document
	data := doc.Data()
	residenceDetail := model.ResidenceDetail{
		PremisesName:    data["premises_name"].(string),
		StreetName:      data["street_name"].(string),
		Landmark:        data["landmark"].(string),
		Country:         data["country"].(string),
		State:           data["state"].(string),
		City:            data["city"].(string),
		PinCode:         data["pin_code"].(string),
		Village:         data["village"].(string),
		District:        data["district"].(string),
		SubDistrict:     data["sub_district"].(string),
		TypeOfResidence: data["type_of_residence"].(string),
		ResidenceSince:  data["residence_since"].(time.Time), // Ensure this is correctly parsed
	}

	c.JSON(http.StatusOK, residenceDetail)
}


func UpdateResidenceDetail(c *gin.Context) {
	userID := c.Param("userId")

	var residenceDetail model.ResidenceDetail

	// Manually extract form data
	residenceDetail.PremisesName = c.PostForm("premisesName")
	residenceDetail.StreetName = c.PostForm("streetName")
	residenceDetail.Landmark = c.PostForm("landmark")
	residenceDetail.Country = c.PostForm("country")
	residenceDetail.State = c.PostForm("state")
	residenceDetail.City = c.PostForm("city")
	residenceDetail.PinCode = c.PostForm("pinCode")
	residenceDetail.Village = c.PostForm("village")
	residenceDetail.District = c.PostForm("district")
	residenceDetail.SubDistrict = c.PostForm("subDistrict")
	residenceDetail.TypeOfResidence = c.PostForm("typeOfResidence")
	residenceDetail.ResidenceSince, _ = time.Parse("2006-01-02", c.PostForm("residenceSince")) // Assuming format YYYY-MM-DD

	// Convert residenceDetail to a map
	residenceDetailMap := map[string]interface{}{
		"premises_name":      residenceDetail.PremisesName,
		"street_name":        residenceDetail.StreetName,
		"landmark":           residenceDetail.Landmark,
		"country":            residenceDetail.Country,
		"state":              residenceDetail.State,
		"city":               residenceDetail.City,
		"pin_code":           residenceDetail.PinCode,
		"village":            residenceDetail.Village,
		"district":           residenceDetail.District,
		"sub_district":       residenceDetail.SubDistrict,
		"type_of_residence":  residenceDetail.TypeOfResidence,
		"residence_since":    residenceDetail.ResidenceSince,
	}

	ctx := context.Background()
	_, err := client.Collection("contact_details").Doc(userID).Set(ctx, residenceDetailMap, firestore.MergeAll)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update residence detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Residence detail updated successfully"})
}

func DeleteResidenceDetail(c *gin.Context) {
	userID := c.Param("userId")
	ctx := context.Background()

	docRef := client.Collection("contact_details").Doc(userID)
	doc, err := docRef.Get(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve residence detail", "details": err.Error()})
		return
	}

	if !doc.Exists() {
		c.JSON(http.StatusNotFound, gin.H{"error": "Residence detail not found"})
		return
	}

	_, err = docRef.Delete(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete residence detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Residence detail deleted successfully"})
}
