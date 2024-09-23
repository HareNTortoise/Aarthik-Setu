package main

import (
	"log"
	personal_forms "server/routes/forms/personal_forms"
	business_forms "server/routes/forms/business_forms"
	"github.com/joho/godotenv"
	"github.com/gin-gonic/gin"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}
	router := gin.Default()

	// Register ITR form routes
	personal_forms.RegisterPersonalITRRoutes(router)
	personal_forms.RegisterPersonalITRPDFRoutes(router)
	personal_forms.RegisterPersonalBankDetails(router)
	// personal_forms.RegisterPersonalBasicDetails(router)
	// personal_forms.RegisterPersonalEmploymentDetails(router)
	// personal_forms.RegisterPersonalContactDetails(router)
	// personal_forms.RegisterPersonalCreditInfo(router)
	// personal_forms.RegisterPersonalLoanForm(router)

	business_forms.RegisterBusinessITRPDFRoutes(router)
	// Start the HTTP server
	log.Println("Starting server on :8080")
	if err := router.Run(":8080"); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
