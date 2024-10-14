package main

import (
	"context"
	"log"
	"net/http"
	"os"
	"os/signal"
	chat "server/routes/chatbot"
	business_forms "server/routes/forms/business_forms"
	gen_ai "server/routes/forms/gen_ai"
	personal_forms "server/routes/forms/personal_forms"
	info_extraction "server/routes/info_extraction"
	lender "server/routes/lenders"
	profile_applications "server/routes/profile_applications"
	schemes "server/routes/schemes"
	"time"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

const (
	StatusOK = 200
)

func main() {
	// Load .env file
	if err := godotenv.Load(); err != nil {
		log.Fatalf("Error loading .env file: %v", err)
	}

	// Set Gin mode based on environment variable
	mode := os.Getenv("GIN_MODE")
	if mode == "" {
		mode = gin.DebugMode // Default to debug mode if GIN_MODE is not set
	}
	gin.SetMode(mode)

	// Create a new router instance
	router := gin.Default()

	// Apply middlewares
	applyMiddlewares(router)

	// Register routes
	registerRoutes(router)

	// Start the HTTP server with graceful shutdown
	startServer(router)
}

func applyMiddlewares(router *gin.Engine) {
	// Apply CORS middleware with origins from environment variable
	corsOrigins := os.Getenv("CORS_ORIGINS")
	if corsOrigins == "" {
		corsOrigins = "*" // Default to allow all origins
	}
	router.Use(cors.New(cors.Config{
		AllowOrigins:     []string{corsOrigins},
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Authorization"},
		AllowCredentials: true,
	}))

	// Add middleware to set Cross-Origin-Opener-Policy header
	router.Use(func(c *gin.Context) {
		c.Writer.Header().Set("Cross-Origin-Opener-Policy", "same-origin")
		c.Next()
	})
}

// Register all routes to the router
func registerRoutes(router *gin.Engine) {
	// Health check endpoint
	router.GET("/ping", func(c *gin.Context) {
		c.JSON(StatusOK, gin.H{
			"message": "pong",
		})
	})

	// Register route groups
	registerPersonalRoutes(router)
	registerBusinessRoutes(router)
	registerProfileRoutes(router)
	registerGenAIRoutes(router)
	registerInfoExtractionRoutes(router)
	registerSchemesRoutes(router)
	registerChatRoutes(router)
	registerlendersRoutes(router)
}

// Register personal form routes
func registerPersonalRoutes(router *gin.Engine) {
	personal_forms.RegisterPersonalITRRoutes(router)
	personal_forms.RegisterPersonalITRPDFRoutes(router)
	personal_forms.RegisterPersonalBankDetails(router)
	personal_forms.RegisterPersonalBasicDetails(router)
	personal_forms.RegisterPersonalEmploymentDetails(router)
	personal_forms.RegisterPersonalContactDetails(router)
	personal_forms.RegisterPersonalCreditInfo(router)
	personal_forms.RegisterPersonalLoanForm(router)
}

// Register business form routes
func registerBusinessRoutes(router *gin.Engine) {
	business_forms.RegisterBusinessITRPDFRoutes(router)
	business_forms.RegisterBusinessBankDetails(router)
	business_forms.RegisterBusinessLoanForm(router)
	business_forms.RegisterGSTDetails(router)
	business_forms.RegisterGSTBusinessDetails(router)
	business_forms.RegisterStakeholdersDetails(router)
}

// Register profile application routes
func registerProfileRoutes(router *gin.Engine) {
	profile_applications.RegisterPersonalProfileRoutes(router)
	profile_applications.RegisterBusinessProfileRoutes(router)
	profile_applications.RegisterBusinessApplicationsRoutes(router)
	profile_applications.RegisterPersonalApplicationsRoutes(router)
}

// Register GenAI routes
func registerGenAIRoutes(router *gin.Engine) {
	gen_ai.GenAIFormRoutes(router)
}

// Register information extraction routes
func registerInfoExtractionRoutes(router *gin.Engine) {
	info_extraction.RegisterITRInfoExtractionRoutes(router)
	info_extraction.RegisterBankStatementInfoExtractionRoutes(router)
	info_extraction.RegisterSuggestLenders(router)
	info_extraction.GetCreditScore(router)
}

// Register government schemes routes
func registerSchemesRoutes(router *gin.Engine) {
	schemes.RegisterPublicSchemesInfoRoutes(router)
}

// Register chat routes
func registerChatRoutes(router *gin.Engine) {
	chat.SetupRoutes(router)
}

// Register chat routes
func registerlendersRoutes(router *gin.Engine) {
	lender.SetuplendersRoutes(router)
}

// Start the HTTP server with graceful shutdown
func startServer(router *gin.Engine) {
	port := os.Getenv("PORT")
	// if port == "" {
	// 	port = "8080" // Default to 8080 if not specified
	// }

	server := &http.Server{
		Addr:    ":" + port,
		Handler: router,
	}

	// Start server in a goroutine
	go func() {
		log.Printf("Starting server on port %s", port)
		if err := server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			log.Fatalf("Failed to start server: %v", err)
		}
	}()

	// Wait for interrupt signal to gracefully shut down the server
	quit := make(chan os.Signal, 1)
	signal.Notify(quit, os.Interrupt)

	<-quit
	log.Println("Shutting down server...")

	// Gracefully shutdown the server, waiting for ongoing processes to complete
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := server.Shutdown(ctx); err != nil {
		log.Fatalf("Server forced to shutdown: %v", err)
	}

	log.Println("Server exiting")
}
