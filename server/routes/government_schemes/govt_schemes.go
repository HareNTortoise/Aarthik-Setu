package government_schemes

import (
	govt_controller "server/controller/government_schemes"

	"github.com/gin-gonic/gin"
)

func RegisterGovtSchemesRoutes(router *gin.Engine) {
	// Register routes here
	// router.POST("/business_application/:profileId", controller.CreateBusinessApplication)
	router.GET("/govt_schemes", govt_controller.GetGovtSchemes)
	// router.PATCH("/business_application/:id", controller.UpdateBusinessApplication)
	// router.DELETE("/business_application/:id", controller.DeleteBusinessApplication)
}
