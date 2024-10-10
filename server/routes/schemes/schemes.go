package schemes

import (
	controller "server/controller/schemes"

	"github.com/gin-gonic/gin"
)

func RegisterPublicSchemesInfoRoutes(router *gin.Engine) {
	router.POST("/schemes-info", controller.ProvideSchemeInfo)
	router.GET("/govt_schemes", controller.GetGovtSchemes)
}
