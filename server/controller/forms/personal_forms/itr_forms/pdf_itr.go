package itr_forms

import (
	"context"
	"fmt"
	"io"
	"log"
	"mime/multipart"
	"net/http"
	utils "server/config/firebase"

	"cloud.google.com/go/storage"
	"github.com/gin-gonic/gin"
)

// UploadITRDocuments handles the upload of ITR PDF documents without requiring a userId.
func UploadITRDocuments(c *gin.Context) {
	// Get the file from the form-data
	file, err := c.FormFile("file")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "File is required"})
		log.Println("Error: File not provided in the form")
		return
	}
	log.Println("File received:", file.Filename)

	// Read the file
	src, err := file.Open()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to open file"})
		log.Printf("Error opening file %s: %v\n", file.Filename, err)
		return
	}
	defer src.Close()

	// Initialize the Storage client
	storageClient := utils.InitStorage()
	if storageClient == nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to initialize storage client"})
		log.Println("Error: Failed to initialize Firebase storage client")
		return
	}
	log.Println("Storage client initialized")

	bucketName := "aarthik-setu.appspot.com" // Corrected bucket name

	// Prepare the file name and destination path in storage
	// Use the filename from the uploaded file directly
	objectName := fmt.Sprintf("personal_itr_documents/%s", file.Filename)
	log.Printf("Uploading file %s to bucket %s\n", objectName, bucketName)

	// Upload the file to Cloud Storage
	if err := uploadPDF(storageClient, bucketName, objectName, src); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Failed to upload file: %v", err)})
		log.Printf("Error uploading file %s: %v\n", file.Filename, err)
		return
	}

	// Construct the file URL
	fileURL := fmt.Sprintf("https://storage.googleapis.com/%s/%s", bucketName, objectName)
	log.Println("File uploaded successfully, accessible at:", fileURL)

	c.JSON(http.StatusOK, gin.H{"message": "File uploaded successfully", "fileURL": fileURL})
}

// uploadPDF uploads a PDF file to Cloud Storage
func uploadPDF(client *storage.Client, bucketName, objectName string, src multipart.File) error {
	ctx := context.Background()
	bucket := client.Bucket(bucketName)
	object := bucket.Object(objectName)

	writer := object.NewWriter(ctx)
	defer writer.Close()

	// Debug: logging the object upload start
	log.Printf("Starting file upload: %s\n", objectName)

	if _, err := io.Copy(writer, src); err != nil {
		log.Printf("Error copying data to Cloud Storage for object %s: %v\n", objectName, err)
		return err
	}

	// Debug: logging successful upload
	log.Printf("File uploaded successfully: %s\n", objectName)
	return nil
}

// package itr_forms

// import (
// 	"context"
// 	"fmt"
// 	"net/http"
// 	"github.com/gin-gonic/gin"
// 	"github.com/kurin/blazer/b2"
// 	"mime/multipart"
// 	// "os"
// )

// // Function to initialize Backblaze B2 client
// func InitBackblazeB2() (*b2.Client, error) {
// 	// Use your Backblaze B2 Account ID and Application Key
// 	accountID := "df2164e6fdfe"
// 	appKey := "0057677f62db22df6391fb7668f0cd4fd8df2f495c"

// 	// Authorize the client
// 	client, err := b2.NewClient(context.Background(), accountID, appKey)
// 	if err != nil {
// 		return nil, err
// 	}

// 	return client, nil
// }

// func uploadPDFToB2(client *b2.Client, bucketName string, objectName string, file multipart.File) error {
// 	// Find the bucket
// 	bucket, err := client.Bucket(context.Background(), bucketName)
// 	if err != nil {
// 		return fmt.Errorf("unable to find bucket: %v", err)
// 	}

// 	// Create the file object in B2
// 	writer := bucket.Object(objectName).NewWriter(context.Background())
// 	defer writer.Close()

// 	// Copy file content to B2 object
// 	if _, err := writer.ReadFrom(file); err != nil {
// 		return fmt.Errorf("failed to upload file: %v", err)
// 	}

// 	return nil
// }

// func UploadITRDocuments(c *gin.Context) {
// 	// Get the file from the form-data
// 	file, err := c.FormFile("file")
// 	if err != nil {
// 		c.JSON(http.StatusBadRequest, gin.H{"error": "File is required"})
// 		return
// 	}

// 	// Open the uploaded file
// 	src, err := file.Open()
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to open file"})
// 		return
// 	}
// 	defer src.Close()

// 	// Initialize Backblaze B2 client
// 	b2Client, err := InitBackblazeB2()
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to initialize Backblaze B2 client"})
// 		return
// 	}

// 	// Bucket and object settings
// 	bucketName := "aarthik-pdfs" // Replace with your actual bucket name
// 	objectName := fmt.Sprintf("personal_itr_documents/%s", file.Filename)

// 	// Upload file to Backblaze B2
// 	if err := uploadPDFToB2(b2Client, bucketName, objectName, src); err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Failed to upload file to B2: %v", err)})
// 		return
// 	}

// 	// Generate the public URL for the uploaded file
// 	fileURL := fmt.Sprintf("https://f000.backblazeb2.com/file/%s/%s", bucketName, objectName)

// 	c.JSON(http.StatusOK, gin.H{"message": "File uploaded successfully", "fileURL": fileURL})
// }
