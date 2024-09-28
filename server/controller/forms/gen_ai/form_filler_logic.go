package gen_ai

import (
	"context"
	"encoding/json"
	"fmt"
	"mime/multipart"
	"os"

	speech "cloud.google.com/go/speech/apiv1"
	"github.com/go-audio/wav"
	"github.com/tmc/langchaingo/llms/openai"
	"github.com/tmc/langchaingo/prompts"
	"google.golang.org/api/option"
	speechpb "google.golang.org/genproto/googleapis/cloud/speech/v1"
)

func FillFormFromAudio(audioFile *multipart.FileHeader, formFields map[string]interface{}) (map[string]interface{}, error) {
	// Convert audio to text using Google Speech-to-Text
	text, err := audioToText(audioFile)
	if err != nil {
		return nil, fmt.Errorf("failed to convert audio to text: %v", err)
	}

	// Use Langchain to extract information from the text and fill the form
	filledForm, err := extractInformationAndFillForm(text, formFields)
	if err != nil {
		return nil, fmt.Errorf("failed to extract information and fill form: %v", err)
	}

	return filledForm, nil
}

func audioToText(audioFile *multipart.FileHeader) (string, error) {
	// Open the audio file
	file, err := audioFile.Open()
	if err != nil {
		return "", fmt.Errorf("failed to open audio file: %v", err)
	}
	defer file.Close()

	// Decode the WAV file
	decoder := wav.NewDecoder(file)
	if !decoder.IsValidFile() {
		return "", fmt.Errorf("invalid WAV file")
	}

	// Read the samples from the WAV file
	audioData, err := decoder.FullPCMBuffer()
	if err != nil {
		return "", fmt.Errorf("failed to read WAV file: %v", err)
	}

	// Prepare the raw PCM data for transcription
	buffer := make([]byte, len(audioData.Data)*2) // Assuming 16-bit samples
	for i, sample := range audioData.Data {
		buffer[2*i] = byte(sample & 0xff)
		buffer[2*i+1] = byte((sample >> 8) & 0xff)
	}

	// Use Google Speech-to-Text API to transcribe the audio
	ctx := context.Background()
	apiKey := os.Getenv("GOOGLE_APPLICATION_CREDENTIALS") // Set up your credentials
	if apiKey == "" {
		return "", fmt.Errorf("GOOGLE_APPLICATION_CREDENTIALS environment variable is not set")
	}

	client, err := speech.NewClient(ctx, option.WithCredentialsFile(apiKey))
	if err != nil {
		return "", fmt.Errorf("failed to create Speech-to-Text client: %v", err)
	}
	defer client.Close()

	// Configure the request with the audio content and config
	req := &speechpb.RecognizeRequest{
		Config: &speechpb.RecognitionConfig{
			Encoding:        speechpb.RecognitionConfig_LINEAR16,
			SampleRateHertz: int32(audioData.Format.SampleRate),
			LanguageCode:    "en-US", // Adjust based on the expected language
		},
		Audio: &speechpb.RecognitionAudio{
			AudioSource: &speechpb.RecognitionAudio_Content{
				Content: buffer, // PCM data
			},
		},
	}

	// Send the request to Google Speech-to-Text API
	resp, err := client.Recognize(ctx, req)
	if err != nil {
		return "", fmt.Errorf("failed to recognize speech: %v", err)
	}

	// Extract the transcribed text
	if len(resp.Results) == 0 || len(resp.Results[0].Alternatives) == 0 {
		return "", fmt.Errorf("no transcription results found")
	}
	transcript := resp.Results[0].Alternatives[0].Transcript

	return transcript, nil
}

func extractInformationAndFillForm(text string, formFields map[string]interface{}) (map[string]interface{}, error) {
	// Initialize Langchain with OpenAI
	llm, err := openai.New()
	if err != nil {
		return nil, fmt.Errorf("failed to initialize Langchain: %v", err)
	}

	// Create a prompt template
	template := fmt.Sprintf(`
Extract the following information from the given text and fill the form:

Text: %s

Form fields:
%s

Please provide the extracted information in JSON format.
`, text, formFieldsToString(formFields))

	prompt := prompts.NewPromptTemplate(template, []string{})

	// Generate a response using Langchain
	formattedPrompt, err := prompt.Format(map[string]interface{}{})
	if err != nil {
		return nil, fmt.Errorf("failed to format prompt: %v", err)
	}

	result, err := llm.Call(context.Background(), formattedPrompt)
	if err != nil {
		return nil, fmt.Errorf("failed to generate response: %v", err)
	}

	// Parse the JSON response
	var filledForm map[string]interface{}
	if err := json.Unmarshal([]byte(result), &filledForm); err != nil {
		return nil, fmt.Errorf("failed to parse response JSON: %v", err)
	}

	return filledForm, nil
}

func formFieldsToString(formFields map[string]interface{}) string {
	result := ""
	for key, value := range formFields {
		result += fmt.Sprintf("%s: %v\n", key, value)
	}
	return result
}
