package personal

import (
	"aarthik-setu/internal/models/personal"
	"encoding/json"
	"log"
	"net/http"
	"strconv"

	personalService "aarthik-setu/internal/services/personal" // Aliased import

	"github.com/gorilla/mux"
)

type ITRHandler struct {
	service *personalService.ITRService
}

func NewITRHandler(service *personalService.ITRService) *ITRHandler {
	return &ITRHandler{
		service: service,
	}
}

func (h *ITRHandler) CreateITRForm(w http.ResponseWriter, r *http.Request) {
	// Parse the form data
	if err := r.ParseMultipartForm(32 << 20); err != nil { // 32 MB limit
		http.Error(w, "Failed to parse form data", http.StatusBadRequest)
		log.Printf("Error parsing form data: %v", err)
		return
	}

	// Extract form values
	userID := r.FormValue("user_id")
	submissionDate := r.FormValue("submission_date")
	incomeType := r.FormValue("income_type")
	annualIncomeStr := r.FormValue("annual_income")
	incomeDeclaration := r.FormValue("income_declaration")
	financialYear := r.FormValue("financial_year")
	itrFilePath := r.FormValue("itr_file_path")
	itrStatus := r.FormValue("itr_status")
	isManualStr := r.FormValue("is_manual")
	formType := r.FormValue("form_type")

	// Convert annualIncome and isManual to appropriate types
	annualIncome, err := strconv.ParseFloat(annualIncomeStr, 64)
	if err != nil {
		http.Error(w, "Invalid annual income format", http.StatusBadRequest)
		log.Printf("Error parsing annual income: %v", err)
		return
	}

	isManual, err := strconv.ParseBool(isManualStr)
	if err != nil {
		http.Error(w, "Invalid is_manual format", http.StatusBadRequest)
		log.Printf("Error parsing is_manual: %v", err)
		return
	}

	// Create form instance
	form := personal.ITRForm{
		UserID:            userID,
		SubmissionDate:    submissionDate,
		IncomeType:        incomeType,
		AnnualIncome:      annualIncome,
		IncomeDeclaration: incomeDeclaration,
		FinancialYear:     financialYear,
		ITRFilePath:       itrFilePath,
		ITRStatus:         itrStatus,
		IsManual:          isManual,
		FormType:          formType,
	}

	// Log the form data
	log.Printf("Received form data: %+v", form)

	// Call service to create the ITR form
	err = h.service.CreateITRForm(r.Context(), &form)
	if err != nil {
		http.Error(w, "Failed to create ITR form", http.StatusInternalServerError)
		log.Printf("Error creating ITR form: %v", err)
		return
	}

	// Respond with success
	w.WriteHeader(http.StatusCreated)
	log.Println("ITR form created successfully")
}

func (h *ITRHandler) GetITRForm(w http.ResponseWriter, r *http.Request) {
	id := mux.Vars(r)["id"]
	form, err := h.service.GetITRForm(r.Context(), id)
	if err != nil {
		http.Error(w, "ITR form not found", http.StatusNotFound)
		return
	}
	json.NewEncoder(w).Encode(form)
}

func (h *ITRHandler) UpdateITRForm(w http.ResponseWriter, r *http.Request) {
	id := mux.Vars(r)["id"]
	var form personal.ITRForm
	if err := json.NewDecoder(r.Body).Decode(&form); err != nil {
		http.Error(w, "Invalid request payload", http.StatusBadRequest)
		return
	}
	err := h.service.UpdateITRForm(r.Context(), id, &form)
	if err != nil {
		http.Error(w, "Failed to update ITR form", http.StatusInternalServerError)
		return
	}
	w.WriteHeader(http.StatusOK)
}

func (h *ITRHandler) DeleteITRForm(w http.ResponseWriter, r *http.Request) {
	id := mux.Vars(r)["id"]
	err := h.service.DeleteITRForm(r.Context(), id)
	if err != nil {
		http.Error(w, "Failed to delete ITR form", http.StatusInternalServerError)
		return
	}
	w.WriteHeader(http.StatusNoContent)
}
