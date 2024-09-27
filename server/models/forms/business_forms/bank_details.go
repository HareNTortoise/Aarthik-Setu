package business_forms

type BankDetail struct {
	BankName     string `form:"bank_name" binding:"required" json:"bank_name"`
	JoiningMonth string `form:"joining_month" binding:"required" json:"joining_month"`
	JoiningYear  string `form:"joining_year" binding:"required" json:"joining_year"`
}

type BankDetailsRequest struct {
	BankDetails []BankDetail `json:"bank_details"`
}
