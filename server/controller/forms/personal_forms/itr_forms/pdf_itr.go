package itr_forms

import (
	"context"
	"fmt"
	"io"
	"log"
	"net/http"
	"path/filepath"
	utils "server/config/firebase"
	"strings"
	"time"

	"cloud.google.com/go/storage"
	"github.com/gin-gonic/gin"
)

func UploadITRDocuments(c *gin.Context) {
	log.Println("Starting UploadITRDocuments handler...")

	// Get the files from the form-data
	form, err := c.MultipartForm()
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Failed to parse form data"})
		log.Println("Error: Failed to parse form data:", err)
		return
	}
	log.Println("Form data parsed successfully")

	files := form.File["itr_documents"]
	log.Printf("Number of files received: %d\n", len(files))

	if len(files) == 0 {
		c.JSON(http.StatusBadRequest, gin.H{"error": "At least one file is required"})
		log.Println("Error: No files provided")
		return
	}

	if len(files) > 3 {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Maximum 3 files can be uploaded"})
		log.Printf("Error: %d files provided, but only up to 3 are allowed\n", len(files))
		return
	}

	// Initialize the Storage client
	log.Println("Initializing storage client...")
	storageClient := utils.InitStorage()
	if storageClient == nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to initialize storage client"})
		log.Println("Error: Failed to initialize Firebase storage client")
		return
	}
	log.Println("Storage client initialized successfully")

	bucketName := "aarthik-setu.appspot.com"
	var uploadedFiles []string

	for idx, file := range files {
		log.Printf("Processing file %d: %s\n", idx+1, file.Filename)

		// Check if the file is a PDF
		if !strings.HasSuffix(strings.ToLower(file.Filename), ".pdf") {
			c.JSON(http.StatusBadRequest, gin.H{"error": fmt.Sprintf("File %s is not a PDF", file.Filename)})
			log.Printf("Error: File %s is not a PDF\n", file.Filename)
			return
		}
		log.Printf("File %s is a valid PDF\n", file.Filename)

		// Open the file
		src, err := file.Open()
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Unable to open file %s", file.Filename)})
			log.Printf("Error opening file %s: %v\n", file.Filename, err)
			return
		}
		defer src.Close()
		log.Printf("Opened file %s successfully\n", file.Filename)

		// Generate a unique filename
		uniqueFilename := fmt.Sprintf("%d_%s", time.Now().UnixNano(), filepath.Base(file.Filename))
		objectName := fmt.Sprintf("personal_itr_documents/%s", uniqueFilename)
		log.Printf("Generated unique filename: %s\n", uniqueFilename)

		// Upload the file
		log.Printf("Uploading file %s to bucket %s as %s\n", file.Filename, bucketName, objectName)
		if err := uploadPDF(storageClient, bucketName, objectName, src); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Failed to upload file %s: %v", file.Filename, err)})
			log.Printf("Error uploading file %s: %v\n", file.Filename, err)
			return
		}
		log.Printf("File %s uploaded successfully\n", file.Filename)

		// Construct the file URL
		fileURL := fmt.Sprintf("https://storage.googleapis.com/%s/%s", bucketName, objectName)
		uploadedFiles = append(uploadedFiles, fileURL)
		log.Printf("File %s is accessible at: %s\n", file.Filename, fileURL)
	}

	log.Printf("Successfully uploaded %d file(s)\n", len(uploadedFiles))
	c.JSON(http.StatusOK, gin.H{
		"message": fmt.Sprintf("%d file(s) uploaded successfully", len(uploadedFiles)),
		"files":   uploadedFiles,
	})
}

func uploadPDF(client *storage.Client, bucketName, objectName string, src io.Reader) error {
	ctx := context.Background()
	bucket := client.Bucket(bucketName)
	object := bucket.Object(objectName)

	writer := object.NewWriter(ctx)
	defer writer.Close()

	log.Printf("Starting file upload to Cloud Storage: %s\n", objectName)

	if _, err := io.Copy(writer, src); err != nil {
		log.Printf("Error copying data to Cloud Storage for object %s: %v\n", objectName, err)
		return err
	}

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
