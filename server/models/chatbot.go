package model

import (
	"context"
	"encoding/json"
	"errors"
	"log"
	"os"

	"github.com/google/generative-ai-go/genai"
	"github.com/joho/godotenv"
	"google.golang.org/api/option"
)

var (
	client *genai.Client
	model  *genai.GenerativeModel
)

const preprompt = `
You are an AI assistant for AarthikSetu, a financial literacy platform. Your role is to provide helpful information about personal finance, budgeting, investing, and other financial topics. Always be polite, informative, and encourage responsible financial practices. If you're unsure about any information, say so and suggest seeking advice from a qualified financial professional.

Key points to remember:
1. Focus on financial education and literacy
2. Provide general advice, not personalized financial recommendations
3. Encourage responsible financial habits
4. Be clear about the limitations of AI-generated advice

Please respond to the user's query below:
`

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
	fullPrompt := preprompt + "\n\nUser: " + userInput
	log.Printf("DEBUG: Full prompt constructed: %s", fullPrompt)

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
	log.Printf("DEBUG: Generated response text: %s", responseText)

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
