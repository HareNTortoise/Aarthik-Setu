package personal_forms

import (
	bank_details "server/controller/forms/personal_forms"

	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterPersonalBankDetails(router *gin.Engine) {
	router.POST("/personal/bank_details/:profileId/:applicationId", bank_details.CreateBankDetails)
	router.GET("/personal/bank_details/:profileId/:applicationId", bank_details.GetBankDetails)
	router.PUT("/personal/bank_details/:profileId/:applicationId", bank_details.UpdateBankDetails)
	router.DELETE("/personal/bank_details/:profileId/:applicationId", bank_details.DeleteBankDetails)
}
