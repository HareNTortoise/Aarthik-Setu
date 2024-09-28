package genai

import (
	form_fill "server/controller/forms/gen_ai"

	"github.com/gin-gonic/gin"
)

func GenAIFormRoutes(router *gin.Engine) {
	personalForms := router.Group("/gen_ai")
	{
		personalForms.POST("/audio-fill", form_fill.AudioFormFiller)
	}
}
