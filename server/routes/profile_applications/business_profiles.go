package profile_applications

import (
	"github.com/gin-gonic/gin"
	controller "server/controller/profile_applications"
)



func RegisterBusinessProfileRoutes(router *gin.Engine) {
	// Register routes here
	router.POST("/business/profile/:userId", controller.CreateBusinessProfile)
	router.GET("/business/profile/:userId", controller.GetBusinessProfiles)
	router.PATCH("/business/profile/:userId/:profileId", controller.UpdateBusinessProfile)
	router.DELETE("/business/profile/:userId/:profileId",controller.DeleteBusinessProfile)
}