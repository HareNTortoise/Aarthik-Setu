package personal_forms

import (
	"server/controller/forms/personal_forms/itr_forms"

	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterITRRoutes(router *gin.Engine) {
	router.POST("/personal/itr", itr_forms.CreateManualITR)
}
