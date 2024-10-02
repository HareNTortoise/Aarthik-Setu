package firebase

import (
	"context"
	"crypto/rand"
	"encoding/hex"
	"fmt"
	"log"
	"os"

	"cloud.google.com/go/firestore"
	"cloud.google.com/go/storage"
	"github.com/joho/godotenv"
	"google.golang.org/api/option"
)

func createFirebaseCredentialsFromEnv() string {
	return `{
		"type": "service_account",
		"project_id": "` + os.Getenv("FIREBASE_PROJECT_ID") + `",
		"private_key_id": "` + os.Getenv("FIREBASE_PRIVATE_KEY_ID") + `",
		"private_key": "` + os.Getenv("FIREBASE_PRIVATE_KEY") + `",
		"client_email": "` + os.Getenv("FIREBASE_CLIENT_EMAIL") + `",
		"client_id": "` + os.Getenv("FIREBASE_CLIENT_ID") + `",
		"auth_uri": "` + os.Getenv("FIREBASE_AUTH_URI") + `",
		"token_uri": "` + os.Getenv("FIREBASE_TOKEN_URI") + `",
		"auth_provider_x509_cert_url": "` + os.Getenv("FIREBASE_AUTH_PROVIDER_CERT_URL") + `",
		"client_x509_cert_url": "` + os.Getenv("FIREBASE_CLIENT_CERT_URL") + `",
		"universe_domain": "googleapis.com"
	}`
}

// Initialize Firebase Firestore
func InitFirestore() *firestore.Client {

	// Load environment variables from .env file
	err := godotenv.Load(".env")
	if err != nil {
		log.Fatalf("Error loading .env file: %v", err)
	}

	ctx := context.Background()

	// Create Firebase credentials from environment variables
	creds := option.WithCredentialsJSON([]byte(createFirebaseCredentialsFromEnv()))

	client, err := firestore.NewClient(ctx, os.Getenv("FIREBASE_PROJECT_ID"), creds)
	if err != nil {
		log.Fatalf("Failed to initialize Firestore: %v", err)
	}
	return client
}

// Initialize Firebase Cloud Storage
func InitStorage() *storage.Client {
	// Load environment variables from .env file
	err := godotenv.Load(".env")
	if err != nil {
		log.Fatalf("Error loading .env file: %v", err)
	}

	ctx := context.Background()

	// Create Firebase credentials from environment variables
	creds := option.WithCredentialsJSON([]byte(createFirebaseCredentialsFromEnv()))

	client, err := storage.NewClient(ctx, creds)
	if err != nil {
		log.Fatalf("Failed to initialize Cloud Storage: %v", err)
	}
	return client
}

func GenerateRandomString(length int) (string, error) {
	bytes := make([]byte, length)
	if _, err := rand.Read(bytes); err != nil {
		return "", err
	}
	return hex.EncodeToString(bytes)[:length], nil
}

func UpdateFirestoreDocument(ctx context.Context, collection string, documentId string, fieldPath string, value interface{}) error {
	// Get a reference to the document in the specified collection
	client := InitFirestore()
	docRef := client.Collection(collection).Doc(documentId)

	// Ensure the document exists
	_, err := docRef.Get(ctx)
	if err != nil {
		return fmt.Errorf("document not found: %v", err)
	}

	// Update the specified field with the new value
	_, err = docRef.Update(ctx, []firestore.Update{
		{Path: fieldPath, Value: value},
	})
	if err != nil {
		return fmt.Errorf("failed to update document: %v", err)
	}

	return nil
}
