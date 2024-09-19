package business

type ITRForm struct {
	UserID   string `firestore:"user_id"`
	PDF1Name string `firestore:"pdf1_name"`
	PDF1URL  string `firestore:"pdf1_url"`
	PDF2Name string `firestore:"pdf2_name,omitempty"`
	PDF2URL  string `firestore:"pdf2_url,omitempty"`
	PDF3Name string `firestore:"pdf3_name,omitempty"`
	PDF3URL  string `firestore:"pdf3_url,omitempty"`
}
