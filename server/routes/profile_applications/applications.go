package profile_applications

import(
	"github.com/gin-gonic/gin"
	controller "server/controller/profile_applications"
)

func RegisterApplicationsRoutes(router *gin.Engine) {
	// Register routes here
	router.POST("/application/:profileId", controller.CreateApplication)
	router.GET("/application/:profileId", controller.GetApplication)
	router.DELETE("/application/:profileId/:applicationId",controller.DeleteApplication)
}