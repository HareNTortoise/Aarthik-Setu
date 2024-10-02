package chatbot

import (
	"github.com/gin-gonic/gin"

	chatbot "server/controller"
)

func SetupRoutes(r *gin.Engine) {
	r.POST("/chat", chatbot.HandleChat)
	r.GET("/chat", chatbot.HandleHome)
}
