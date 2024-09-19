package personal

import (
	"aarthik-setu/internal/models/personal"
	"context"
	"fmt"
	"log"
	"strings"

	"cloud.google.com/go/firestore"
)

type ITRService struct {
	firestoreClient *firestore.Client
}

func NewITRService(client *firestore.Client) *ITRService {
	return &ITRService{
		firestoreClient: client,
	}
}

func (s *ITRService) CreateITRForm(ctx context.Context, form *personal.ITRForm) error {
	log.Printf("Creating ITR form for UserID: %s", form.UserID)
	// Sanitize UserID to avoid trailing slashes
	userID := strings.TrimSpace(form.UserID)
	if userID == "" {
		return fmt.Errorf("invalid UserID: cannot be empty")
	}

	// Verify that the UserID does not contain invalid characters or slashes
	if strings.HasPrefix(userID, "/") || strings.HasSuffix(userID, "/") {
		return fmt.Errorf("invalid UserID: cannot start or end with a slash")
	}

	_, err := s.firestoreClient.Collection("itr_forms").Doc(userID).Set(ctx, form)
	if err != nil {
		log.Printf("Failed to create ITR form for UserID %s: %v", userID, err)
		return err
	}
	log.Printf("Successfully created ITR form for UserID: %s", userID)
	return nil
}

func (s *ITRService) GetITRForm(ctx context.Context, id string) (*personal.ITRForm, error) {
	log.Printf("Getting ITR form with ID: %s", id)
	doc, err := s.firestoreClient.Collection("itr_forms").Doc(id).Get(ctx)
	if err != nil {
		log.Printf("Failed to get ITR form with ID %s: %v", id, err)
		return nil, err
	}
	var form personal.ITRForm
	if err := doc.DataTo(&form); err != nil {
		log.Printf("Failed to unmarshal ITR form with ID %s: %v", id, err)
		return nil, err
	}
	log.Printf("Successfully retrieved ITR form with ID: %s", id)
	return &form, nil
}

func (s *ITRService) UpdateITRForm(ctx context.Context, id string, form *personal.ITRForm) error {
	log.Printf("Updating ITR form with ID: %s", id)
	_, err := s.firestoreClient.Collection("itr_forms").Doc(id).Set(ctx, form)
	if err != nil {
		log.Printf("Failed to update ITR form with ID %s: %v", id, err)
		return err
	}
	log.Printf("Successfully updated ITR form with ID: %s", id)
	return nil
}

func (s *ITRService) DeleteITRForm(ctx context.Context, id string) error {
	log.Printf("Deleting ITR form with ID: %s", id)
	_, err := s.firestoreClient.Collection("itr_forms").Doc(id).Delete(ctx)
	if err != nil {
		log.Printf("Failed to delete ITR form with ID %s: %v", id, err)
		return err
	}
	log.Printf("Successfully deleted ITR form with ID: %s", id)
	return nil
}
