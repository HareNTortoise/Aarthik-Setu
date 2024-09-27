package personal_forms

import (
	"server/controller/forms/personal_forms/itr_forms"

	"github.com/gin-gonic/gin"
)

func RegisterPersonalITRPDFRoutes(router *gin.Engine) {
	router.POST("/personal/upload-itr-document/:profileId/:applicationId", itr_forms.UploadITRDocuments)
	// router.GET("/personal/itr/:userId", itr_forms.GetManualITR)
	// router.PATCH("/personal/itr/:userId", itr_forms.UpdateManualITR)
}
