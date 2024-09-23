package personal_forms

import (
	credit_info "server/controller/forms/personal_forms"
	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterPersonalCreditInfo(router *gin.Engine) {
	router.POST("/personal/credit_info/:userId", credit_info.CreateLoanDetails)
	router.GET("/personal/credit_info/:userId", credit_info.GetCreditInfo)    
	router.PUT("/personal/credit_info/:userId", credit_info.UpdateCreditInfo)  
	router.DELETE("/personal/credit_info/:userId", credit_info.DeleteCreditInfo)
}
