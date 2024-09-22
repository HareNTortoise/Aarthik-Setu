package business_forms

import (
	"server/controller/forms/business_forms/itr_forms"

	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterBusinessITRPDFRoutes(router *gin.Engine) {
	router.POST("/business/upload-itr-document/:userId", itr_forms.UploadITRDocuments)
}
