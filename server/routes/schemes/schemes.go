package schemes

import(
	"github.com/gin-gonic/gin"
	controller "server/controller/schemes"
)

func RegisterPublicSchemesInfoRoutes(router *gin.Engine) {
	router.POST("/schemes-info", controller.ProvideSchemeInfo)
}