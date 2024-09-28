package info_extraction

import (
	"github.com/gin-gonic/gin"
	itr_info "server/controller/info_extaction"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterITRInfoExtractionRoutes(router *gin.Engine) {
	router.POST("/gen_ai/get-itr-detils", itr_info.GetITRDetails)
}