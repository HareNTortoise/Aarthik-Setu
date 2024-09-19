package auth

import (
	"context"
	"log"
	"path/filepath"

	"cloud.google.com/go/firestore"
	firebase "firebase.google.com/go"
	"google.golang.org/api/option"
)

var FirestoreClient *firestore.Client

func InitializeFirebaseApp() (*firebase.App, error) {
	serviceAccountKeyFilePath, err := filepath.Abs("./config/firebase-service-account.json")
	if err != nil {
		return nil, err
	}

	opt := option.WithCredentialsFile(serviceAccountKeyFilePath)
	app, err := firebase.NewApp(context.Background(), nil, opt)
	if err != nil {
		return nil, err
	}
	return app, nil
}

func InitializeFirestore(app *firebase.App) error {
	ctx := context.Background()

	client, err := app.Firestore(ctx)
	if err != nil {
		log.Fatalf("Error initializing Firestore client: %v", err)
		return err
	}

	FirestoreClient = client
	log.Println("Firestore initialized successfully")
	return nil
}

func CloseFirestore() {
	if FirestoreClient != nil {
		FirestoreClient.Close()
	}
}
