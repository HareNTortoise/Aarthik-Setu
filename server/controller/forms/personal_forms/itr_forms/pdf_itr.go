package itr_forms

import (
	"context"
	"fmt"
	"io"
	"log"
	"net/http"
	utils "server/config/firebase"
	"strings"
    "os"
	"cloud.google.com/go/storage"
	"github.com/gin-gonic/gin"
	// "cloud.google.com/go/firestore"
)
// var client *firestore.Client
// func init() {
// 	client = utils.InitFirestore() // Initialize Firestore client
// }

func UploadITRDocuments(c *gin.Context) {
    profileId := c.Param("profileId")
    applicationId := c.Param("applicationId")
    form, err := c.MultipartForm()
    if err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Failed to parse form data: " + err.Error()})
        return
    }
    log.Println("Form data parsed successfully")

    files := form.File["itr_documents"]

    if len(files) == 0 {
        c.JSON(http.StatusBadRequest, gin.H{"error": "At least one file is required"})
        return
    }

    if len(files) > 3 {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Maximum 3 files can be uploaded"})
        return
    }

    storageClient := utils.InitStorage()
    if storageClient == nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to initialize storage client"})
        return
    }

    bucketName := os.Getenv("BUCKET_NAME")
    var uploadedFiles []string

    for _, file := range files {
        file.Filename = profileId + "_" + applicationId + "_" + file.Filename

        // Check if the file is a PDF
        if !strings.HasSuffix(strings.ToLower(file.Filename), ".pdf") {
            c.JSON(http.StatusBadRequest, gin.H{"error": fmt.Sprintf("File %s is not a PDF", file.Filename)})
            log.Printf("Error: File %s is not a PDF\n", file.Filename)
            return
        }

        // Open the file
        src, err := file.Open()
        if err != nil {
            c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Unable to open file %s", file.Filename)})
            log.Printf("Error opening file %s: %v\n", file.Filename, err)
            return
        }
        defer src.Close()

        objectName := fmt.Sprintf("personal_itr_documents/%s", file.Filename)
        if err := uploadPDF(storageClient, bucketName, objectName, src); err != nil {
            c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Failed to upload file %s: %v", file.Filename, err)})
            return
        }
        log.Printf("File %s uploaded successfully\n", file.Filename)

        // Construct the file URL
        fileURL := fmt.Sprintf("https://storage.googleapis.com/%s/%s", bucketName, objectName)
        uploadedFiles = append(uploadedFiles, fileURL)
        log.Printf("File %s is accessible at: %s\n", file.Filename, fileURL)
    }

    c.JSON(http.StatusOK, gin.H{
        "message": fmt.Sprintf("%d file(s) uploaded successfully", len(uploadedFiles)),
        "files":   uploadedFiles,
    })

    // Use Add to create a document with an auto-generated ID
    doc := client.Collection("itr_documents")
    _,_, err = doc.Add(c, map[string]interface{}{
        "profileId":    profileId,
        "applicationId": applicationId,
        "files":        uploadedFiles,
        "userType":     "personal",
    })
    if err != nil {
        log.Printf("Error writing file info to Firestore: %v\n", err)
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to write file info to Firestore"})
        return
    }
}


func uploadPDF(client *storage.Client, bucketName, objectName string, src io.Reader) error {
	ctx := context.Background()
	bucket := client.Bucket(bucketName)
	object := bucket.Object(objectName)

	writer := object.NewWriter(ctx)
	defer writer.Close()


	if _, err := io.Copy(writer, src); err != nil {
		log.Printf("Error copying data to Cloud Storage for object %s: %v\n", objectName, err)
		return err
	}
	return nil
}

