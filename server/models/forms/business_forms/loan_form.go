package business_forms

type LoanApplication struct {
	LoanPurpose        string `json:"loanPurpose" form:"loanPurpose"`
	LoanAmountRequired string `json:"loanAmountRequired" form:"loanAmountRequired"`
	Tenure             string `json:"tenure" form:"tenure"`
	RetirementAge      string `json:"retirementAge" form:"retirementAge"`
	Q1                 bool   `json:"q1" form:"q1"`
	Q2                 bool   `json:"q2" form:"q2"`
	Q3                 bool   `json:"q3" form:"q3"`
	Q4                 bool   `json:"q4" form:"q4"`
	Q5                 bool   `json:"q5" form:"q5"`
	RepaymentMethod    string `json:"repaymentMethod" form:"repaymentMethod"`
}
