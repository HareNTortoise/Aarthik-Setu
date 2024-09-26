package business_forms

import (
	bank_details "server/controller/forms/business_forms"

	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterStakeholdersDetails(router *gin.Engine) {
	router.POST("/business/stakeholders_details/:profileId/:applicationId", bank_details.CreateStakeholdersDetails)
	router.GET("/business/stakeholders_details/:profileId/:applicationId", bank_details.GetStakeholdersDetails)
	router.PUT("/business/stakeholders_details/:profileId/:applicationId", bank_details.UpdateStakeholdersDetails)
	router.DELETE("/business/stakeholders_details/:profileId/:applicationId", bank_details.DeleteStakeholdersDetails)
}
