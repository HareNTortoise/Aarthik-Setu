package handlers

import (
	"encoding/json"
	"net/http"

	"aarthik-setu/internal/services"

	"github.com/go-playground/validator/v10"
)

type AuthHandler struct {
	authService *services.AuthService
	validate    *validator.Validate
}

func NewAuthHandler(authService *services.AuthService) *AuthHandler {
	return &AuthHandler{
		authService: authService,
		validate:    validator.New(),
	}
}

type GoogleSignInRequest struct {
	IDToken string `json:"idToken" validate:"required"`
}

func (h *AuthHandler) GoogleSignIn(w http.ResponseWriter, r *http.Request) {
	var requestBody GoogleSignInRequest

	if err := json.NewDecoder(r.Body).Decode(&requestBody); err != nil {
		http.Error(w, "Invalid request body", http.StatusBadRequest)
		return
	}

	if err := h.validate.Struct(requestBody); err != nil {
		http.Error(w, "Validation failed: "+err.Error(), http.StatusBadRequest)
		return
	}

	// Verify the Google token
	token, err := h.authService.VerifyGoogleToken(requestBody.IDToken)
	if err != nil {
		http.Error(w, "Invalid ID token", http.StatusUnauthorized)
		return
	}

	// Fetch the user details using the UID from the verified token
	userRecord, err := h.authService.GetUserByID(token.UID)
	if err != nil {
		http.Error(w, "Failed to fetch user details", http.StatusInternalServerError)
		return
	}

	response := map[string]interface{}{
		"uid":   userRecord.UID,
		"email": userRecord.Email,
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

type GoogleSignOutRequest struct {
	UID string `json:"uid" validate:"required"`
}

func (h *AuthHandler) GoogleSignOut(w http.ResponseWriter, r *http.Request) {
	var requestBody GoogleSignOutRequest

	if err := json.NewDecoder(r.Body).Decode(&requestBody); err != nil {
		http.Error(w, "Invalid request body", http.StatusBadRequest)
		return
	}

	if err := h.validate.Struct(requestBody); err != nil {
		http.Error(w, "Validation failed: "+err.Error(), http.StatusBadRequest)
		return
	}

	if err := h.authService.RevokeUserTokens(requestBody.UID); err != nil {
		http.Error(w, "Failed to sign out user", http.StatusInternalServerError)
		return
	}

	response := map[string]string{
		"message": "User signed out successfully",
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}
