package chatbot

import (
	"encoding/json"
	"net/http"
	"github.com/gin-gonic/gin"
	"context"
	"errors"
	"log"
	"os"
	prompts "server/prompts"
	"github.com/google/generative-ai-go/genai"
	"github.com/joho/godotenv"
	"google.golang.org/api/option"
)
var (
	client *genai.Client
	model  *genai.GenerativeModel
)



// InitializeModel initializes the AI model with the API key from environment variables
func InitializeModel() error {
	// Load environment variables from .env file
	err := godotenv.Load()
	if err != nil {
		log.Println("DEBUG: Error loading .env file")
		return errors.New("error loading .env file")
	}

	// Fetch API key from environment variable
	apiKey := os.Getenv("GEMINI_API_KEY")
	if apiKey == "" {
		log.Println("DEBUG: GEMINI_API_KEY is not set")
		return errors.New("GEMINI_API_KEY environment variable is not set")
	}
	log.Println("DEBUG: GEMINI_API_KEY successfully retrieved")

	// Initialize the AI client
	client, err = genai.NewClient(context.Background(), option.WithAPIKey(apiKey))
	if err != nil {
		log.Printf("DEBUG: Error creating genai client: %s", err.Error())
		return errors.New("failed to create genai client: " + err.Error())
	}
	log.Println("DEBUG: Genai client initialized")

	// Set up the generative model
	model = client.GenerativeModel("gemini-pro")
	if model == nil {
		log.Println("DEBUG: Generative model initialization failed: model is nil")
		return errors.New("failed to initialize generative model: model is nil")
	}
	log.Println("DEBUG: Generative model initialized successfully")

	return nil
}

// ChatbotResponse generates a chatbot response for the user's input and returns it as a JSON string
func ChatbotResponse(userInput string) (string, error) {
	if model == nil {
		log.Println("DEBUG: Model not initialized")
		return "", errors.New("model not initialized")
	}

	// Construct the full prompt
	prePrompt := prompts.GenerateChatbotPrompt()
	fullPrompt := prePrompt + "\n\nUser: " + userInput

	// Generate content
	resp, err := model.GenerateContent(context.Background(), genai.Text(fullPrompt))
	if err != nil {
		log.Printf("DEBUG: Failed to generate content: %s", err.Error())
		return "", errors.New("failed to generate content: " + err.Error())
	}
	log.Println("DEBUG: Content generation successful")

	if len(resp.Candidates) == 0 {
		log.Println("DEBUG: No response candidates generated")
		return "", errors.New("no response generated")
	}

	candidate := resp.Candidates[0]
	if candidate.Content == nil {
		log.Println("DEBUG: Response content is nil")
		return "", errors.New("response content is nil")
	}
	log.Println("DEBUG: Response content received")

	// Collect the response text from the model's output
	var responseText string
	for _, part := range candidate.Content.Parts {
		if textPart, ok := part.(genai.Text); ok {
			responseText += string(textPart)
		}
	}

	if responseText == "" {
		log.Println("DEBUG: No text content in response")
		return "", errors.New("no text content in response")
	}

	// Prepare response as JSON
	responseJSON, err := json.Marshal(map[string]string{
		"response": responseText,
	})
	if err != nil {
		log.Printf("DEBUG: Failed to marshal response to JSON: %s", err.Error())
		return "", errors.New("failed to marshal response to JSON: " + err.Error())
	}

	log.Println("DEBUG: Response JSON marshaled successfully")
	return string(responseJSON), nil
}

// Ensure the model is initialized during the application startup
func init() {
	err := InitializeModel()
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

	// Call the ChatbotResponse function from the model
	response, err := ChatbotResponse(message)
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
