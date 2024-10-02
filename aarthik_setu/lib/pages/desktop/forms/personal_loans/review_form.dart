import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/dummy_data_personal.dart';

class ReviewFormPersonal extends StatelessWidget {
  const ReviewFormPersonal({super.key});

  @override
  Widget build(BuildContext context) {
    // Fixed user ID
    const userId = "user_001";

    // Fetching the relevant Personal profile for userId: "user_001"
    final businessProfile = DummyPersonalReviewForm.dummyPersonalProfiles
        .firstWhere((profile) => profile.userId == userId);

    // Extracting the profileId from the fetched profile
    final profileId = businessProfile.id;

    // Fetching relevant ITR details for the personal profile
    final itrDetails = DummyPersonalReviewForm.dummyManualItrData
        .firstWhere((itr) => itr.profileId == profileId);

    // Fetching relevant Bank details for the personal profile
    final bankDetails = DummyPersonalReviewForm.dummyBankDetails
        .firstWhere((bank) => bank.profileId == profileId);

    final basicDetails = DummyPersonalReviewForm.dummyBasicDetailsData
        .firstWhere((basic) => basic.profileId == profileId);

    // Fetching relevant Employment details for the personal profile
    final employmentDetails = DummyPersonalReviewForm.dummyEmploymentDetailsData
        .firstWhere((employment) => employment.profileId == profileId);

    final creditInfo = DummyPersonalReviewForm.dummyCreditInfoData
        .firstWhere((credit) => credit.profileId == profileId);

    final contactDetails = DummyPersonalReviewForm.dummyContactDetailsData
        .firstWhere((contact) => contact.profileId == profileId);

    final loanForm = DummyPersonalReviewForm.dummyLoanForms
        .firstWhere((loan) => loan.profileId == profileId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Form'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Displaying the Personal Profile details
              // ITR Details
              if (itrDetails != null) ...[
                Text(
                  "ITR Details:",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text("First Name: ${itrDetails.firstName}"),
                Text("Middle Name: ${itrDetails.middleName}"),
                Text("Last Name: ${itrDetails.lastName}"),
                Text(
                    "Date of Birth: ${itrDetails.dob.day}/${itrDetails.dob.month}/${itrDetails.dob.year}"),
                Text("PAN: ${itrDetails.pan}"),
                Text("Mobile: ${itrDetails.mobile}"),
                Text("Email: ${itrDetails.email}"),
                Text("Address Line 1: ${itrDetails.addressLine1}"),
                Text("Address Line 2: ${itrDetails.addressLine2 ?? 'N/A'}"),
                // Handle nullable
                Text("Landmark: ${itrDetails.landmark ?? 'N/A'}"),
                // Handle nullable
                Text("Country: ${itrDetails.country}"),
                Text("State: ${itrDetails.state}"),
                Text("City: ${itrDetails.city}"),
                Text("District: ${itrDetails.district}"),
                Text("Sub-District: ${itrDetails.subDistrict}"),
                Text("PIN Code: ${itrDetails.pinCode}"),
                // Display net annual incomes with proper checks
                Text(
                    "Net Annual Income (FY ${itrDetails.netAnnualIncomeOne.key.startYear}-${itrDetails.netAnnualIncomeOne.key.endYear}): ₹${itrDetails.netAnnualIncomeOne.value}"),
                if (itrDetails.netAnnualIncomeTwo != null)
                  Text(
                      "Net Annual Income (FY ${itrDetails.netAnnualIncomeTwo!.key.startYear}-${itrDetails.netAnnualIncomeTwo!.key.endYear}): ₹${itrDetails.netAnnualIncomeTwo!.value}"),
                if (itrDetails.netAnnualIncomeThree != null)
                  Text(
                      "Net Annual Income (FY ${itrDetails.netAnnualIncomeThree!.key.startYear}-${itrDetails.netAnnualIncomeThree!.key.endYear}): ₹${itrDetails.netAnnualIncomeThree!.value}"),

                const SizedBox(height: 16.0),
              ] else ...[
                const Text('No ITR details found for the user'),
                const SizedBox(height: 16.0),
              ],
              // Displaying the Basic Details
              if (bankDetails != null) ...[
                Text(
                  "Bank Details:",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text("Bank Name: ${bankDetails.bankName}"),
                Text(
                    "Salary Account: ${bankDetails.salaryAccount ? 'Yes' : 'No'}"),
                Text(
                    "Account Since: ${bankDetails.accountSinceMonth.month}/${bankDetails.accountSinceYear.year}"),
                const SizedBox(height: 16.0),
              ] else ...[
                const Text("No bank details found."),
                const SizedBox(height: 16.0),
              ],
              // Displaying the Basic Details
              if (basicDetails != null) ...[
                Text(
                  "Basic Details:",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text("First Name: ${basicDetails.firstName}"),
                Text("Middle Name: ${basicDetails.middleName}"),
                Text("Last Name: ${basicDetails.lastName}"),
                Text(
                    "Date of Birth: ${basicDetails.dob.day}/${basicDetails.dob.month}/${basicDetails.dob.year}"),
                Text("PAN: ${basicDetails.pan}"),
                Text("Gender: ${basicDetails.gender}"),
                Text("Category: ${basicDetails.category}"),
                Text("Mobile: ${basicDetails.mobile}"),
                Text("Telephone: ${basicDetails.telephone}"),
                Text("Personal Email: ${basicDetails.emailPersonal}"),
                Text("Father's Name: ${basicDetails.fatherName}"),
                Text("Education Qualification: ${basicDetails.educationQualification}"),
                Text("Net Worth: ${basicDetails.netWorth}"),
                Text("Nationality: ${basicDetails.nationality}"),
                Text("Dependents: ${basicDetails.dependent}"),
                Text("Marital Status: ${basicDetails.maritalStatus}"),
                const SizedBox(height: 16.0),
              ] else ...[
                const Text("No basic details found."),
                const SizedBox(height: 16.0),
              ],
              // Displaying the Employment Details
              if (employmentDetails != null) ... [
                Text(
                  "Employment Details:",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text("Employment Type: ${employmentDetails.employmentType}"),
                Text("Employer Status: ${employmentDetails.employerStatus}"),
                Text("Designation: ${employmentDetails.designation}"),
                Text("Mode of Salary: ${employmentDetails.modeOfSalary}"),
                Text("Gross Monthly Income: ${employmentDetails.grossMonthlyIncome}"),
                Text("Net Monthly Income: ${employmentDetails.netMonthlyIncome}"),
                const SizedBox(height: 16.0),
              ] else ...[
                const Text("No employment details found."),
                const SizedBox(height: 16.0),
              ],
              // Displaying the Credit Information
              if (creditInfo != null) ...[
                Text(
                  "Credit Information:",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text("Profile ID: ${creditInfo.profileId}"),
                Text("Timestamp: ${creditInfo.timestamp}"),
                Text("Application ID: ${creditInfo.applicationId}"),
                const SizedBox(height: 10.0),
                Text("Credit Info Units:", style: GoogleFonts.poppins( fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)),
                for (var unit in creditInfo.creditInfoUnits) ...[
                  Text("  Loan Type: ${unit.loanType}"),
                  Text("  Lender: ${unit.lender}"),
                  Text("  Sanctioned Amount: ${unit.sanctionedAmount}"),
                  Text("  Outstanding Amount: ${unit.outstandingAmount}"),
                  Text("  EMI Amount: ${unit.emiAmount}"),
                  const SizedBox(height: 10.0),
                ],
                const SizedBox(height: 16.0),
              ] else ...[
                const Text("No credit information found."),
                const SizedBox(height: 16.0),
              ],
              // Displaying the Contact Details
              if (contactDetails != null) ...[
                Text(
                  "Contact Details:",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text("Address Line 1: ${contactDetails.addressLine1}"),
                Text("Address Line 2: ${contactDetails.addressLine2}"),
                Text("Landmark: ${contactDetails.landmark}"),
                Text("Country: ${contactDetails.country}"),
                Text("State: ${contactDetails.state}"),
                Text("City: ${contactDetails.city}"),
                Text("Pin Code: ${contactDetails.pinCode}"),
                Text("Village: ${contactDetails.village ?? 'N/A'}"),
                Text("District: ${contactDetails.district}"),
                Text("Sub-District: ${contactDetails.subDistrict}"),
                Text("Type of Residence: ${contactDetails.typeOfResidence}"),
                Text("Residence Since: ${contactDetails.residenceSince.toLocal().toString().split(' ')[0]}"),
                Text("Profile ID: ${contactDetails.profileId}"),
                Text("Timestamp: ${contactDetails.timestamp}"),
                Text("Application ID: ${contactDetails.applicationId}"),
                Text("Contact ID: ${contactDetails.id}"),
                const SizedBox(height: 16.0),
              ] else ...[
                const Text("No contact details found."),
                const SizedBox(height: 16.0),
              ],
              // Displaying the Loan Form
              if (loanForm != null) ...[
                Text(
                  "Loan Form:",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text("Loan Form ID: ${loanForm.id}"),
                Text("Profile ID: ${loanForm.profileId}"),
                Text("Timestamp: ${loanForm.timestamp}"),
                Text("Application ID: ${loanForm.applicationId}"),
                Text("Loan Purpose: ${loanForm.loanPurpose}"),
                Text("Loan Amount: ${loanForm.loanAmount}"),
                Text("Tenure (Years): ${loanForm.tenureYears}"),
                Text("Interest Rate: ${loanForm.interestRate}"),
                Text("Retirement Age: ${loanForm.retirementAge}"),
                Text("EMI by Salary Account: ${loanForm.emiBySalaryAccount ? 'Yes' : 'No'}"),
                Text("Pay Outstanding by Terminal Payments: ${loanForm.payOutstandingByTerminalPayments ? 'Yes' : 'No'}"),
                Text("Pay Salary in Salary Account: ${loanForm.paySalaryInSalaryAccount ? 'Yes' : 'No'}"),
                Text("Issue Letter to Your Employer to Pay Outstanding Loan: ${loanForm.issueLetterToYourEmployerToPayOutstandingLoan ? 'Yes' : 'No'}"),
                Text("Issue Letter to Your Employer to Not Change Salary Account: ${loanForm.issueLetterToYourEmployerToNotChangeSalaryAccount ? 'Yes' : 'No'}"),
                Text("Repayment Method: ${loanForm.repaymentMethod}"),

                const SizedBox(height: 16.0),
              ] else ...[
                const Text("No loan form found."),
                const SizedBox(height: 16.0),
              ],

              ElevatedButton(
                onPressed: () {
                  // Navigate to the display lenders page with the loanType
                  context.go('/display-lenders/personal');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  textStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Colors.lightGreen,
                ),
                child: const Text("Submit Review"),

              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
