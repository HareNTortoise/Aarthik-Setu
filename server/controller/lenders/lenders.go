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

func LoadLendersData() {
	data, err := os.ReadFile("lenders.json")
	if err != nil {
		fmt.Println("Error reading JSON file:", err)
		return
	}

	// Unmarshal the JSON data into the lenders slice
	err = json.Unmarshal(data, &lenders)
	if err != nil {
		fmt.Println("Error unmarshalling JSON:", err)
		return
	}
}

// GetLenders retrieves all lenders with pagination
func GetLenders(c *gin.Context) {
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
		return
	}

	// Adjust end index if it exceeds the length of lenders
	if end > len(lenders) {
		end = len(lenders)
	}

	c.JSON(http.StatusOK, lenders[start:end])
}
