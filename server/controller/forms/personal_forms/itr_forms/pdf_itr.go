// package itr_forms

// import (
// 	"context"
// 	"fmt"
// 	"io"
// 	"net/http"
// 	"mime/multipart"
// 	"cloud.google.com/go/storage"
// 	"github.com/gin-gonic/gin"
// 	utils "server/config/firebase"
// )

// // UploadITRDocuments handles the upload of ITR PDF documents without requiring a userId.
// func UploadITRDocuments(c *gin.Context) {
// 	// Get the file from the form-data
// 	file, err := c.FormFile("file")
// 	if err != nil {
// 		c.JSON(http.StatusBadRequest, gin.H{"error": "File is required"})
// 		return
// 	}

// 	// Read the file
// 	src, err := file.Open()
// 	if err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to open file"})
// 		return
// 	}
// 	defer src.Close()

// 	// Initialize the Storage client
// 	storageClient := utils.InitStorage()

// 	bucketName := "default" // Replace with your actual bucket name

// 	// Prepare the file name and destination path in storage
// 	// Use the filename from the uploaded file directly
// 	objectName := fmt.Sprintf("personal_itr_documents/%s", file.Filename)

// 	// Upload the file to Cloud Storage
// 	if err := uploadPDF(storageClient, bucketName, objectName, src); err != nil {
// 		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Failed to upload file: %v", err)})
// 		return
// 	}

// 	// Construct the file URL
// 	fileURL := fmt.Sprintf("https://storage.googleapis.com/%s/%s", bucketName, objectName)

// 	c.JSON(http.StatusOK, gin.H{"message": "File uploaded successfully", "fileURL": fileURL})
// }

// // uploadPDF uploads a PDF file to Cloud Storage
// func uploadPDF(client *storage.Client, bucketName, objectName string, src multipart.File) error {
// 	ctx := context.Background()
// 	bucket := client.Bucket(bucketName)
// 	object := bucket.Object(objectName)

// 	writer := object.NewWriter(ctx)
// 	defer writer.Close()

// 	if _, err := io.Copy(writer, src); err != nil {
// 		return err
// 	}

// 	return nil
// }


package itr_forms

import (
	"context"
	"fmt"
	"net/http"
	"github.com/gin-gonic/gin"
	"github.com/kurin/blazer/b2"
	"mime/multipart"
	// "os"
)

// Function to initialize Backblaze B2 client
func InitBackblazeB2() (*b2.Client, error) {
	// Use your Backblaze B2 Account ID and Application Key
	accountID := "df2164e6fdfe"
	appKey := "0057677f62db22df6391fb7668f0cd4fd8df2f495c"

	// Authorize the client
	client, err := b2.NewClient(context.Background(), accountID, appKey)
	if err != nil {
		return nil, err
	}

	return client, nil
}

func uploadPDFToB2(client *b2.Client, bucketName string, objectName string, file multipart.File) error {
	// Find the bucket
	bucket, err := client.Bucket(context.Background(), bucketName)
	if err != nil {
		return fmt.Errorf("unable to find bucket: %v", err)
	}

	// Create the file object in B2
	writer := bucket.Object(objectName).NewWriter(context.Background())
	defer writer.Close()

	// Copy file content to B2 object
	if _, err := writer.ReadFrom(file); err != nil {
		return fmt.Errorf("failed to upload file: %v", err)
	}

	return nil
}

func UploadITRDocuments(c *gin.Context) {
	// Get the file from the form-data
	file, err := c.FormFile("file")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "File is required"})
		return
	}

	// Open the uploaded file
	src, err := file.Open()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to open file"})
		return
	}
	defer src.Close()

	// Initialize Backblaze B2 client
	b2Client, err := InitBackblazeB2()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to initialize Backblaze B2 client"})
		return
	}

	// Bucket and object settings
	bucketName := "aarthik-pdfs" // Replace with your actual bucket name
	objectName := fmt.Sprintf("personal_itr_documents/%s", file.Filename)

	// Upload file to Backblaze B2
	if err := uploadPDFToB2(b2Client, bucketName, objectName, src); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Failed to upload file to B2: %v", err)})
		return
	}

	// Generate the public URL for the uploaded file
	fileURL := fmt.Sprintf("https://f000.backblazeb2.com/file/%s/%s", bucketName, objectName)

	c.JSON(http.StatusOK, gin.H{"message": "File uploaded successfully", "fileURL": fileURL})
}
