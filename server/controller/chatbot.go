package controller

import (
	"encoding/json"
	"net/http"
	model "server/models" // Adjust this path to match your project structure

	"github.com/gin-gonic/gin"
)

// Ensure the model is initialized during the application startup
func init() {
	err := model.InitializeModel()
	if err != nil {
		// Log and exit the application if model initialization fails
		panic("Failed to initialize AI model: " + err.Error())
	}
}

// HandleChat processes incoming chat requests
func HandleChat(c *gin.Context) {
	// Get the message from form-data
	message := c.PostForm("message")
	if message == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Message is required"})
		return
	}

	message += " Write without markdown."

	// Call the ChatbotResponse function from the model
	response, err := model.ChatbotResponse(message)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to generate response: " + err.Error()})
		return
	}

	// Parse the response if it's a JSON string
	var parsedResponse map[string]interface{}
	if err := json.Unmarshal([]byte(response), &parsedResponse); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse response: " + err.Error()})
		return
	}

	// Return the generated response as JSON
	c.JSON(http.StatusOK, parsedResponse)
}

// HandleHome provides a simple health check endpoint
func HandleHome(c *gin.Context) {
	c.String(http.StatusOK, "AarthikSetu Chatbot is running. Send POST requests to /chat")
}
