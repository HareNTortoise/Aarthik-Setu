package auth

import (
	"context"
	"log"
	"path/filepath"
	"io"
	"cloud.google.com/go/firestore"
	"cloud.google.com/go/storage"
	firebase "firebase.google.com/go"
	"google.golang.org/api/option"
	"os"
	"google.golang.org/api/iterator"
)

var (
	FirestoreClient *firestore.Client
	StorageClient   *storage.Client
	BucketName      = "your-bucket-name" // Replace with your bucket name
)

// InitializeFirebaseApp initializes the Firebase app.
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

// InitializeFirestore initializes the Firestore client.
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

// InitializeStorage initializes the Google Cloud Storage client.
func InitializeStorage(app *firebase.App) error {
	ctx := context.Background()

	client, err := storage.NewClient(ctx, option.WithCredentialsFile("./config/firebase-service-account.json"))
	if err != nil {
		log.Fatalf("Error initializing Storage client: %v", err)
		return err
	}

	StorageClient = client
	log.Println("Storage initialized successfully")
	return nil
}

// CloseFirestore closes the Firestore client.
func CloseFirestore() {
	if FirestoreClient != nil {
		FirestoreClient.Close()
	}
}

// CloseStorage closes the Storage client.
func CloseStorage() {
	if StorageClient != nil {
		StorageClient.Close()
	}
}

// UploadFile uploads a file to the specified bucket.
func UploadFile(ctx context.Context, filePath string, destination string) error {
	bucket := StorageClient.Bucket(BucketName)
	file, err := os.Open(filePath)
	if err != nil {
		return err
	}
	defer file.Close()

	wc := bucket.Object(destination).NewWriter(ctx)
	if _, err := io.Copy(wc, file); err != nil {
		return err
	}
	if err := wc.Close(); err != nil {
		return err
	}

	log.Printf("File %s uploaded to %s.", filePath, destination)
	return nil
}

// DownloadFile downloads a file from the specified bucket.
func DownloadFile(ctx context.Context, source string, destination string) error {
	bucket := StorageClient.Bucket(BucketName)
	rc, err := bucket.Object(source).NewReader(ctx)
	if err != nil {
		return err
	}
	defer rc.Close()

	file, err := os.Create(destination)
	if err != nil {
		return err
	}
	defer file.Close()

	if _, err := io.Copy(file, rc); err != nil {
		return err
	}

	log.Printf("File %s downloaded to %s.", source, destination)
	return nil
}

// ListFiles lists all files in the specified bucket.
func ListFiles(ctx context.Context) ([]string, error) {
	var files []string
	bucket := StorageClient.Bucket(BucketName)
	it := bucket.Objects(ctx, nil)

	for {
		obj, err := it.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return nil, err
		}
		files = append(files, obj.Name)
	}

	return files, nil
}
