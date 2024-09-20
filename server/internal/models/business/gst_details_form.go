package business

type GSTDetails struct {
	UserID string            `firestore:"user_id"`
	Details map[string]string `firestore:"gst_details"`
}