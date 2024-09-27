package personal_forms

import (
	employment "server/controller/forms/personal_forms"
	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterPersonalEmploymentDetails(router *gin.Engine) {
	router.POST("/personal/employment_details/:profileId/:applicationId", employment.CreateEmploymentDetail)   // Create user details
	router.GET("/personal/employment_details/:profileId/:applicationId", employment.GetEmploymentDetail)       // Get user details
	router.PUT("/personal/employment_details/:profileId/:applicationId", employment.UpdateEmploymentDetail)  // Update user details
	router.DELETE("/personal/employment_details/:profileId/:applicationId", employment.DeleteEmploymentDetail) // Delete user details
}
