package profile_applications

import (
	controller "server/controller/profile_applications"

	"github.com/gin-gonic/gin"
)

func RegisterPersonalProfileRoutes(router *gin.Engine) {
	// Register routes here
	router.POST("/personal/profile/:userId", controller.CreatePersonalProfile)
	router.GET("/personal/profile/:userId", controller.GetPersonalProfiles)
	router.PATCH("/personal/profile/:userId/:profileId", controller.UpdatePersonalProfile)
	router.DELETE("/personal/profile/:userId/:profileId", controller.DeletePersonalProfile)
}
