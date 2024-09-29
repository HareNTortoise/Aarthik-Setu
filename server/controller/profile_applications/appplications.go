package profile_applications

import (
	"github.com/gin-gonic/gin"
	utils "server/config/firebase"
	// "cloud.google.com/go/firestore"
	"context"
	"time"
	"net/http"
)

func init() {
	client = utils.InitFirestore() // Initialize Firestore client
}


func CreateApplication(c *gin.Context) {
	profileId:= c.Param("profileId")
	applicationId,_ := utils.GenerateRandomString(16)
	manual_itr_form_id:= ""
	bank_details_form_id:= ""
	basic_details_form_id:= ""
	employment_details_form_id:= ""
	loan_details_form_id:= ""
	credit_info_form_id:= ""
	contact_details_form_id:= ""
	stakeholder_info_form_id:= ""
	business_details_form_id:= ""
	business_gst_form_id:= ""
	ctx := context.Background()

	// applicationId,_ := utils.GenerateRandomString(16)
	// Check if the user's bank details already exist
	query := client.Collection("applications").
		Where("applicationId", "==", applicationId).
		Where("profileId", "==", profileId).
		Documents(ctx)
	existingDocs, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to check existing application", "details": err.Error()})
		return
	}
	if len(existingDocs) > 0 {
		// If details are already present, return an error
		c.JSON(http.StatusConflict, gin.H{"error": "Application already exist"})
		return
	}
	created_at:= time.Now()
	_, err = client.Collection("applications").Doc(applicationId).Set(ctx, map[string]interface{}{
		"profileId": profileId,
		"applicationId": applicationId,
		"manual_itr_form_id": manual_itr_form_id,
		"bank_details_form_id": bank_details_form_id,
		"basic_details_form_id": basic_details_form_id,
		"employment_details_form_id": employment_details_form_id,
		"loan_details_form_id": loan_details_form_id,
		"credit_info_form_id": credit_info_form_id,
		"contact_details_form_id": contact_details_form_id,
		"stakeholder_info_form_id": stakeholder_info_form_id,
		"business_details_form_id": business_details_form_id,
		"business_gst_form_id": business_gst_form_id,
		"createdAt": created_at,
	})
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create application", "details": err.Error()})
		return
	}
	c.JSON(http.StatusCreated, gin.H{"message": "Application created successfully"})
}

func GetApplication(c *gin.Context) {
	profileId := c.Param("profileId")
	ctx := context.Background()

	// Query profiles by userId
	query := client.Collection("applications").Where("profileId", "==", profileId).Documents(ctx)
	applications, err := query.GetAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve applications", "details": err.Error()})
		return
	}

	if len(applications) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "No applications found"})
		return
	}

	var applicationData []map[string]interface{}
	for _, application := range applications {
		applicationData = append(applicationData, application.Data())
	}

	c.JSON(http.StatusOK, gin.H{"applications": applicationData})
}

func DeleteApplication(c *gin.Context) {
	// profileId := c.Param("profileId")
	applicationId := c.Param("applicationId")
	ctx := context.Background()

	// Check if the application exists
	doc := client.Collection("applications").Doc(applicationId)
	docData, err := doc.Get(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to check application", "details": err.Error()})
		return
	}

	if !docData.Exists() {
		c.JSON(http.StatusNotFound, gin.H{"error": "Application not found"})
		return
	}

	// Delete the application
	_, err = doc.Delete(ctx)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete application", "details": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Application deleted successfully"})
}