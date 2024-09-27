package main

import (
	"log"
	business_forms "server/routes/forms/business_forms"
	personal_forms "server/routes/forms/personal_forms"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func main() {
	// Load .env file
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	// Create a new router instance
	router := gin.Default()

	// Apply CORS middleware
	router.Use(cors.New(cors.Config{
		AllowOrigins:     []string{"http://localhost:3000"}, // Add your frontend's URL here
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Authorization"},
		AllowCredentials: true,
	}))

	// Register personal form routes
	personal_forms.RegisterPersonalITRRoutes(router)
	personal_forms.RegisterPersonalITRPDFRoutes(router)
	personal_forms.RegisterPersonalBankDetails(router)
	personal_forms.RegisterPersonalBasicDetails(router)
	personal_forms.RegisterPersonalEmploymentDetails(router)
	personal_forms.RegisterPersonalContactDetails(router)
	personal_forms.RegisterPersonalCreditInfo(router)
	personal_forms.RegisterPersonalLoanForm(router)

	// Register business form routes
	business_forms.RegisterBusinessITRPDFRoutes(router)
	business_forms.RegisterBusinessBankDetails(router)
	business_forms.RegisterBusinessLoanForm(router)
	business_forms.RegisterGSTDetails(router)
	business_forms.RegisterGSTBusinessDetails(router)
	business_forms.RegisterStakeholdersDetails(router)

	// Start the HTTP server
	log.Println("Starting server on :8080")
	if err := router.Run(":8080"); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
