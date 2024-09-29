package firebase

import (
	"context"
	"log"
	"cloud.google.com/go/firestore"
	"google.golang.org/api/option"
	"cloud.google.com/go/storage"
	"crypto/rand"
	"encoding/hex"
	"fmt"

)

// Initialize Firebase Firestore
func InitFirestore() *firestore.Client {
	ctx := context.Background()
	sa := option.WithCredentialsFile("./config/firebase/firebase-service-account.json") // Use your credentials file path
	client, err := firestore.NewClient(ctx, "aarthik-setu", sa)
	if err != nil {
		log.Fatalf("Failed to initialize Firestore: %v", err)
	}
	return client
}

// Initialize Firebase Cloud Storage
func InitStorage() *storage.Client {
	ctx := context.Background()
	sa := option.WithCredentialsFile("./config/firebase/firebase-service-account.json") // Use your credentials file path
	client, err := storage.NewClient(ctx, sa)
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
