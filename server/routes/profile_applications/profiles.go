package profile_applications

import (
	"github.com/gin-gonic/gin"
	controller "server/controller/profile_applications"
)



func RegisterProfileRoutes(router *gin.Engine) {
	// Register routes here
	router.POST("/profile/:userId", controller.CreateProfile)
	router.GET("/profile/:userId", controller.GetProfiles)
	router.PATCH("/profile/:userId/:profileId", controller.UpdateProfile)
	router.DELETE("/profile/:userId/:profileId",controller.DeleteProfile)
}