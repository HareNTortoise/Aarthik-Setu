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

// BusinessDetails represents the business details including sales data.
type BusinessDetails struct {
	BusinessID        string             `json:"business_id"`
	Constitution      string             `json:"constitution"`
	State             string             `json:"state"`
	City              string             `json:"city"`
	NumberOfCustomers int                `json:"number_of_customers"` // Change to int
	PAN               string             `json:"pan"`
	HighestSale       float64            `json:"highest_sale"` // Change to float64
	Sales             map[string]float64 `json:"sales"`
	CreatedAt         time.Time          `json:"created_at"`
	UpdatedAt         time.Time          `json:"updated_at"`
}
