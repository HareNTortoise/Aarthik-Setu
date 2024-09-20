package business

import (
	"aarthik-setu/internal/api/handlers/business"

	"github.com/gorilla/mux"
)

// SetupITRRoutes sets up the routes for ITR forms
func SetupBusinessITRRoutes(router *mux.Router, handler *business.ITRHandler) {
	router.HandleFunc("/business/itr", handler.CreateITRForm).Methods("POST")
// 	router.HandleFunc("/business/itr/{id}", handler.GetITRForm).Methods("GET")
// 	router.HandleFunc("/business/itr/{id}", handler.UpdateITRForm).Methods("PUT")
// 	router.HandleFunc("/business/itr/{id}", handler.DeleteITRForm).Methods("DELETE")
}