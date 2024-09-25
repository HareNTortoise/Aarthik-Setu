package business_forms

import "time"

type Business struct {
	ID        int       `json:"id"`
	Name      string    `json:"name"`
	Address   string    `json:"address"`
	CreatedAt time.Time `json:"created_at"`
}

type GSTDetails struct {
	ID           int       `json:"id"`
	BusinessID   string    `json:"business_id"` // Foreign key referencing Business
	GSTNumber    []string  `json:"gst_number"`
	UserName     []string  `json:"user_name"`
	FilingStatus string    `json:"filing_status"`
	CreatedAt    time.Time `json:"created_at"`
}
