package business

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"path/filepath"
	businessService "aarthik-setu/internal/services/business"
	"strings"
)

// ITRHandler struct with reference to ITRService
type ITRHandler struct {
	ITRService *businessService.ITRService
}

// NewITRHandler returns a new instance of ITRHandler
func NewITRHandler(service *businessService.ITRService) *ITRHandler {
	return &ITRHandler{
		ITRService: service,
	}
}

// CreateITRForm handles the form submission and file upload for ITR forms
func (h *ITRHandler) CreateITRForm(w http.ResponseWriter, r *http.Request) {
	// Parse the form with a max memory limit (e.g., 10 MB)
	err := r.ParseMultipartForm(10 << 20) // 10 MB
	if err != nil {
		http.Error(w, "Unable to parse form", http.StatusBadRequest)
		return
	}

	// Extract the user_id (this is required)
	userID := r.FormValue("user_id")
	userID = strings.TrimSpace(userID)
	if userID == "" {
		http.Error(w, "The user_id is required", http.StatusBadRequest)
		return
	}

	// Extract the mandatory first file (2022-23)
	pdf1, header1, err := r.FormFile("pdf1")
	if err != nil {
		http.Error(w, "The 2022-2023 PDF is required", http.StatusBadRequest)
		return
	}
	defer pdf1.Close()
	fileContent1, _ := ioutil.ReadAll(pdf1)
	filename1 := filepath.Base(header1.Filename)

	// Extract the optional second file (2021-22)
	var fileContent2 []byte
	var filename2 string
	pdf2, header2, err := r.FormFile("pdf2")
	if err == nil { // Only process if file is provided
		defer pdf2.Close()
		fileContent2, _ = ioutil.ReadAll(pdf2)
		filename2 = filepath.Base(header2.Filename)
	}

	// Extract the optional third file (2020-21)
	var fileContent3 []byte
	var filename3 string
	pdf3, header3, err := r.FormFile("pdf3")
	if err == nil { // Only process if file is provided
		defer pdf3.Close()
		fileContent3, _ = ioutil.ReadAll(pdf3)
		filename3 = filepath.Base(header3.Filename)
	}

	// Call the service to store files in Firestore
	err = h.ITRService.UploadPDFsToFirestore(r.Context(), userID, filename1, fileContent1, filename2, fileContent2, filename3, fileContent3)
	if err != nil {
		http.Error(w, "Failed to upload PDFs to Firestore", http.StatusInternalServerError)
		return
	}

	// Return success response
	w.WriteHeader(http.StatusOK)
	fmt.Fprintf(w, "PDFs successfully uploaded")
}
