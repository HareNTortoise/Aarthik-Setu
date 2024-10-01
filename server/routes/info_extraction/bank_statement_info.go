package info_extraction

import (
	itr_info "server/controller/info_extaction"

	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterBankStatementInfoExtractionRoutes(router *gin.Engine) {
	router.POST("/gen_ai/get-bank-statement-details/:profileId/:applicationId", itr_info.GetBankStatementDetails)
}
