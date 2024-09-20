package itr_forms

import "time"

// ManualITR represents the structure of the ITR form data
type ManualITR struct {
	FirstName      string                     `json:"firstName" binding:"required"`
	MiddleName     *string                    `json:"middleName,omitempty"`  // Optional
	LastName       string                     `json:"lastName" binding:"required"`
	DOB            time.Time                  `json:"dob" binding:"required"` // Use `time.Time` for DateTime
	PAN            string                     `json:"pan" binding:"required"`
	Mobile         string                     `json:"mobile" binding:"required"`
	Email          string                     `json:"email" binding:"required"`
	AddressLine1   string                     `json:"addressLine1" binding:"required"`
	AddressLine2   *string                    `json:"addressLine2,omitempty"` // Optional
	Landmark       string                     `json:"landmark" binding:"required"`
	Country        string                     `json:"country" binding:"required"`
	PinCode        string                     `json:"pinCode" binding:"required"`
	State          string                     `json:"state" binding:"required"`
	City           string                     `json:"city" binding:"required"`
	Village        *string                    `json:"village,omitempty"`      // Optional
	District       *string                    `json:"district,omitempty"`     // Optional
	SubDistrict    *string                    `json:"subDistrict,omitempty"`  // Optional
	NetAnnualIncome map[IncomeRange]float64    `json:"netAnnualIncome" binding:"required"`
}

// IncomeRange represents the start and end year for income records
type IncomeRange struct {
	StartYear int `json:"startYear" binding:"required"`
	EndYear   int `json:"endYear" binding:"required"`
}
