package models

// CreditScoreRequest represents the request payload for calculating credit score.
type CreditScoreRequest struct {
	ProfileID     string `json:"profileId" binding:"required"`
	ApplicationID string `json:"applicationId" binding:"required"`
}

// CreditScoreResponse represents the response payload containing the credit score and recommendations.
type CreditScoreResponse struct {
	CreditScore     float64 `json:"creditScore"`
	Recommendations string  `json:"recommendations"`
	Error           string  `json:"error,omitempty"`
}
