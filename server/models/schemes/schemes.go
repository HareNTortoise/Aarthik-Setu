package schemes

type Scheme struct {
	RelatedScheme      string `json:"relatedScheme"`
	Description        string `json:"description"`
	NatureOfAssistance string `json:"natureOfAssistance"`
	WhoCanApply        string `json:"whoCanApply"`
	HowToApply         string `json:"howToApply"`
}
