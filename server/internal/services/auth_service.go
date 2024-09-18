package services

import (
	"context"

	"firebase.google.com/go/auth"
)

type AuthService struct {
	client *auth.Client
}

func NewAuthService(client *auth.Client) *AuthService {
	return &AuthService{client: client}
}

func (s *AuthService) VerifyIDToken(idToken string) (*auth.Token, error) {
	return s.client.VerifyIDToken(context.Background(), idToken)
}
