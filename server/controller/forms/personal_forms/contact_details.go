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
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")

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
	residenceDetail.ProfileId = profileId
	residenceDetail.ApplicationId = applicationId
	residenceDetail.Timestamp = time.Now()
	residenceDetail.FormId, _ = utils.GenerateRandomString(16)

	// Context for Firestore
	ctx := context.Background()

	// Query Firestore to check if residence details already exist
	query := client.Collection("personal_contact_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)

	existingDocs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to check existing residence details", "details": err.Error()})
		return
	}

	if len(existingDocs) > 0 {
		// If residence details already exist, return an error
		c.JSON(http.StatusConflict, gin.H{"error": "Residence details already exist for the given profileId and applicationId"})
		return
	}

	// Map the residence detail to a map for Firestore
	residenceDetailMap := map[string]interface{}{
		"premisesName":      residenceDetail.PremisesName,
		"streetName":        residenceDetail.StreetName,
		"landmark":          residenceDetail.Landmark,
		"country":           residenceDetail.Country,
		"state":             residenceDetail.State,
		"city":              residenceDetail.City,
		"pinCode":           residenceDetail.PinCode,
		"village":           residenceDetail.Village,
		"district":          residenceDetail.District,
		"subDistrict":       residenceDetail.SubDistrict,
		"typeOfResidence":   residenceDetail.TypeOfResidence,
		"residenceSince":    residenceDetail.ResidenceSince,
		"profileId":         residenceDetail.ProfileId,
		"applicationId":     residenceDetail.ApplicationId,
		"timestamp":         residenceDetail.Timestamp,
		"formId":            residenceDetail.FormId,
	}

	// Add the new residence detail to Firestore
	_,_, err = client.Collection("personal_contact_details").Add(ctx, residenceDetailMap)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create residence detail", "details": err.Error()})
		return
	}

	err= utils.UpdateFirestoreDocument(ctx, "applications",  residenceDetail.ApplicationId, "contact_details_form_id", residenceDetail.FormId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update application with formId", "details": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "Residence detail created successfully"})
}


func GetResidenceDetail(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Query Firestore using profileId and applicationId
	query := client.Collection("personal_contact_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)

	docs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve residence detail", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "Residence detail not found"})
		return
	}

	// Assuming we only want the first document
	data := docs[0].Data()
	residenceDetail := model.ResidenceDetail{
		PremisesName:      data["premisesName"].(string),
		StreetName:        data["streetName"].(string),
		Landmark:          data["landmark"].(string),
		Country:           data["country"].(string),
		State:             data["state"].(string),
		City:              data["city"].(string),
		PinCode:           data["pinCode"].(string),
		Village:           data["village"].(string),
		District:          data["district"].(string),
		SubDistrict:       data["subDistrict"].(string),
		TypeOfResidence:   data["typeOfResidence"].(string),
		ResidenceSince:    data["residenceSince"].(time.Time), // Ensure this is correctly parsed
		ProfileId:         data["profileId"].(string),
		ApplicationId:     data["applicationId"].(string),
		Timestamp:         data["timestamp"].(time.Time), // Ensure this is correctly parsed
		FormId:            data["formId"].(string), // Include formId if available
	}
	
	c.JSON(http.StatusOK, residenceDetail)
}



func UpdateResidenceDetail(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")

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
	residenceDetail.Timestamp = time.Now()
	residenceDetail.ProfileId = profileId
	residenceDetail.ApplicationId = applicationId

	// Query Firestore using profileId and applicationId
	ctx := context.Background()
	query := client.Collection("personal_contact_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Documents(ctx)

	residentialDocs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve residence detail", "details": err.Error()})
		return
	}

	if len(residentialDocs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No residence details found for the specified profileId and applicationId"})
		return
	}

	// Get the existing FormId from the first document
	residenceDetail.FormId = residentialDocs[0].Data()["formId"].(string)

	// Convert residenceDetail to a map
	residenceDetailMap := map[string]interface{}{
		"premisesName":      residenceDetail.PremisesName,
		"streetName":        residenceDetail.StreetName,
		"landmark":          residenceDetail.Landmark,
		"country":           residenceDetail.Country,
		"state":             residenceDetail.State,
		"city":              residenceDetail.City,
		"pinCode":           residenceDetail.PinCode,
		"village":           residenceDetail.Village,
		"district":          residenceDetail.District,
		"subDistrict":       residenceDetail.SubDistrict,
		"typeOfResidence":   residenceDetail.TypeOfResidence,
		"residenceSince":    residenceDetail.ResidenceSince,
		"profileId":         residenceDetail.ProfileId,
		"applicationId":     residenceDetail.ApplicationId,
		"timestamp":         residenceDetail.Timestamp,
		"formId":            residenceDetail.FormId,
	}

	// Update Firestore document
	_, err = client.Collection("personal_contact_details").Doc(residentialDocs[0].Ref.ID).Set(ctx, residenceDetailMap, firestore.MergeAll)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update residence detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Residence detail updated successfully"})
}


func DeleteResidenceDetail(c *gin.Context) {
	profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Query Firestore to find the document based on profileId and applicationId
	query := client.Collection("personal_contact_details").
		Where("profileId", "==", profileId).
		Where("applicationId", "==", applicationId).
		Limit(1) // Limit to 1 document

	docs, err := query.Documents(ctx).GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve residence detail", "details": err.Error()})
		return
	}

	if len(docs) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "Residence detail not found"})
		return
	}

	// Use the document reference to delete the found document
	docRef := docs[0].Ref
	_, err = docRef.Delete(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete residence detail", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Residence detail deleted successfully"})
}
