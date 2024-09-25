package personal_forms

import (
	"context"
	"net/http"
	"github.com/gin-gonic/gin"
	"cloud.google.com/go/firestore"
	model "server/models/forms/personal_forms" // Update with your actual model package path
	utils "server/config/firebase"
	"time"
)

// var client *firestore.Client // Assume you have initialized Firestore client elsewhere

func init() {
	client = utils.InitFirestore() // Initialize Firestore client
}

func SubmitLoanApplicationDetails(c *gin.Context) {
    profileId := c.Param("profileId")
    applicationId := c.Param("applicationId")
    ctx := context.Background()

    // Manually extract form data
    var loanApplication model.LoanApplication
    loanApplication.LoanPurpose = c.PostForm("loanPurpose")
    loanApplication.LoanAmountRequired = c.PostForm("loanAmountRequired")
    loanApplication.Tenure = c.PostForm("tenure")
    loanApplication.RetirementAge = c.PostForm("retirementAge")
    loanApplication.EmiBySalaryAccount = c.PostForm("emiBySalaryAccount") == "true"
    loanApplication.PayOutstandingByTerminalPayments = c.PostForm("payOutstandingByTerminalPayments") == "true"
    loanApplication.PaySalaryInSalaryAccount = c.PostForm("paySalaryInSalaryAccount") == "true"
    loanApplication.IssueLetterToYourEmployerToPayOutstandingLoan = c.PostForm("issueLetterToEmployerToPayOutstanding") == "true"
    loanApplication.IssueLetterToYourEmployerToNotChangeSalaryAccount = c.PostForm("issueLetterToEmployerToNotChangeAccount") == "true"
    loanApplication.RepaymentMethod = c.PostForm("repaymentMethod")

    // Check if loan application details already exist
    query := client.Collection("personal_loan_applications").
        Where("profileId", "==", profileId).
        Where("applicationId", "==", applicationId).
        Limit(1)

    // Execute the query
    docs, err := query.Documents(ctx).GetAll()
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to query existing loan applications", "details": err.Error()})
        return
    }

    if len(docs) > 0 {
        // If a document already exists, return a conflict response
        c.JSON(http.StatusConflict, gin.H{"error": "Loan application already exists for this profile and application"})
        return
    }

    // Generate a random form ID
    formId, _ := utils.GenerateRandomString(16)

    // Create a map for the loan application details
    loanApplicationMap := map[string]interface{}{
        "loanPurpose":                          loanApplication.LoanPurpose,
        "loanAmountRequired":                   loanApplication.LoanAmountRequired,
        "tenure":                               loanApplication.Tenure,
        "retirementAge":                        loanApplication.RetirementAge,
        "emiBySalaryAccount":                   loanApplication.EmiBySalaryAccount,
        "payOutstandingByTerminalPayments":     loanApplication.PayOutstandingByTerminalPayments,
        "paySalaryInSalaryAccount":             loanApplication.PaySalaryInSalaryAccount,
        "issueLetterToEmployerToPayOutstanding":loanApplication.IssueLetterToYourEmployerToPayOutstandingLoan,
        "issueLetterToEmployerToNotChangeAccount":loanApplication.IssueLetterToYourEmployerToNotChangeSalaryAccount,
        "repaymentMethod":                      loanApplication.RepaymentMethod,
        "timestamp":                            time.Now(),
        "formId":                               formId,
        "profileId":                            profileId,
        "applicationId":                        applicationId,
    }

    // Use Firestore's Add function to create a new document with an auto-generated ID
    _, _, err = client.Collection("personal_loan_applications").Add(ctx, loanApplicationMap)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to submit loan application", "details": err.Error()})
        return
    }

    c.JSON(http.StatusCreated, gin.H{"message": "Loan application submitted successfully"})
}

func GetLoanApplicationDetails(c *gin.Context) {
    profileId := c.Param("profileId")
    applicationId := c.Param("applicationId")
    ctx := context.Background()

    // Get the loan application details using profileId and applicationId
    query := client.Collection("personal_loan_applications").
        Where("profileId", "==", profileId).
        Where("applicationId", "==", applicationId).
        Limit(1)

    docs, err := query.Documents(ctx).GetAll()
    if err != nil || len(docs) == 0 {
        c.JSON(http.StatusNotFound, gin.H{"error": "Loan application not found"})
        return
    }

    var loanApplication model.LoanApplication
    if err := docs[0].DataTo(&loanApplication); err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse loan application", "details": err.Error()})
        return
    }

    c.JSON(http.StatusOK, loanApplication)
}

func UpdateLoanApplicationDetails(c *gin.Context) {
    profileId := c.Param("profileId")
    applicationId := c.Param("applicationId")
    ctx := context.Background()

    // Manually extract form data
    var loanApplication model.LoanApplication
    loanApplication.LoanPurpose = c.PostForm("loanPurpose")
    loanApplication.LoanAmountRequired = c.PostForm("loanAmountRequired")
    loanApplication.Tenure = c.PostForm("tenure")
    loanApplication.RetirementAge = c.PostForm("retirementAge")
    loanApplication.EmiBySalaryAccount = c.PostForm("emiBySalaryAccount") == "true"
    loanApplication.PayOutstandingByTerminalPayments = c.PostForm("payOutstandingByTerminalPayments") == "true"
    loanApplication.PaySalaryInSalaryAccount = c.PostForm("paySalaryInSalaryAccount") == "true"
    loanApplication.IssueLetterToYourEmployerToPayOutstandingLoan = c.PostForm("issueLetterToEmployerToPayOutstanding") == "true"
    loanApplication.IssueLetterToYourEmployerToNotChangeSalaryAccount = c.PostForm("issueLetterToEmployerToNotChangeAccount") == "true"
    loanApplication.RepaymentMethod = c.PostForm("repaymentMethod")

    // Query to check if the application exists
    query := client.Collection("personal_loan_applications").
        Where("profileId", "==", profileId).
        Where("applicationId", "==", applicationId).
        Limit(1)

    docs, err := query.Documents(ctx).GetAll()
    if err != nil || len(docs) == 0 {
        c.JSON(http.StatusNotFound, gin.H{"error": "Loan application not found"})
        return
    }

    // Update the loan application with MergeAll
    docRef := docs[0].Ref
    _, err = docRef.Set(ctx, map[string]interface{}{
        "loanPurpose":                          loanApplication.LoanPurpose,
        "loanAmountRequired":                   loanApplication.LoanAmountRequired,
        "tenure":                               loanApplication.Tenure,
        "retirementAge":                        loanApplication.RetirementAge,
        "emiBySalaryAccount":                   loanApplication.EmiBySalaryAccount,
        "payOutstandingByTerminalPayments":     loanApplication.PayOutstandingByTerminalPayments,
        "paySalaryInSalaryAccount":             loanApplication.PaySalaryInSalaryAccount,
        "issueLetterToEmployerToPayOutstanding":loanApplication.IssueLetterToYourEmployerToPayOutstandingLoan,
        "issueLetterToEmployerToNotChangeAccount":loanApplication.IssueLetterToYourEmployerToNotChangeSalaryAccount,
        "repaymentMethod":                      loanApplication.RepaymentMethod,
        "timestamp":                            time.Now(),
        "profileId":                            profileId,
        "applicationId":                        applicationId,
    }, firestore.MergeAll)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update loan application", "details": err.Error()})
        return
    }

    c.JSON(http.StatusOK, gin.H{"message": "Loan application updated successfully"})
}

func DeleteLoanApplicationDetails(c *gin.Context) {
    profileId := c.Param("profileId")
    applicationId := c.Param("applicationId")
    ctx := context.Background()

    // Query to check if the application exists
    query := client.Collection("personal_loan_applications").
        Where("profileId", "==", profileId).
        Where("applicationId", "==", applicationId).
        Limit(1)

    docs, err := query.Documents(ctx).GetAll()
    if err != nil || len(docs) == 0 {
        c.JSON(http.StatusNotFound, gin.H{"error": "Loan application not found"})
        return
    }

    // Delete the document
    docRef := docs[0].Ref
    _, err = docRef.Delete(ctx)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete loan application", "details": err.Error()})
        return
    }

    c.JSON(http.StatusOK, gin.H{"message": "Loan application deleted successfully"})
}
