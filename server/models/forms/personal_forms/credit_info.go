package personal_forms

type LoanDetails struct {
	LoanType           string  `form:"loanType" json:"loan_type"`
	Lender             string  `form:"lender" json:"lender"`
	SanctionedAmount   string  `form:"sanctionedAmount" json:"sanctioned_amount"`
	OutstandingAmount  string  `form:"outstandingAmount" json:"outstanding_amount"`
	EmiAmount          string  `form:"emiAmount" json:"emi_amount"`
}

type UserCreditInfo struct {
	UserID  string        `json:"user_id"`
	Loans   []LoanDetails `json:"loans"`
}