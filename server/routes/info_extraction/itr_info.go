package info_extraction

import (
	itr_info "server/controller/info_extraction"

	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterITRInfoExtractionRoutes(router *gin.Engine) {
	router.POST("/gen_ai/get-itr-detils/:profileId/:applicationId", itr_info.GetITRDetails)
}
