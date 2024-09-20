package main

import (
	"log"
	personal_forms "server/routes/forms/personal_forms"

	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()

	// Register ITR form routes
	personal_forms.RegisterITRRoutes(router)

	// Start the HTTP server
	log.Println("Starting server on :8080")
	if err := router.Run(":8080"); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
