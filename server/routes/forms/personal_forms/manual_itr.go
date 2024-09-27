package personal_forms

import (
	"server/controller/forms/personal_forms/itr_forms"

	"github.com/gin-gonic/gin"
)

// RegisterITRRoutes registers the routes related to ITR forms
func RegisterPersonalITRRoutes(router *gin.Engine) {
	router.POST("/personal/itr/:profileId/:applicationId", itr_forms.CreateManualITR)
	router.GET("/personal/itr/:profileId/:applicationId", itr_forms.GetManualITR)
	router.PATCH("/personal/itr/:profileId/:applicationId", itr_forms.UpdateManualITR)
}
