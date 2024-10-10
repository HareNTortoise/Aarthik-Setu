package profile_applications

import (
	controller "server/controller/profile_applications"

	"github.com/gin-gonic/gin"
)

func RegisterBusinessProfileRoutes(router *gin.Engine) {
	// Register routes here
	router.POST("/business/profile/:userId", controller.CreateBusinessProfile)
	router.GET("/business/profile/:userId", controller.GetBusinessProfiles)
	router.PATCH("/business/profile/:userId/:profileId", controller.UpdateBusinessProfile)
	router.DELETE("/business/profile/:userId/:profileId", controller.DeleteBusinessProfile)
}
