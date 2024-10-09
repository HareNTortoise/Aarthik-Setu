package info_extraction

import (
	info_extraction "server/controller/info_extraction" // Replace with your actual module path

	"github.com/gin-gonic/gin"
)

// SetupRoutes initializes the routes for the application.
func GetCreditScore(router *gin.Engine) {
	// Route for calculating credit score
	router.POST("/calculate-credit-score/:profileId/:applicationId", info_extraction.CalculateCreditScore)
}
