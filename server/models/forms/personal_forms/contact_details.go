package personal_forms

import "time"

type ResidenceDetail struct {
	PremisesName      string    `form:"premisesName" json:"premises_name"`
	StreetName        string    `form:"streetName" json:"street_name"`
	Landmark          string    `form:"landmark" json:"landmark"`
	Country           string    `form:"country" json:"country"`
	State             string    `form:"state" json:"state"`
	City              string    `form:"city" json:"city"`
	PinCode           string    `form:"pinCode" json:"pin_code"`
	Village           string    `form:"village" json:"village"`
	District          string    `form:"district" json:"district"`
	SubDistrict       string    `form:"subDistrict" json:"sub_district"`
	TypeOfResidence   string    `form:"typeOfResidence" json:"type_of_residence"`
	ResidenceSince    time.Time `form:"residenceSince" json:"residence_since"`
}
