package personal_forms
import(
	"time"
)

type UserDetail struct {
	Salutation            string  `form:"salutation" json:"salutation"`
	FirstName            string  `form:"firstName" json:"first_name"`
	MiddleName           *string `form:"middleName" json:"middle_name,omitempty"`
	LastName             string  `form:"lastName" json:"last_name"`
	Dob                  time.Time   `form:"dob" json:"dob"`
	Pan                  string  `form:"pan" json:"pan"`
	Gender               string  `form:"gender" json:"gender"`
	Category             string  `form:"category" json:"category"`
	Mobile               string  `form:"mobile" json:"mobile"`
	Telephone            string  `form:"telephone" json:"telephone"`
	EmailPersonal        string  `form:"emailPersonal" json:"email_personal"`
	FatherName           string  `form:"fatherName" json:"father_name"`
	EducationQualification string  `form:"educationQualification" json:"education_qualification"`
	NetWorth             float64 `form:"netWorth" json:"net_worth"`
	Nationality          string  `form:"nationality" json:"nationality"`
	Dependent            string  `form:"dependent" json:"dependent"`
	MaritalStatus        string  `form:"maritalStatus" json:"marital_status"`
}
