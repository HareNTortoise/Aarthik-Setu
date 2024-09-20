package business

import (
	"context"
	"fmt"
	"log"
	"strings"

	"cloud.google.com/go/firestore"
	businessModel "aarthik-setu/internal/models/business"
)

// GSTDetails represents the structure for storing GST details
// type GSTDetails struct {
// 	UserID string            `firestore:"user_id"`
// 	Details map[string]string `firestore:"gst_details"`
// }

// GSTService handles Firestore operations for GST details
type GSTService struct {
	firestoreClient *firestore.Client
}

// NewGSTService creates a new instance of GSTService
func NewGSTService(client *firestore.Client) *GSTService {
	return &GSTService{
		firestoreClient: client,
	}
}

// CreateGSTDetailsForm stores GST details in Firestore
func (s *GSTService) CreateGSTDetailsForm(ctx context.Context, details *businessModel.GSTDetails) error {
	log.Printf("Creating GST details form for UserID: %s", details.UserID)

	// Sanitize UserID to avoid trailing slashes
	userID := strings.TrimSpace(details.UserID)
	if userID == "" {
		return fmt.Errorf("invalid UserID: cannot be empty")
	}

	// Verify that the UserID does not contain invalid characters or slashes
	if strings.HasPrefix(userID, "/") || strings.HasSuffix(userID, "/") {
		return fmt.Errorf("invalid UserID: cannot start or end with a slash")
	}

	// Save GST details in the "gst_forms" collection with UserID as the document ID
	_, err := s.firestoreClient.Collection("business_gst_forms").Doc(userID).Set(ctx, details)
	if err != nil {
		log.Printf("Failed to create GST details for UserID %s: %v", userID, err)
		return err
	}

	log.Printf("Successfully created GST details form for UserID: %s", userID)
	return nil
}
