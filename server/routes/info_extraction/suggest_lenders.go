package info_extraction

import (
	itr_info "server/controller/info_extaction"
	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterSuggestLenders(router *gin.Engine) {
	router.POST("/gen_ai/suggest-lenders/:profileId/:applicationId", itr_info.SuggestLenders)
}
