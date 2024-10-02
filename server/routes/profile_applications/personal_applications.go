package profile_applications

import (
	controller "server/controller/profile_applications"

	"github.com/gin-gonic/gin"
)

func RegisterPersonalApplicationsRoutes(router *gin.Engine) {
	// Register routes here
	router.POST("/personal_application/:profileId", controller.CreatePersonalApplication)
	router.GET("/personal_application/:profileId", controller.GetPersonalApplications)
	router.PATCH("/personal_application/:id", controller.UpdatePersonalApplication)
	router.DELETE("/personal_application/:id", controller.DeletePersonalApplication)
}
