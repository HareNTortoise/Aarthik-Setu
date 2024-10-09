package controllers

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strconv"

	lend "server/models/lenders"

	"github.com/gin-gonic/gin"
)

var lenders []lend.Lender

// LoadLendersData loads data from the JSON file
func LoadLendersData() {
	fmt.Println("Attempting to load lenders data from JSON file...") // Debug statement
	data, err := os.ReadFile("lenders.json")
	if err != nil {
		fmt.Println("Error reading JSON file:", err)
		return
	}

	// Log the raw data read from the file
	fmt.Println("Raw data read from JSON file:", string(data)) // Debug statement

	// Unmarshal the JSON data into the lenders slice
	err = json.Unmarshal(data, &lenders)
	if err != nil {
		fmt.Println("Error unmarshalling JSON:", err)
		return
	}

	// Log to ensure that data has been loaded
	fmt.Printf("Loaded %d lenders\n", len(lenders)) // Debug statement
}

// GetLenders retrieves all lenders with pagination
func GetLenders(c *gin.Context) {
	fmt.Println("Fetching all lenders...") // Debug statement
	// Load lenders data before responding
	LoadLendersData()

	// Check if lenders is populated
	if len(lenders) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"message": "No lenders data available"})
		fmt.Println("No lenders data available") // Debug statement
		return
	}

	// Get pagination parameters from query
	pageStr := c.Query("page")
	limitStr := c.Query("limit")

	// Set default values for page and limit
	page := 1
	limit := 10

	// Parse page and limit, with error handling
	if pageStr != "" {
		if parsedPage, err := strconv.Atoi(pageStr); err == nil && parsedPage > 0 {
			page = parsedPage
		}
	}
	if limitStr != "" {
		if parsedLimit, err := strconv.Atoi(limitStr); err == nil && parsedLimit > 0 {
			limit = parsedLimit
		}
	}

	// Calculate start and end indices for slicing the lenders
	start := (page - 1) * limit
	end := start + limit

	// Check if start index is out of range
	if start >= len(lenders) {
		c.JSON(http.StatusNotFound, gin.H{"message": "No more lenders available for the requested page"})
		fmt.Println("No more lenders available for the requested page") // Debug statement
		return
	}

	// Adjust end index if it exceeds the length of lenders
	if end > len(lenders) {
		end = len(lenders)
	}

	// Return the paginated slice of lenders
	c.JSON(http.StatusOK, lenders[start:end])
	fmt.Printf("Returned lenders from %d to %d (total %d)\n", start, end, len(lenders)) // Debug statement
}

// // GetLenderByPosition retrieves a lender by position
// func GetLenderByPosition(c *gin.Context) {
// 	position := c.Param("position")
// 	fmt.Printf("Searching for lender with position: %s\n", position) // Debug statement
// 	found := false

// 	// Iterate over lenders and find the one that matches the position
// 	for _, lender := range lenders {
// 		if lender.Position == position {
// 			c.JSON(http.StatusOK, lender)
// 			found = true
// 			fmt.Printf("Lender found: %+v\n", lender) // Debug statement
// 			break
// 		}
// 	}

// 	// If no lender is found for the given position
// 	if !found {
// 		c.JSON(http.StatusNotFound, gin.H{"message": "Lender not found for the specified position"})
// 		fmt.Println("Lender not found for the specified position") // Debug statement
// 	}
// }
