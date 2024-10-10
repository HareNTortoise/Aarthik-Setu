package lenders

type Lender struct {
	LenderName          string   `json:"lender_name"`
	LenderType          string   `json:"lender_type"`
	Position            string   `json:"position"`
	Location            string   `json:"location"`
	LoanType            string   `json:"loan_type"`
	LoanAmountRange     string   `json:"loan_amount_range"`
	InterestRate        string   `json:"interest_rate"`
	LoanTerm            string   `json:"loan_term"`
	EligibilityCriteria string   `json:"eligibility_criteria"`
	CollateralRequired  bool     `json:"collateral_required"`
	ApplicationDeadline string   `json:"application_deadline"`
	Remote              bool     `json:"remote"`
	Seniority           string   `json:"seniority"`
	ExperienceLevel     int      `json:"experience_level"`
	SkillsRequired      int      `json:"skills_required"`
	IndustryExperience  int      `json:"industry_experience"`
	FairMatchScore      int      `json:"fair_match_score"`
	H1bSponsor          bool     `json:"h1b_sponsor"`
	Benefits            []string `json:"benefits"`
	LoanDescription     string   `json:"loan_description"`
	ApplicationStatus   string   `json:"application_status"`
	ApplicantCount      int      `json:"applicant_count"`
	ImageURL            string   `json:"image_url"` // New field added
}
