package personal_forms

import (
	bank_details "server/controller/forms/personal_forms"
	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterPersonalBankDetails(router *gin.Engine) {
	router.POST("/personal/bank_details/:userId", bank_details.CreateBankDetails)
	router.GET("/personal/bank_details/:userId", bank_details.GetBankDetails)    
	router.PUT("/personal/bank_details/:userId", bank_details.UpdateBankDetails)  
	router.DELETE("/personal/bank_details/:userId", bank_details.DeleteBankDetails) 
	// router.GET("/personal/itr/:userId", itr_forms.GetManualITR)
	// router.PATCH("/personal/itr/:userId", itr_forms.UpdateManualITR)
}
