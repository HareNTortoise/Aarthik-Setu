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

func (s *AuthService) VerifyGoogleToken(idToken string) (*auth.Token, error) {
	return s.client.VerifyIDToken(context.Background(), idToken)
}

func (s *AuthService) GetUserByID(uid string) (*auth.UserRecord, error) {
	return s.client.GetUser(context.Background(), uid)
}

func (s *AuthService) RevokeUserTokens(uid string) error {
	return s.client.RevokeRefreshTokens(context.Background(), uid)
}
