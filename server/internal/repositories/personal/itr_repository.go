package repositories

import (
	"context"
	"log"

	"aarthik-setu/internal/models/personal"
	config "aarthik-setu/pkg/auth"
)

const collectionName = "itr_forms"

func CreateITRForm(ctx context.Context, form *personal.ITRForm) error {
	_, _, err := config.FirestoreClient.Collection(collectionName).Add(ctx, form)
	if err != nil {
		log.Printf("Error creating ITR form. Collection: %s, Error: %v", collectionName, err)
		return err
	}
	return nil
}

func GetITRForm(ctx context.Context, id string) (*personal.ITRForm, error) {
	doc, err := config.FirestoreClient.Collection(collectionName).Doc(id).Get(ctx)
	if err != nil {
		log.Printf("Error fetching ITR form. Collection: %s, Document ID: %s, Error: %v", collectionName, id, err)
		return nil, err
	}
	var form personal.ITRForm
	doc.DataTo(&form)
	return &form, nil
}

func UpdateITRForm(ctx context.Context, id string, form *personal.ITRForm) error {
	_, err := config.FirestoreClient.Collection(collectionName).Doc(id).Set(ctx, form)
	if err != nil {
		log.Printf("Error updating ITR form. Collection: %s, Document ID: %s, Error: %v", collectionName, id, err)
		return err
	}
	return nil
}

func DeleteITRForm(ctx context.Context, id string) error {
	_, err := config.FirestoreClient.Collection(collectionName).Doc(id).Delete(ctx)
	if err != nil {
		log.Printf("Error deleting ITR form. Collection: %s, Document ID: %s, Error: %v", collectionName, id, err)
		return err
	}
	return nil
}
