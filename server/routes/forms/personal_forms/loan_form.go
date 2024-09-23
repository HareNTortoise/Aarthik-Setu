package personal_forms

import (
	loan_form "server/controller/forms/personal_forms"
	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterPersonalLoanForm(router *gin.Engine) {
	router.POST("/personal/loan_form/:userId/:loanId", loan_form.SubmitLoanApplicationDetails)
	router.GET("/personal/loan_form/:userId/:loanId", loan_form.GetLoanApplicationDetails)    
	router.PUT("/personal/loan_form/:userId/:loanId", loan_form.UpdateLoanApplicationDetails)  
	router.DELETE("/personal/loan_form/:userId/:loanId", loan_form.DeleteLoanApplicationDetails)
}
