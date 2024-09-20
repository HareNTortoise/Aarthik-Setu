package business

import (
	"fmt"
	"github.com/gorilla/mux"
	handler "aarthik-setu/internal/api/handlers/business"
)

// SetupGST-Detail Routes

func SetupGSTDetailRoutes(router *mux.Router) {
	router.HandleFunc("/business/gst-details", handler.GSTDetailsRegister).Methods("POST")
	fmt.Println("Setting up GST Detail routes")
}