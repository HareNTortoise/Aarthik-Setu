package personal

type ITRForm struct {
	UserID            string  `firestore:"user_id"`
	SubmissionDate    string  `firestore:"submission_date"`
	IncomeType        string  `firestore:"income_type"`   // "manual" or "upload"
	AnnualIncome      float64 `firestore:"annual_income"` // for manual declaration
	IncomeDeclaration string  `firestore:"income_declaration"`
	FinancialYear     string  `firestore:"financial_year"` // if uploading ITR
	ITRFilePath       string  `firestore:"itr_file_path"`  // file URL or path
	ITRStatus         string  `firestore:"itr_status"`     // status (pending/verified/rejected)
	IsManual          bool    `firestore:"is_manual"`      // true for manual declaration
	FormType          string  `firestore:"form_type"`      // 'ITR Personal Loan Form'
}
