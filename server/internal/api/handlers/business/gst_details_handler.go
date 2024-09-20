package business
import (
	"net/http"
	"fmt"
	"context"
	businessService "aarthik-setu/internal/services/business"
	businessModel "aarthik-setu/internal/models/business"
	"cloud.google.com/go/firestore"
	"log"
)
var firestoreClient *firestore.Client

func GSTDetailsRegister(w http.ResponseWriter, r *http.Request) {
	// Parse the form data from the request
	if err := r.ParseMultipartForm(10 << 20); err != nil {
		http.Error(w, "Unable to parse form", http.StatusBadRequest)
		return
	}

	// Get the user ID
	userID := r.FormValue("user_id")
	if userID == "" {
		http.Error(w, "Missing user ID", http.StatusBadRequest)
		return
	}

	// Initialize a map to store GST details
	gstDetails := make(map[string]string)

	// Iterate over the GST details fields (assuming they are numbered sequentially)
	for i := 1; ; i++ {
		// Construct form field names
		gstNumberField := fmt.Sprintf("gst_number%d", i)
		gstUsernameField := fmt.Sprintf("gst_username%d", i)

		// Retrieve values
		gstNumber := r.FormValue(gstNumberField)
		gstUsername := r.FormValue(gstUsernameField)

		// If either field is missing, stop the loop
		if gstNumber == "" || gstUsername == "" {
			break
		}

		// Add the GST details to the map
		gstDetails[gstNumber] = gstUsername
	}

	// If no GST details were provided, return an error
	if len(gstDetails) == 0 {
		http.Error(w, "No GST details provided", http.StatusBadRequest)
		return
	}

	// Create the GSTDetails struct
	details := businessModel.GSTDetails{
		UserID:  userID,
		Details: gstDetails,
	}

	// Initialize the GSTService with Firestore client
	gstService := businessService.NewGSTService(firestoreClient)

	// Save GST details to Firestore using the GSTService
	ctx := context.Background() // Use a proper context in production
	err := gstService.CreateGSTDetailsForm(ctx, &details)
	if err != nil {
		http.Error(w, "Failed to store GST details", http.StatusInternalServerError)
		log.Printf("Error storing GST details: %v", err)
		return
	}

	// Return success message
	fmt.Fprintf(w, "Successfully stored GST details for User ID: %s", userID)
}