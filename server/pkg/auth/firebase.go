package auth

import (
	"context"
	"path/filepath"

	firebase "firebase.google.com/go"
	"google.golang.org/api/option"
)

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
