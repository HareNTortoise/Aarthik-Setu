package handlers

import (
	"encoding/json"
	"net/http"

	"aarthik-setu/internal/services"
)

type AuthHandler struct {
	authService *services.AuthService
}

func NewAuthHandler(authService *services.AuthService) *AuthHandler {
	return &AuthHandler{authService: authService}
}

// Google Sign-In Handler
func (h *AuthHandler) GoogleSignIn(w http.ResponseWriter, r *http.Request) {
	var requestBody struct {
		IDToken string `json:"idToken"`
	}

	if err := json.NewDecoder(r.Body).Decode(&requestBody); err != nil {
		http.Error(w, "Invalid request body", http.StatusBadRequest)
		return
	}

	token, err := h.authService.VerifyGoogleToken(requestBody.IDToken)
	if err != nil {
		http.Error(w, "Invalid ID token", http.StatusUnauthorized)
		return
	}

	// Fetch user details
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

// Google Sign-Out Handler
func (h *AuthHandler) GoogleSignOut(w http.ResponseWriter, r *http.Request) {
	var requestBody struct {
		UID string `json:"uid"`
	}

	if err := json.NewDecoder(r.Body).Decode(&requestBody); err != nil {
		http.Error(w, "Invalid request body", http.StatusBadRequest)
		return
	}

	err := h.authService.RevokeUserTokens(requestBody.UID)
	if err != nil {
		http.Error(w, "Failed to revoke tokens", http.StatusInternalServerError)
		return
	}

	response := map[string]string{
		"message": "User signed out successfully",
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}
