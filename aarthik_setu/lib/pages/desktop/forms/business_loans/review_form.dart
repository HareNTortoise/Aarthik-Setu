import 'package:aarthik_setu/global_components/showcase_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/dummy_data_business.dart';

class ReviewFormBusiness extends StatelessWidget {
  const ReviewFormBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    // Fixed user ID
    const userId = "user_001";

    // Fetching the relevant business profile for userId: "user_001"
    final businessProfile = DummyBusinessReviewForm.dummyBusinessProfiles
        .firstWhere((profile) => profile.userId == userId);

    // Assuming the profileId from the fetched business profile
    final profileId = businessProfile.id;

    // Fetching GST details for the business profile
    final gstDetails = DummyBusinessReviewForm.dummyGSTDetails
        .firstWhere((gst) => gst.profileId == profileId);

    // Fetching bank details for the business profile
    final bankDetails = DummyBusinessReviewForm.dummyBankDetails
        .firstWhere((bank) => bank.profileId == profileId);

    // Fetching stakeholders for the business profile
    final stakeholders = DummyBusinessReviewForm.dummyStakeholdersData
        .firstWhere((stakeholder) => stakeholder.profileId == profileId);

    final loanForm = DummyBusinessReviewForm.dummyLoanForms
        .firstWhere((loan) => loan.profileId == profileId);

    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Business Review Form"),
        ),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Business Review Form",
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
                          // Displaying business profile
                          if (businessProfile != null) ...[
                            const Text(
                              "Business Profile:",
                              style: TextStyle(fontSize: 30),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShowcaseTextFieldContainer(
                                  label: "Name",
                                  value: businessProfile.name,
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "PAN",
                                  value: businessProfile.pan,
                                ),
                              ],
                            ),
                          ] else ...const [
                            Text("No business profile found."),
                            SizedBox(height: 20),
                          ],
                          const SizedBox(height: 20),
                          const Divider(color: Colors.grey, thickness: 0.5),
                          const SizedBox(height: 20),
                          // Displaying GST details
                          if (gstDetails != null) ...[
                            const Text(
                              "GST Details:",
                              style: TextStyle(fontSize: 30),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShowcaseTextFieldContainer(
                                  label: "GST Number",
                                  value: gstDetails.gstNumber,
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "GST Username",
                                  value: gstDetails.gstUsername,
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "City",
                                  value: gstDetails.city,
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShowcaseTextFieldContainer(
                                  label: "Total Purchase (in ₹)",
                                  value: "${gstDetails.totalPurchase}",
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Total Sales ",
                                  value: "${gstDetails.totalSales}",
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "GST Since (dd/mm/yyyy)",
                                  value:
                                      "${gstDetails.gstSince?.day}/${gstDetails.gstSince?.month}/${gstDetails.gstSince?.year}",
                                )
                              ],
                            ),
                          ] else ...const [
                            Text("No GST details found."),
                            SizedBox(height: 20),
                          ],
                          const SizedBox(height: 20),
                          const Divider(color: Colors.grey, thickness: 0.5),
                          const SizedBox(height: 20),

                          // Displaying bank details
                          if (bankDetails != null) ...[
                            const Text(
                              "Bank Details:",
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
                                  value:
                                      bankDetails.salaryAccount ? "Yes" : "No",
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Account Since",
                                  value:
                                      "${bankDetails.accountSinceMonth.month}/${bankDetails.accountSinceYear?.year}",
                                )
                              ],
                            ),
                          ] else ...const [
                            Text("No bank details found."),
                            SizedBox(height: 20),
                          ],
                          const SizedBox(height: 20),
                          const Divider(color: Colors.grey, thickness: 0.5),
                          const SizedBox(height: 20),

                          // Displaying stakeholders
                          if (stakeholders != null) ...[
                            const Text(
                              "Stakeholders:",
                              style: TextStyle(fontSize: 30),
                            ),
                            const SizedBox(height: 20),
                            const Text("Business Details",
                                style: TextStyle(fontSize: 20)),
                            const SizedBox(height: 10),
                            // for (final stakeholder in stakeholders)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ShowcaseTextFieldContainer(
                                      label: "Address Line 1",
                                      value: stakeholders
                                          .businessDetails.addressLineOne,
                                    ),
                                    ShowcaseTextFieldContainer(
                                      label: "Address Line 2",
                                      value:
                                          "${stakeholders.businessDetails.addressLineTwo}",
                                    ),
                                    ShowcaseTextFieldContainer(
                                      label: "Landmark",
                                      value:
                                          stakeholders.businessDetails.landmark,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ShowcaseTextFieldContainer(
                                      label: "Pincode",
                                      value:
                                          stakeholders.businessDetails.pinCode,
                                    ),
                                    ShowcaseTextFieldContainer(
                                      label: "Country",
                                      value:
                                          stakeholders.businessDetails.country,
                                    ),
                                    ShowcaseTextFieldContainer(
                                      label: "State",
                                      value: stakeholders.businessDetails.state,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ShowcaseTextFieldContainer(
                                      label: "City",
                                      value: stakeholders.businessDetails.city,
                                    ),
                                    ShowcaseTextFieldContainer(
                                      label: "District",
                                      value:
                                          stakeholders.businessDetails.district,
                                    ),
                                    ShowcaseTextFieldContainer(
                                      label: "Sub-district",
                                      value: stakeholders
                                          .businessDetails.subDistrict,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ShowcaseTextFieldContainer(
                                      label: "Village",
                                      value:
                                          stakeholders.businessDetails.village,
                                    ),
                                    ShowcaseTextFieldContainer(
                                      label: "Month",
                                      value:
                                          "${stakeholders.businessDetails.month}",
                                    ),
                                    ShowcaseTextFieldContainer(
                                      label: "Year",
                                      value:
                                          "${stakeholders.businessDetails.year}",
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text("Stakeholders Details",
                                style: TextStyle(fontSize: 20)),
                            const SizedBox(height: 10),
                            for (final partner in stakeholders.partners)
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ShowcaseTextFieldContainer(
                                        label: "Relation Type",
                                        value: partner.relationType,
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Ownership Percentage",
                                        value: "${partner.ownershipPercentage}",
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Salutation",
                                        value: partner.salutation,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ShowcaseTextFieldContainer(
                                        label: "First Name",
                                        value: partner.firstName,
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Middle Name",
                                        value: "${partner.middleName}",
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Last Name",
                                        value: partner.lastName,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ShowcaseTextFieldContainer(
                                        label: "Gender",
                                        value: partner.gender,
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Date of Birth (dd/mm/yyyy)",
                                        value:
                                            "${partner.dob.day}/${partner.dob.month}/${partner.dob.year}",
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Mobile Number",
                                        value: partner.mobile,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ShowcaseTextFieldContainer(
                                        label: "Residential Status",
                                        value: partner.residentialStatus,
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "PAN",
                                        value: partner.pan,
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Education Status",
                                        value: partner.educationStatus,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ShowcaseTextFieldContainer(
                                        label: "Total Experience (Years)",
                                        value:
                                            "${partner.totalExperienceInYears}",
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Net Worth (in ₹)",
                                        value: "₹${partner.netWorth}",
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Address Line 1",
                                        value: partner.addressLine1,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ShowcaseTextFieldContainer(
                                        label: "Address Line 2",
                                        value: "${partner.addressLine2}",
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Landmark",
                                        value: "${partner.landmark}",
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Pin Code",
                                        value: partner.pinCode,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ShowcaseTextFieldContainer(
                                        label: "Village",
                                        value: partner.village,
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "District",
                                        value: partner.district,
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Sub-District",
                                        value: partner.subDistrict,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ShowcaseTextFieldContainer(
                                        label: "Country",
                                        value: partner.country,
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "State",
                                        value: partner.state,
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "City",
                                        value: partner.city,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ShowcaseTextFieldContainer(
                                        label: "Visually Impaired",
                                        value: partner.visuallyImpaired,
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Is a Guarantor",
                                        value:
                                            partner.isAGuarantor ? "Yes" : "No",
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            const SizedBox(height: 10),
                            const Text("Main Partner Details",
                                style: TextStyle(fontSize: 20)),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShowcaseTextFieldContainer(
                                  label: "Main Partner Name",
                                  value: stakeholders.mainPartner.name,
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Owning House",
                                  value:
                                      "${stakeholders.mainPartner.owningAHouse}",
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Assessed For Income Tax",
                                  value:
                                      "${stakeholders.mainPartner.assessedForIncomeTax}",
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShowcaseTextFieldContainer(
                                  label: "Martial Status",
                                  value: stakeholders.mainPartner.maritalStatus,
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Spouse Name",
                                  value: stakeholders.mainPartner.spouseName,
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "No. of Children",
                                  value:
                                      "${stakeholders.mainPartner.noOfChildren}",
                                )
                              ],
                            ),
                          ] else ...const [
                            Text("No stakeholders found."),
                            SizedBox(height: 20),
                          ],
                          const SizedBox(height: 20),
                          const Divider(color: Colors.grey, thickness: 0.5),
                          const SizedBox(height: 20),

                          // Displaying loan form
                          if (loanForm != null) ...[
                            const Text(
                              "Loan Form:",
                              style: TextStyle(fontSize: 30),
                            ),
                            const SizedBox(height: 10),
                            const Text("Business Details",
                                style: TextStyle(fontSize: 20)),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShowcaseTextFieldContainer(
                                  label: "Industry",
                                  value: loanForm.industry,
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Sector Name",
                                  value: loanForm.sectorName,
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Sub-Sector Name",
                                  value: loanForm.subSectorName,
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShowcaseTextFieldContainer(
                                  label: "MSME Registration Number",
                                  value: loanForm.msmeRegistrationNumber,
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Udyog Aadhar Number",
                                  value: loanForm.udyogAadharNumber,
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Product Description",
                                  value: loanForm.productDescription,
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Declared Collaterals:",
                              style: TextStyle(fontSize: 30),
                            ),
                            const SizedBox(height: 10),
                            for (final collateral in loanForm.collaterals)
                              Column(
                                children: [
                                  const Text("-----Collateral details-----",
                                      style: TextStyle(fontSize: 20)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ShowcaseTextFieldContainer(
                                        label: "Collateral Type",
                                        value: collateral.collateralType,
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Collateral Amount",
                                        value:
                                            "₹${collateral.collateralAmount.toStringAsFixed(2)}",
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            const SizedBox(height: 20),
                            const Text(
                              "Loan Details:",
                              style: TextStyle(fontSize: 30),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShowcaseTextFieldContainer(
                                  label: "Loan Amount Required",
                                  value:
                                      "₹${loanForm.loanAmountRequired.toStringAsFixed(2)}",
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Promoter Contribution",
                                  value:
                                      "₹${loanForm.promoterContribution.toStringAsFixed(2)}",
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Purpose of Loan",
                                  value: loanForm.purposeOfLoan,
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShowcaseTextFieldContainer(
                                  label: "Project Sales",
                                  value:
                                      "₹${loanForm.projectSales.toStringAsFixed(2)}",
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Business ISO Certified",
                                  value: loanForm.businessISOCertified
                                      ? "Yes"
                                      : "No",
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Factory Premise",
                                  value: loanForm.factoryPremise,
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShowcaseTextFieldContainer(
                                  label: "Know How",
                                  value: loanForm.knowHow,
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Competition",
                                  value: loanForm.competition,
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Existing Loan Amount",
                                  value:
                                      "₹${loanForm.existingLoanAmount.toStringAsFixed(2)}",
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShowcaseTextFieldContainer(
                                  label: "Additional Loan Required",
                                  value:
                                      "₹${loanForm.additionalLoanRequired.toStringAsFixed(2)}",
                                ),
                                ShowcaseTextFieldContainer(
                                  label: "Total Loan Amount",
                                  value:
                                      "₹${loanForm.totalLoanAmount.toStringAsFixed(2)}",
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Existing Loans:",
                              style: TextStyle(fontSize: 30),
                            ),
                            const SizedBox(height: 10),
                            for (final existingLoan in loanForm.existingLoans)
                              Column(
                                children: [
                                  const Text("-----Loan details-----",
                                      style: TextStyle(fontSize: 20)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ShowcaseTextFieldContainer(
                                        label: "Lender",
                                        value: existingLoan.nameOfLender,
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Sanctioned Amount",
                                        value:
                                            "₹${existingLoan.sanctionedAmount.toStringAsFixed(2)}",
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Outstanding Amount",
                                        value:
                                            "₹${existingLoan.outstandingAmount.toStringAsFixed(2)}",
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ShowcaseTextFieldContainer(
                                        label: "EMI Amount",
                                        value:
                                            "₹${existingLoan.emiAmount.toStringAsFixed(2)}",
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Loan Type",
                                        value: existingLoan.loanType,
                                      ),
                                      ShowcaseTextFieldContainer(
                                        label: "Collateral Amount",
                                        value:
                                            "₹${existingLoan.collateralAmount.toStringAsFixed(2)}",
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ShowcaseTextFieldContainer(
                                        label: "Status",
                                        value: existingLoan.status,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                          ] else ...const [
                            Text("No loan form found."),
                            SizedBox(height: 20),
                          ],
                        ],
                      )),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the display lenders page with the loanType
                    context.go('/display-lenders/business');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 16.0),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: Colors.lightGreen,
                  ),
                  child: const Text("Submit Review"),
                ),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
