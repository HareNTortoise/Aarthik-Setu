import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../constants/dummy_data_personal.dart';
import '../../../../global_components/showcase_text_field.dart';

class ReviewFormPersonal extends StatelessWidget {
  const ReviewFormPersonal({super.key});

  @override
  Widget build(BuildContext context) {
    // Fixed user ID
    const userId = "user_001";

    // Fetching the relevant Personal profile for userId: "user_001"
    final personalProfile = DummyPersonalReviewForm.dummyPersonalProfiles
        .firstWhere((profile) => profile.userId == userId);

    // Extracting the profileId from the fetched profile
    final profileId = personalProfile.id;

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

    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Loan Review Form'),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Personal Loan Review Form",
                    style: GoogleFonts.poppins(fontSize: 80)),
                IntrinsicHeight(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    margin: const EdgeInsets.only(bottom: 100),
                    width: 1200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 7,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        // Displaying the Personal Profile details
                        if (personalProfile != null) ...[
                          const Text("ITR Details",
                            style: TextStyle(fontSize: 30),),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Name",
                                value: personalProfile.name,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "PAN",
                                value: personalProfile.pan,
                              ),
                            ],
                          ),
                        ] else ...const [
                          Text("No Personal profile found for the user"),
                          SizedBox(height: 20),
                        ],
                        const SizedBox(height: 20),
                        const Divider(color: Colors.grey, thickness: 0.5),
                        const SizedBox(height: 20),
                        // Displaying the ITR Details
                        if (itrDetails != null) ...[
                          const Text("ITR Details",
                            style: TextStyle(fontSize: 30),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "First Name",
                                value: itrDetails.firstName,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Middle Name",
                                value: "${itrDetails.middleName}",
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Last Name",
                                value: itrDetails.lastName,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Date of Birth (DD/MM/YYYY)",
                                value: "${itrDetails.dob.day}/${itrDetails.dob.month}/${itrDetails.dob.year}",
                              ),
                              ShowcaseTextFieldContainer(
                                label: "PAN",
                                value: itrDetails.pan,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Mobile",
                                value: itrDetails.mobile,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Email",
                                value: itrDetails.email,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Address Line 1",
                                value: itrDetails.addressLine1,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Address Line 2",
                                value: itrDetails.addressLine2 ?? 'N/A',
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Landmark",
                                value: itrDetails.landmark ?? 'N/A',
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Country",
                                value: itrDetails.country,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "State",
                                value: itrDetails.state,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "City",
                                value: itrDetails.city,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "District",
                                value: itrDetails.district,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Sub-District",
                                value: itrDetails.subDistrict,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "PIN Code",
                                value: itrDetails.pinCode,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Net Annual Income (FY ${itrDetails.netAnnualIncomeOne.key.startYear}-${itrDetails.netAnnualIncomeOne.key.endYear})",
                                value: "₹${itrDetails.netAnnualIncomeOne.value}",
                              ),
                              if (itrDetails.netAnnualIncomeTwo != null)
                                ShowcaseTextFieldContainer(
                                  label: "Net Annual Income (FY ${itrDetails.netAnnualIncomeTwo!.key.startYear}-${itrDetails.netAnnualIncomeTwo!.key.endYear})",
                                  value: "₹${itrDetails.netAnnualIncomeTwo!.value}",
                                ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (itrDetails.netAnnualIncomeThree != null)
                                ShowcaseTextFieldContainer(
                                  label: "Net Annual Income (FY ${itrDetails.netAnnualIncomeThree!.key.startYear}-${itrDetails.netAnnualIncomeThree!.key.endYear})",
                                  value: "₹${itrDetails.netAnnualIncomeThree!.value}",
                                ),
                            ],
                          ),
                        ] else ...const [
                          Text("No ITR details found for the user"),
                          SizedBox(height: 20),
                        ],
                        const SizedBox(height: 20),
                        const Divider(color: Colors.grey, thickness: 0.5),
                        const SizedBox(height: 20),
                        // Displaying the Bank Details
                        if (bankDetails != null) ...[
                          const Text("Bank Details",
                            style: TextStyle(fontSize: 30),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Bank Name",
                                value: bankDetails.bankName,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Salary Account",
                                value: bankDetails.salaryAccount ? 'Yes' : 'No',
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Account Since (MM/YYYY)",
                                value: "${bankDetails.accountSinceMonth.month}/${bankDetails.accountSinceYear.year}",
                              ),
                            ],
                          ),
                        ] else ...const [
                          Text("No bank details found."),
                          SizedBox(height: 20),
                        ],
                        const SizedBox(height: 20),
                        const Divider(color: Colors.grey, thickness: 0.5),
                        const SizedBox(height: 20),
                        // Displaying the Basic Details
                        if (basicDetails != null) ...[
                          const Text("Basic Details",
                            style: TextStyle(fontSize: 30),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Salutation",
                                value: basicDetails.salutation,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "First Name",
                                value: basicDetails.firstName,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Middle Name",
                                value: "${basicDetails.middleName}",
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Last Name",
                                value: basicDetails.lastName,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Date of Birth (DD/MM/YYYY)",
                                value: "${basicDetails.dob.day}/${basicDetails.dob.month}/${basicDetails.dob.year}",
                              ),
                              ShowcaseTextFieldContainer(
                                label: "PAN",
                                value: basicDetails.pan,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Gender",
                                value: basicDetails.gender,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Category",
                                value: basicDetails.category,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Mobile",
                                value: basicDetails.mobile,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Telephone",
                                value: basicDetails.telephone,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Personal Email",
                                value: basicDetails.emailPersonal,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Father's Name",
                                value: "${basicDetails.fatherName}",
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Education Qualification",
                                value: basicDetails.educationQualification,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Net Worth in ₹",
                                value: "${basicDetails.netWorth}",
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Nationality",
                                value: basicDetails.nationality,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Dependents",
                                value: basicDetails.dependent,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Marital Status",
                                value: basicDetails.maritalStatus,
                              ),
                            ],
                          ),
                        ] else ...const [
                          Text("No basic details found."),
                          SizedBox(height: 20),
                        ],
                        const SizedBox(height: 20),
                        const Divider(color: Colors.grey, thickness: 0.5),
                        const SizedBox(height: 20),
                        // Displaying the Employment Details
                        if (employmentDetails != null) ...[
                          const Text("Employment Details",
                            style: TextStyle(fontSize: 30),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Employment Type",
                                value: employmentDetails.employmentType,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Employer Status",
                                value: employmentDetails.employerStatus,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Designation",
                                value: employmentDetails.designation,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Mode of Salary",
                                value: employmentDetails.modeOfSalary,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Gross Monthly Income in ₹",
                                value: employmentDetails.grossMonthlyIncome,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Net Monthly Income in ₹",
                                value: employmentDetails.netMonthlyIncome,
                              ),
                            ],
                          ),
                        ] else ...const [
                          Text("No employment details found."),
                          SizedBox(height: 20),
                        ],
                        const SizedBox(height: 20),
                        const Divider(color: Colors.grey, thickness: 0.5),
                        const SizedBox(height: 20),
                        // Displaying the Credit Information
                        if (creditInfo != null) ...[
                          const Text("Credit Information",
                            style: TextStyle(fontSize: 30
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Profile ID",
                                value: creditInfo.profileId,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Timestamp",
                                value: "${creditInfo.timestamp}",
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Application ID",
                                value: creditInfo.applicationId,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text("Credit Info Units",
                            style: TextStyle(fontSize: 25),
                          ),
                          const SizedBox(height: 20),
                          for (var unit in creditInfo.creditInfoUnits) ...[
                            const Text("Credit info:",
                                style: TextStyle(fontSize: 15),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShowcaseTextFieldContainer(
                                  label: "Loan Type",
                                  value: unit.loanType,
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Lender",
                                  value: unit.lender,
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Sanctioned Amount in ₹",
                                  value: unit.sanctionedAmount,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShowcaseTextFieldContainer(
                                  label: "Outstanding Amount in ₹",
                                  value: unit.outstandingAmount,
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "EMI Amount in ₹",
                                  value: unit.emiAmount,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ] else ...const [
                          Text("No credit information found."),
                          SizedBox(height: 20),
                        ],
                        const SizedBox(height: 20),
                        const Divider(color: Colors.grey, thickness: 0.5),
                        const SizedBox(height: 20),
                        // Displaying the Contact Details
                        if (contactDetails != null) ...[
                          const Text("Contact Information",
                            style: TextStyle(fontSize: 30
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Address Line 1",
                                value: contactDetails.addressLine1,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Address Line 2",
                                value: "${contactDetails.addressLine2}",
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Landmark",
                                value: "${contactDetails.landmark}",
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Country",
                                value: contactDetails.country,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "State",
                                value: contactDetails.state,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "City",
                                value: contactDetails.city,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Pin Code",
                                value: contactDetails.pinCode,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Village",
                                value: contactDetails.village ?? 'N/A',
                              ),
                              ShowcaseTextFieldContainer(
                                label: "District",
                                value: contactDetails.district,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Sub-District",
                                value: contactDetails.subDistrict,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Type of Residence",
                                value: contactDetails.typeOfResidence,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Residence Since (MM/YYYY)",
                                value: "${contactDetails.residenceSince.month}/${contactDetails.residenceSince.year}",
                              ),
                            ],
                          ),

                        ] else ...const [
                          Text("No contact details found."),
                          SizedBox(height: 20),
                        ],
                        const SizedBox(height: 20),
                        const Divider(color: Colors.grey, thickness: 0.5),
                        const SizedBox(height: 20),
                        // Displaying the Loan Form
                        if (loanForm != null) ...[
                          const Text("Loan Form",
                            style: TextStyle(fontSize: 30
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Loan Purpose",
                                value: loanForm.loanPurpose,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Loan Amount (in ₹)",
                                value: loanForm.loanAmount,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Tenure (Years)",
                                value: "${loanForm.tenureYears}",
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Interest Rate",
                                value: loanForm.interestRate,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Retirement Age",
                                value: loanForm.retirementAge,
                              ),
                              ShowcaseTextFieldContainer(
                                label: "EMI by Salary Account",
                                value: loanForm.emiBySalaryAccount ? 'Yes' : 'No',
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Pay Outstanding by Terminal Payments",
                                value: loanForm.payOutstandingByTerminalPayments ? 'Yes' : 'No',
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Pay Salary in Salary Account",
                                value: loanForm.paySalaryInSalaryAccount ? 'Yes' : 'No',
                              ),

                              ShowcaseTextFieldContainer(
                                label: "Repayment Method",
                                value: loanForm.repaymentMethod,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ShowcaseTextFieldContainer(
                                label: "Issue Letter to Your Employer to Not Change Salary Account",
                                value: loanForm.issueLetterToYourEmployerToNotChangeSalaryAccount ? 'Yes' : 'No',
                              ),
                              ShowcaseTextFieldContainer(
                                label: "Issue Letter to Your Employer to Pay Outstanding Loan",
                                value: loanForm.issueLetterToYourEmployerToPayOutstandingLoan ? 'Yes' : 'No',
                              ),
                            ],
                          ),
                        ] else ...const [
                          Text("No loan form found."),
                          SizedBox(height: 20),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

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
      ),
    );
  }
}
