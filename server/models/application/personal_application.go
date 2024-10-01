package business_application

type PersonalLoanApplication struct {
	ID                      string `json:"id"`
	ProfileID               string `json:"profileId"`
	LoanType                string `json:"loanType"`
	ITRFileFormID           string `json:"itrFileFormId"`
	ITRManualFormID         string `json:"itrManualFormId"`
	ContactDetailsFormID    string `json:"contactDetailsFormId"`
	BasicDetailsFormID      string `json:"basicDetailsFormId"`
	EmploymentDetailsFormID string `json:"employmentDetailsFormId"`
	CreditInfoFormID        string `json:"creditInfoFormId"`
	BankDetailsFormID       string `json:"bankDetailsFormId"`
	FinalLoanFormID         string `json:"finalLoanFormId"`
	CreatedAt               string `json:"createdAt"`
	UpdatedAt               string `json:"updatedAt"`
}
