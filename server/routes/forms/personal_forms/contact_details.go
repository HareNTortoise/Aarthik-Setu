package personal_forms

import (
	"github.com/gin-gonic/gin"
	contact "server/controller/forms/personal_forms"
)

func RegisterPersonalContactDetails(router *gin.Engine) {
	router.POST("/personal/contact_details/:userId", contact.CreateResidenceDetail)
	router.GET("/personal/contact_details/:userId", contact.GetResidenceDetail)
	router.PUT("/personal/contact_details/:userId", contact.UpdateResidenceDetail)
	router.DELETE("/personal/contact_details/:userId", contact.DeleteResidenceDetail)
}
