package personal

import (
	"aarthik-setu/internal/api/handlers/personal"

	"github.com/gorilla/mux"
)

func SetupITRRoutes(router *mux.Router, handler *personal.ITRHandler) {
	router.HandleFunc("/personal/itr", handler.CreateITRForm).Methods("POST")
	router.HandleFunc("/personal/itr/{id}", handler.GetITRForm).Methods("GET")
	router.HandleFunc("/personal/itr/{id}", handler.UpdateITRForm).Methods("PUT")
	router.HandleFunc("/personal/itr/{id}", handler.DeleteITRForm).Methods("DELETE")
}
