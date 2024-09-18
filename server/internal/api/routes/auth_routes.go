package routes

import (
	"aarthik-setu/internal/api/handlers"

	"github.com/gorilla/mux"
)

func SetupAuthRoutes(router *mux.Router, authHandler *handlers.AuthHandler) {
	router.HandleFunc("/auth/google", authHandler.GoogleSignIn).Methods("POST")
}
