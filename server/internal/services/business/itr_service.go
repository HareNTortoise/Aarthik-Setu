package business

import (
	"context"
	"fmt"
	"io"
	"log"
	"strings"
	"time"
	"cloud.google.com/go/firestore"
	"cloud.google.com/go/storage"
	businessModel "aarthik-setu/internal/models/business"
	"bytes"
)

// ITRService struct to handle ITR form operations
type ITRService struct {
	firestoreClient *firestore.Client
	storageClient   *storage.Client
	bucketName      string
}

// NewITRService initializes a new instance of ITRService with Firestore and Storage clients.
func NewITRService(firestoreClient *firestore.Client, storageClient *storage.Client, bucketName string) *ITRService {
	return &ITRService{
		firestoreClient: firestoreClient,
		storageClient:   storageClient,
		bucketName:      bucketName, // Add the bucket name as a parameter
	}
}

// UploadPDFsToFirestore uploads the provided PDFs for a user to Firestore
func (s *ITRService) UploadPDFsToFirestore(ctx context.Context, userID string, filename1 string, fileContent1 []byte, filename2 string, fileContent2 []byte, filename3 string, fileContent3 []byte) error {
	// Sanitize UserID to avoid trailing slashes
	userID = strings.TrimSpace(userID)
	if userID == "" {
		return fmt.Errorf("invalid UserID: cannot be empty")
	}

	// Verify that the UserID does not contain invalid characters or slashes
	if strings.HasPrefix(userID, "/") || strings.HasSuffix(userID, "/") {
		return fmt.Errorf("invalid UserID: cannot start or end with a slash")
	}

	// Create a document with the ITR form structure
	form := businessModel.ITRForm{
		UserID: userID,
	}

	// Upload PDFs to Storage and get download URLs
	var err error
	form.PDF1URL, err = s.uploadPDFToStorage(ctx, userID, filename1, fileContent1)
	if err != nil {
		return fmt.Errorf("failed to upload PDF1: %w", err)
	}

	if len(filename2) > 0 {
		form.PDF2URL, err = s.uploadPDFToStorage(ctx, userID, filename2, fileContent2)
		if err != nil {
			return fmt.Errorf("failed to upload PDF2: %w", err)
		}
	}

	if len(filename3) > 0 {
		form.PDF3URL, err = s.uploadPDFToStorage(ctx, userID, filename3, fileContent3)
		if err != nil {
			return fmt.Errorf("failed to upload PDF3: %w", err)
		}
	}

	// Save form data into Firestore
	_, err = s.firestoreClient.Collection("itr_forms").Doc(userID).Set(ctx, form)
	if err != nil {
		log.Printf("Failed to upload PDFs for UserID %s: %v", userID, err)
		return err
	}

	log.Printf("Successfully uploaded PDFs for UserID: %s", userID)
	return nil
}

// uploadPDFToStorage uploads a PDF to Storage and returns the download URL
func (s *ITRService) uploadPDFToStorage(ctx context.Context, userID string, filename string, fileContent []byte) (string, error) {
	objectName := fmt.Sprintf("%s/%s", userID, filename)

	bucket := s.storageClient.Bucket(s.bucketName)
	file := bucket.Object(objectName)

	writer := file.NewWriter(ctx)
	defer writer.Close()

	// Write file content to the bucket
	if _, err := io.Copy(writer, bytes.NewReader(fileContent)); err != nil {
		return "", fmt.Errorf("failed to write file content: %w", err)
	}

	// Close the writer to finalize the upload
	if err := writer.Close(); err != nil {
		return "", fmt.Errorf("failed to close writer: %w", err)
	}

	// Get the signed URL with an expiration of 10 years
	url, err := s.getSignedURL(ctx, objectName)
	if err != nil {
		return "", fmt.Errorf("failed to get signed URL: %w", err)
	}

	return url, nil
}

// getSignedURL generates a signed URL for the uploaded file
func (s *ITRService) getSignedURL(ctx context.Context, objectName string) (string, error) {
	// Set up SignedURLOptions for the signed URL
	opts := &storage.SignedURLOptions{
		Method:  "GET",
		Expires: time.Now().Add(10 * 365 * 24 * time.Hour), // 10 years
	}

	// Generate the signed URL
	url, err := storage.SignedURL(s.bucketName, objectName, opts)
	if err != nil {
		return "", fmt.Errorf("failed to generate signed URL: %w", err)
	}
	return url, nil
}

