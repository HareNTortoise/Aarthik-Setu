package lender

import (
	lenders "server/controller/lenders"

	"github.com/gin-gonic/gin"
)

func SetuplendersRoutes(router *gin.Engine) {
	// Define lender-related routes
	router.GET("/lenders", lenders.GetLenders) // Get all lenders
	// router.GET("/lenders/:position", lenders.GetLenderByPosition) // Get lender by position
}
