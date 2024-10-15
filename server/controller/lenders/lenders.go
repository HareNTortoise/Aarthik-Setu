package lenders

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

// LoadLendersData reads lenders data from a JSON file and unmarshals it into a slice
func LoadLendersData() {
	// Get the current working directory
	wd, err := os.Getwd()
	if err != nil {
		fmt.Println("Error getting current directory:", err)
		return
	}
	fmt.Println("Current working directory:", wd) // Debug statement

	// Load the JSON file
	data, err := os.ReadFile("lenders.json")
	if err != nil {
		fmt.Println("Error reading JSON file:", err)
		return
	}
	fmt.Println("Lenders data loaded from file successfully") // Debug statement

	// Unmarshal the JSON data into the lenders slice
	err = json.Unmarshal(data, &lenders)
	if err != nil {
		fmt.Println("Error unmarshalling JSON:", err)
		return
	}
	fmt.Printf("Unmarshalled %d lenders\n", len(lenders)) // Debug statement
}

// GetLenders retrieves all lenders with pagination
func GetLenders(c *gin.Context) {
	// Load lenders data before responding
	fmt.Println("Loading lenders data...") // Debug statement
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
			fmt.Println("Page parameter:", page) // Debug statement
		} else {
			fmt.Println("Invalid page parameter, using default:", page) // Debug statement
		}
	}
	if limitStr != "" {
		if parsedLimit, err := strconv.Atoi(limitStr); err == nil && parsedLimit > 0 {
			limit = parsedLimit
			fmt.Println("Limit parameter:", limit) // Debug statement
		} else {
			fmt.Println("Invalid limit parameter, using default:", limit) // Debug statement
		}
	}

	// Calculate start and end indices for slicing the lenders
	start := (page - 1) * limit
	end := start + limit
	fmt.Printf("Pagination - start: %d, end: %d\n", start, end) // Debug statement

	// Check if start index is out of range
	if start >= len(lenders) {
		c.JSON(http.StatusNotFound, gin.H{"message": "No more lenders available for the requested page"})
		fmt.Println("Start index out of range, no more lenders available") // Debug statement
		return
	}

	// Adjust end index if it exceeds the length of lenders
	if end > len(lenders) {
		end = len(lenders)
		fmt.Println("Adjusted end index to:", end) // Debug statement
	}

	fmt.Printf("Returning lenders from index %d to %d\n", start, end) // Debug statement
	c.JSON(http.StatusOK, lenders[start:end])
}
