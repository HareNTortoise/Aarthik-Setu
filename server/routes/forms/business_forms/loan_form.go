package business_forms

import (
	loan_form "server/controller/forms/business_forms"

	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterBusinessLoanForm(router *gin.Engine) {
	router.POST("/business/loan_form/:userId/:loanId", loan_form.SubmitLoanApplicationDetails)
	router.GET("/business/loan_form/:userId/:loanId", loan_form.GetLoanApplicationDetails)
	router.PUT("/business/loan_form/:userId/:loanId", loan_form.UpdateLoanApplicationDetails)
	router.DELETE("/business/loan_form/:userId/:loanId", loan_form.DeleteLoanApplicationDetails)
}
