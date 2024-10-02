package profile_applications

import (
	controller "server/controller/profile_applications"

	"github.com/gin-gonic/gin"
)

func RegisterBusinessApplicationsRoutes(router *gin.Engine) {
	// Register routes here
	router.POST("/business_application/:profileId", controller.CreateBusinessApplication)
	router.GET("/business_application/:profileId", controller.GetBusinessApplications)
	router.PATCH("/business_application/:id", controller.UpdateBusinessApplication)
	router.DELETE("/business_application/:id", controller.DeleteBusinessApplication)
}
