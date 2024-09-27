package business_forms

import (
	"time"
)

// Stakeholder represents a stakeholder in the system.
type Stakeholder struct {
	ID                    int       `json:"id" gorm:"primaryKey"`
	Salutation            string    `json:"salutation"`
	RelationshipType      string    `json:"relationship_type"`
	FirstName             string    `json:"first_name"`
	MiddleName            string    `json:"middle_name,omitempty"`
	LastName              string    `json:"last_name"`
	OwnershipPercent      float64   `json:"ownership_percent"` // Assuming percentage is a float
	Gender                string    `json:"gender"`
	FatherName            string    `json:"father_name,omitempty"`
	DateOfBirth           time.Time `json:"date_of_birth"`
	MobileNumber          string    `json:"mobile_number"`
	ResidenceStatus       string    `json:"residence_status"`
	PAN                   string    `json:"pan"`
	EducationStatus       string    `json:"education_status"`
	TotalExperience       int       `json:"total_experience"` // Assuming total experience is in years
	NetWorth              float64   `json:"net_worth"`        // Assuming net worth is a float
	Address               Address   `json:"address"`
	IsGuarantor           bool      `json:"is_guarantor"`
	VisuallyImpairedLevel int       `json:"visually_impaired_level"`
}

// Address represents the address details of a stakeholder or business.
type Address struct {
	BuildingNo  string `json:"building_no"`
	StreetName  string `json:"street_name"`
	Landmark    string `json:"landmark,omitempty"`
	Pincode     string `json:"pincode"`
	Country     string `json:"country"`
	State       string `json:"state"`
	City        string `json:"city"`
	District    string `json:"district"`
	SubDistrict string `json:"sub_district,omitempty"`
	Village     string `json:"village,omitempty"`
	Phone       string `json:"phone,omitempty"`
}

// BusinessDetails represents the details of a business associated with stakeholders.
type BusinessDetail struct {
	BusinessID   int           `json:"business_id" gorm:"primaryKey"`
	Address      Address       `json:"address"`                // Business Address comes first
	Stakeholders []Stakeholder `json:"stakeholders,omitempty"` // Stakeholders come second
}

// StakeholderCollection represents a collection of stakeholders.
type StakeholderCollection struct {
	Stakeholders []Stakeholder `json:"stakeholders"`
}
