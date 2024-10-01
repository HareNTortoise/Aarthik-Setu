package business_forms
import "time"
type LoanApplication struct {
	LoanPurpose         string `json:"loanPurpose" form:"loanPurpose"`
	LoanAmountRequired   string `json:"loanAmountRequired" form:"loanAmountRequired"`
	Tenure               string `json:"tenure" form:"tenure"`
	RetirementAge        string `json:"retirementAge" form:"retirementAge"`
	EmiBySalaryAccount bool   `json:"_emiBySalaryAccount" form:"_emiBySalaryAccount"`
	PayOutstandingByTerminalPayments bool   `json:"payOutstandingByTerminalPayments" form:"_payOutstandingByTerminalPayments"`
	PaySalaryInSalaryAccount bool   `json:"_paySalaryInSalaryAccount" form:"paySalaryInSalaryAccount"`
	IssueLetterToYourEmployerToPayOutstandingLoan bool   `json:" issueLetterToYourEmployerToPayOutstandingLoan " form:"issueLetterToYourEmployerToNotChangeSalaryAccount"`
	IssueLetterToYourEmployerToNotChangeSalaryAccount bool   `json:"issueLetterToYourEmployerToNotChangeSalaryAccount" form:"issueLetterToYourEmployerToNotChangeSalaryAccount"`
	RepaymentMethod      string `json:"repaymentMethod" form:"repaymentMethod"`
	Timestamp 		  time.Time`json:"timestamp" form:"timestamp"`
	FormId 			  string `json:"formId" form:"formId"`
	ProfileId 		  string `json:"profileId" form:"profileId"`
	ApplicationId 	  string `json:"applicationId" form:"applicationId"`
}
