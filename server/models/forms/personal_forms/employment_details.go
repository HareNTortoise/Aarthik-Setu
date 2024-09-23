package personal_forms

type EmploymentDetail struct {
	EmploymentType     string  `form:"employmentType" json:"employment_type"`
	EmployerStatus     string  `form:"employerStatus" json:"employer_status"`
	Designation        string  `form:"designation" json:"designation"`
	ModeOfSalary       string  `form:"modeOfSalary" json:"mode_of_salary"`
	GrossMonthlyIncome string  `form:"grossMonthlyIncome" json:"gross_monthly_income"`
	NetMonthlyIncome   string  `form:"netMonthlyIncome" json:"net_monthly_income"`
}
