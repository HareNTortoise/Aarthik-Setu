package personal_forms

import (
	"server/controller/forms/personal_forms/itr_forms"
	"github.com/gin-gonic/gin"
)



func RegisterITRPDFRoutes(router *gin.Engine){
	router.POST("/personal/upload-itr-document/:userId", itr_forms.UploadITRDocuments)
	// router.GET("/personal/itr/:userId", itr_forms.GetManualITR)
	// router.PATCH("/personal/itr/:userId", itr_forms.UpdateManualITR)
}
