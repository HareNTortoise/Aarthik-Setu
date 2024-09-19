package routes

import (
	"aarthik-setu/internal/api/handlers"

	"github.com/gorilla/mux"
)

func SetupAuthRoutes(router *mux.Router, authHandler *handlers.AuthHandler) {
	router.HandleFunc("/auth/google", authHandler.GoogleSignIn).Methods("POST")
	router.HandleFunc("/auth/google/signout", authHandler.GoogleSignOut).Methods("POST")
}
