package business_forms

import (
	gst_details "server/controller/forms/business_forms"

	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterGSTBusinessDetails(router *gin.Engine) {
	router.POST("/business/declare_gst_details/:profileId/:applicationId", gst_details.CreateDeclareGSTBusinessDetails)
	router.GET("/business/declare_gst_details/:profileId/:applicationId", gst_details.GetDeclareGSTBusinessDetails)
	router.PUT("/business/declare_gst_details/:profileId/:applicationId", gst_details.UpdateDeclareGSTBusinessDetails)
	router.DELETE("/business/declare_gst_details/:profileId/:applicationId", gst_details.DeleteDeclareGSTBusinessDetails)
}
