import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        .where((stakeholder) => stakeholder.profileId == profileId)
        .toList();

    final loanForm = DummyBusinessReviewForm.dummyLoanForms
        .firstWhere((loan) => loan.profileId == profileId);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Business Review Form"),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (businessProfile != null) ...[
                Text(
                  "Business Profile:",
                  style: GoogleFonts.poppins(
                      fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text("Name: ${businessProfile.name}"),
                Text("PAN: ${businessProfile.pan}"),
                const SizedBox(height: 16.0),
              ] else ...[
                const Text("No business profile found."),
                const SizedBox(height: 16.0),
              ],
              if (gstDetails != null) ...[
                Text(
                  "GST Details:",
                  style: GoogleFonts.poppins(
                      fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text("GST Number: ${gstDetails.gstNumber}"),
                Text("GST Username: ${gstDetails.gstUsername}"),
                Text("City: ${gstDetails.city}"),
                Text("Total Purchase: ₹${gstDetails.totalPurchase}"),
                Text("Total Sales: ₹${gstDetails.totalSales}"),
                Text("GST Since: ${gstDetails.gstSince}"),
                const SizedBox(height: 16.0),
              ] else ...[
                const Text("No GST details found."),
                const SizedBox(height: 16.0),
              ],
              if (bankDetails != null) ...[
                Text(
                  "Bank Details:",
                  style: GoogleFonts.poppins(
                      fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text("Bank Name: ${bankDetails.bankName}"),
                Text("Salary Account: ${bankDetails.salaryAccount ? 'Yes' : 'No'}"),
                Text("Account Since: ${bankDetails.accountSinceMonth.month}/${bankDetails.accountSinceYear.year}"),
                const SizedBox(height: 16.0),
              ] else ...[
                const Text("No bank details found."),
                const SizedBox(height: 16.0),
              ],
              if (stakeholders.isNotEmpty) ...[
                Text(
                  "Stakeholders:",
                  style: GoogleFonts.poppins(
                      fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                for (final stakeholder in stakeholders)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Business Details", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)),
                      Text("Address Line 1: ${stakeholder.businessDetails.addressLineOne}"),
                      Text("Address Line 2: ${stakeholder.businessDetails.addressLineTwo}"),
                      Text("Landmark: ${stakeholder.businessDetails.landmark}"),
                      Text("Pincode: ${stakeholder.businessDetails.pinCode}"),
                      Text("Country: ${stakeholder.businessDetails.country}"),
                      Text("State: ${stakeholder.businessDetails.state}"),
                      Text("City: ${stakeholder.businessDetails.city}"),
                      Text("District: ${stakeholder.businessDetails.district}"),
                      Text("Sub-district: ${stakeholder.businessDetails.subDistrict}"),
                      Text("Village: ${stakeholder.businessDetails.village}"),
                      Text("Month: ${stakeholder.businessDetails.month}"),
                      Text("Year: ${stakeholder.businessDetails.year}"),
                      const SizedBox(height: 16.0),
          
                      const Text("Stakeholders Details", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)),
                      for (final partner in stakeholder.partners)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Relation Type: ${partner.relationType}"),
                            Text("Ownership Percentage: ${partner.ownershipPercentage}"),
                            Text("Salutation: ${partner.salutation}"),
                            Text("First Name: ${partner.firstName}"),
                            Text("Middle Name: ${partner.middleName}"),
                            Text("Last Name: ${partner.lastName}"),
                            Text("Father's Name: ${partner.fatherName}"),
                            Text("Gender: ${partner.gender}"),
                            Text("Date of Birth: ${partner.dob.day}/${partner.dob.month}/${partner.dob.year}"),
                            Text("Mobile Number: ${partner.mobile}"),
                            Text("Residential Status: ${partner.residentialStatus}"),
                            Text("PAN: ${partner.pan}"),
                            Text("Education Status: ${partner.educationStatus}"),
                            Text("Total Experience (Years): ${partner.totalExperienceInYears}"),
                            Text("Net Worth: ₹${partner.netWorth.toStringAsFixed(2)}"), // Formatting for currency
                            Text("Address Line 1: ${partner.addressLine1}"),
                            Text("Address Line 2: ${partner.addressLine2}"),
                            Text("Landmark: ${partner.landmark}"),
                            Text("Pin Code: ${partner.pinCode}"),
                            Text("Village: ${partner.village}"),
                            Text("District: ${partner.district}"),
                            Text("Sub-District: ${partner.subDistrict}"),
                            Text("Country: ${partner.country}"),
                            Text("State: ${partner.state}"),
                            Text("City: ${partner.city}"),
                            Text("Visually Impaired: ${partner.visuallyImpaired}"),
                            Text("Is a Guarantor: ${partner.isAGuarantor ? "Yes" : "No"}"),
                            const SizedBox(height: 16.0),
                          ],
                        ),
                      const SizedBox(height: 16.0,),
                      const Text("Main Partner Details", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)),
                      Text("Main Partner Name: ${stakeholder.mainPartner.name}"),
                      Text("Ownig House: ${stakeholder.mainPartner.owningAHouse}"),
                      Text("Assessed For Income Tax: ${stakeholder.mainPartner.assessedForIncomeTax}"),
                      Text("Martial Status: ${stakeholder.mainPartner.maritalStatus}"),
                      Text("Spouse Name: ${stakeholder.mainPartner.spouseName}"),
                      Text("No. of Children: ${stakeholder.mainPartner.noOfChildren}"),
                    ],
                  ),
              ] else ...[
                const Text("No stakeholders found."),
                const SizedBox(height: 16.0),
              ],
              const SizedBox(height: 16.0),
              Text(
                "Loan Form:",
                style: GoogleFonts.poppins(
                    fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const Text("Business Details"),
              Text("Industry: ${loanForm.industry}"),
              Text("Sector Name: ${loanForm.sectorName}"),
              Text("Sub-Sector Name: ${loanForm.subSectorName}"),
              Text("MSME Registration Number: ${loanForm.msmeRegistrationNumber}"),
              Text("Udyog Aadhar Number: ${loanForm.udyogAadharNumber}"),
              Text("Product Description: ${loanForm.productDescription}"),
              const SizedBox(height: 16.0),
              const Text("Declared Collaterals:", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)),
              ...loanForm.collaterals.map((collateral) =>
                  Text("${collateral.collateralType}: ₹${collateral.collateralAmount.toStringAsFixed(2)}")),
              const SizedBox(height: 16.0),
              const Text("Loan Details:", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("Loan Amount Required: ₹${loanForm.loanAmountRequired.toStringAsFixed(2)}"),
              Text("Promoter Contribution: ₹${loanForm.promoterContribution.toStringAsFixed(2)}"),
              Text("Purpose of Loan: ${loanForm.purposeOfLoan}"),
              Text("Project Sales: ₹${loanForm.projectSales.toStringAsFixed(2)}"),
              Text("Business ISO Certified: ${loanForm.businessISOCertified ? "Yes" : "No"}"),
              Text("Factory Premise: ${loanForm.factoryPremise}"),
              Text("Know How: ${loanForm.knowHow}"),
              Text("Competition: ${loanForm.competition}"),
              Text("Existing Loan Amount: ₹${loanForm.existingLoanAmount.toStringAsFixed(2)}"),
              Text("Additional Loan Required: ₹${loanForm.additionalLoanRequired.toStringAsFixed(2)}"),
              Text("Total Loan Amount: ₹${loanForm.totalLoanAmount.toStringAsFixed(2)}"),
              const SizedBox(height: 20),
              const Text("Existing Loans:", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)),
              ...loanForm.existingLoans.map((existingLoan) =>
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Lender: ${existingLoan.nameOfLender}"),
                      Text("Sanctioned Amount: ₹${existingLoan.sanctionedAmount.toStringAsFixed(2)}"),
                      Text("Outstanding Amount: ₹${existingLoan.outstandingAmount.toStringAsFixed(2)}"),
                      Text("EMI Amount: ₹${existingLoan.emiAmount.toStringAsFixed(2)}"),
                      Text("Loan Type: ${existingLoan.loanType}"),
                      Text("Collateral Amount: ₹${existingLoan.collateralAmount.toStringAsFixed(2)}"),
                      Text("Status: ${existingLoan.status}"),
                      const SizedBox(height: 10),
                    ],
                  )
              ),

              ElevatedButton(
                onPressed: () {
                  // Handle form submission or other actions
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
