package main

import (
	"log"
	business_forms "server/routes/forms/business_forms"
	personal_forms "server/routes/forms/personal_forms"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}
	router := gin.Default()

	router.GET("/ping", func(c *gin.Context) {
		// Respond with "pong"
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	// Register ITR form routes
	personal_forms.RegisterPersonalITRRoutes(router)
	personal_forms.RegisterPersonalITRPDFRoutes(router)
	business_forms.RegisterBusinessITRPDFRoutes(router)
	// Start the HTTP server
	log.Println("Starting server on :8080")
	if err := router.Run(":8080"); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
