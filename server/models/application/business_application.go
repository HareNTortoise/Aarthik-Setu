package business_application

type BusinessLoanApplication struct {
	Id                string `json:"id"`
	ProfileId         string `json:"profileId"`
	LoanType          string `json:"loanType"`
	ItrFileFormId     string `json:"itrFileFormId"`
	GstFileFormId     string `json:"gstFileFormId"`
	GstManualFormId   string `json:"gstManualFormId"`
	BankDetailsFormId string `json:"bankDetailsFormId"`
	StakeHolderFormId string `json:"stakeHolderFormId"`
	FinalLoanFormId   string `json:"finalLoanFormId"`
	CreatedAt         string `json:"createdAt"`
	UpdatedAt         string `json:"updatedAt"`
}
