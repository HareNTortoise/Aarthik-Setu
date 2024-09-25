package personal_forms

import (
	"github.com/gin-gonic/gin"
	contact "server/controller/forms/personal_forms"
)

func RegisterPersonalContactDetails(router *gin.Engine) {
	router.POST("/personal/contact_details/:profileId/:applicationId", contact.CreateResidenceDetail)
	router.GET("/personal/contact_details/:profileId/:applicationId", contact.GetResidenceDetail)
	router.PUT("/personal/contact_details/:profileId/:applicationId", contact.UpdateResidenceDetail)
	router.DELETE("/personal/contact_details/:profileId/:applicationId", contact.DeleteResidenceDetail)
}
