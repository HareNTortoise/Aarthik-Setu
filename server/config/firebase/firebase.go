package firebase

import (
	"context"
	"log"
	"cloud.google.com/go/firestore"
	"google.golang.org/api/option"
)

// Initialize Firebase Firestore
func InitFirestore() *firestore.Client {
	ctx := context.Background()
	sa := option.WithCredentialsFile("./config/firebase/firebase-service-account.json") // Use your credentials file path
	db, err := firestore.NewClient(ctx, "aarthik-setu", sa)
	if err != nil {
		log.Fatalf("Failed to initialize Firestore: %v", err)
	}
	return db
}
