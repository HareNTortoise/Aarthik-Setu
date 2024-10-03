package controller

import (
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

type ChatRequest struct {
	Message string `json:"message" binding:"required"`
}

// HandleChat processes incoming chat requests
func HandleChat(c *gin.Context) {
	var request ChatRequest

	// Bind the incoming JSON request to the ChatRequest struct
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Call the ChatbotResponse function from the model
	response, err := model.ChatbotResponse(request.Message)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to generate response: " + err.Error()})
		return
	}

	// Return the generated response as JSON
	c.JSON(http.StatusOK, gin.H{"response": response})
}

// HandleHome provides a simple health check endpoint
func HandleHome(c *gin.Context) {
	c.String(http.StatusOK, "AarthikSetu Chatbot is running. Send POST requests to /chat")
}
