package main

import (
	"context"
	"log"
	"net/http"

	"aarthik-setu/internal/api/handlers"
	"aarthik-setu/internal/api/routes"
	"aarthik-setu/internal/services"
	"aarthik-setu/pkg/auth"

	"github.com/gorilla/mux"
)

func main() {
	// Initialize Firebase app
	app, err := auth.InitializeFirebaseApp()
	if err != nil {
		log.Fatalf("Error initializing Firebase app: %v\n", err)
	}

	// Create an auth client
	client, err := app.Auth(context.Background())
	if err != nil {
		log.Fatalf("Error getting Auth client: %v\n", err)
	}

	// Initialize services
	authService := services.NewAuthService(client)

	// Initialize handlers
	authHandler := handlers.NewAuthHandler(authService)

	// Set up router
	router := mux.NewRouter()

	// Set up routes
	routes.SetupAuthRoutes(router, authHandler)

	// Start the server
	log.Println("Server starting on http://localhost:8080")
	log.Fatal(http.ListenAndServe(":8080", router))
}
