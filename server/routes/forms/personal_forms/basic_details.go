package personal_forms

import (
	user_details "server/controller/forms/personal_forms"
	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterPersonalBasicDetails(router *gin.Engine) {
	router.POST("/personal/basic_details/:profileId/:applicationId", user_details.CreateUserDetail)   // Create user details
	router.GET("/personal/basic_details/:profileId/:applicationId", user_details.GetUserDetail)       // Get user details
	router.PUT("/personal/basic_details/:profileId/:applicationId", user_details.UpdateUserDetail)  // Update user details
	router.DELETE("/personal/basic_details/:profileId/:applicationId", user_details.DeleteUserDetail) // Delete user details
}
