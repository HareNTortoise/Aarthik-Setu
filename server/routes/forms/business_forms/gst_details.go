package business_forms

import (
	gst_details "server/controller/forms/business_forms"

	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterGSTDetails(router *gin.Engine) {
	router.POST("/business/gst_details/:profileId/:applicationId", gst_details.CreateGSTDetails)
	router.GET("/business/gst_details/:profileId/:applicationId", gst_details.GetGSTDetails)
	router.PUT("/business/gst_details/:profileId/:applicationId", gst_details.UpdateGSTDetails)
	router.DELETE("/business/gst_details/:profileId/:applicationId", gst_details.DeleteGSTDetails)
}
