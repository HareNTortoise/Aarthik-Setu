package main

import (
	"context"
	"log"
	"net/http"

	authhandlers "aarthik-setu/internal/api/handlers"
	personalhandlers "aarthik-setu/internal/api/handlers/personal"
	authroutes "aarthik-setu/internal/api/routes"
	personalroutes "aarthik-setu/internal/api/routes/personal"
	authService "aarthik-setu/internal/services"
	personalServices "aarthik-setu/internal/services/personal"

	// businessHandler "aarthik-setu/internal/api/handlers/business"
	businessroutes "aarthik-setu/internal/api/routes/business"
	// businessService "aarthik-setu/internal/services/business"

	"aarthik-setu/pkg/auth"

	// "cloud.google.com/go/storage"
	"github.com/gorilla/mux"
	"github.com/rs/cors"
)

func main() {
	log.Println("Initializing Firebase app...")

	// Initialize Firebase app
	app, err := auth.InitializeFirebaseApp()
	if err != nil {
		log.Fatalf("Error initializing Firebase app: %v\n", err)
	}
	log.Println("Firebase app initialized successfully.")

	// Create an auth client
	log.Println("Creating Auth client...")
	client, err := app.Auth(context.Background())
	if err != nil {
		log.Fatalf("Error getting Auth client: %v\n", err)
	}
	log.Println("Auth client created successfully.")

	// Initialize Firestore client
	log.Println("Initializing Firestore client...")
	firestoreClient, err := app.Firestore(context.Background())
	if err != nil {
		log.Fatalf("Error getting Firestore client: %v\n", err)
	}
	log.Println("Firestore client initialized successfully.")
	// storageClient, err := storage.NewClient(context.Background())
	if err != nil {
		log.Fatalf("Error getting Storage client: %v\n", err)
	}
	log.Println("Storage client initialized successfully.")
	// bucketName := "aarthik-setu.appspot.com"
	// Initialize services
	log.Println("Initializing services...")
	authService := authService.NewAuthService(client)
	itrService := personalServices.NewITRService(firestoreClient)
	// businessService := businessService.NewITRService(firestoreClient, storageClient, bucketName)
	log.Println("Services initialized successfully.")

	// Initialize handlers
	log.Println("Initializing handlers...")
	authHandler := authhandlers.NewAuthHandler(authService)
	itrHandler := personalhandlers.NewITRHandler(itrService)
	// businessHandler := businessHandler.NewITRHandler(businessService)
	log.Println("Handlers initialized successfully.")

	// Set up router
	log.Println("Setting up router...")
	router := mux.NewRouter()

	// Set up routes
	log.Println("Setting up routes...")
	authroutes.SetupAuthRoutes(router, authHandler)
	personalroutes.SetupITRRoutes(router, itrHandler)
	// businessroutes.SetupBusinessRoutes(router, businessHandler)
	businessroutes.SetupGSTDetailRoutes(router)
	log.Println("Routes set up successfully.")

	// Create a CORS wrapper
	log.Println("Creating CORS wrapper...")
	c := cors.New(cors.Options{
		AllowedOrigins: []string{"*"}, // Be more specific in production
		AllowedMethods: []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowedHeaders: []string{"Content-Type", "Authorization"},
	})
	log.Println("CORS wrapper created successfully.")

	// Use the CORS wrapper
	handler := c.Handler(router)

	// Start the server
	log.Println("Starting server on http://localhost:8080")
	if err := http.ListenAndServe(":8080", handler); err != nil {
		log.Fatalf("Error starting server: %v\n", err)
	}
}
