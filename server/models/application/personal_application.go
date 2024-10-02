package business_application

import "time"

type PersonalLoanApplication struct {
	ID                      string    `json:"id"`
	ProfileID               string    `json:"profileId"`
	LoanType                string    `json:"loanType"`
	ITRFileFormID           string    `json:"itrFileFormId"`
	ITRManualFormID         string    `json:"itrManualFormId"`
	ContactDetailsFormID    string    `json:"contactDetailsFormId"`
	BasicDetailsFormID      string    `json:"basicDetailsFormId"`
	EmploymentDetailsFormID string    `json:"employmentDetailsFormId"`
	CreditInfoFormID        string    `json:"creditInfoFormId"`
	BankDetailsFormID       string    `json:"bankDetailsFormId"`
	FinalLoanFormID         string    `json:"finalLoanFormId"`
	CreatedAt               time.Time `json:"createdAt"`
	UpdatedAt               time.Time `json:"updatedAt"`
}
