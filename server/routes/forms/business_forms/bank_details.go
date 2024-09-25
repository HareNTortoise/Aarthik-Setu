package business_forms

import (
	bank_details "server/controller/forms/business_forms"

	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterBusinessBankDetails(router *gin.Engine) {
	router.POST("/business/bank_details/:userId", bank_details.CreateBankDetails)
	router.GET("/business/bank_details/:userId", bank_details.GetBankDetails)
	router.PUT("/business/bank_details/:userId", bank_details.UpdateBankDetails)
	router.DELETE("/business/bank_details/:userId", bank_details.DeleteBankDetails)
	// router.GET("/personal/itr/:userId", itr_forms.GetManualITR)
	// router.PATCH("/personal/itr/:userId", itr_forms.UpdateManualITR)
}
