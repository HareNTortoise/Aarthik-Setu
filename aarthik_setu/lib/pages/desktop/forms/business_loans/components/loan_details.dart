import 'package:aarthik_setu/global_components/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../global_components/labelled_text_field.dart';

class LoanDetailsForm extends StatefulWidget {
  const LoanDetailsForm({super.key});

  @override
  State<LoanDetailsForm> createState() => _LoanDetailsFormState();
}

class _LoanDetailsFormState extends State<LoanDetailsForm> {
  int currentYear = DateTime.now().year;

  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _promoterContributionController = TextEditingController();
  final TextEditingController _purposeOfLoanController = TextEditingController();

  final TextEditingController _projectedSalesController = TextEditingController();
  bool _isISOCertified = false;
  final TextEditingController _factoryPremiseController = TextEditingController();

  final TextEditingController _projectedKnowHowController = TextEditingController();
  final TextEditingController _competitionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
            const Text(
              "Loan details",
              style: TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelledTextField(
                  label: "Loan Amount Required*",
                  hintText: 'Enter Loan Amount',
                  controller: _loanAmountController,
                ),
                LabelledTextField(
                  label: "Promoter Contribution*",
                  hintText: 'Enter promoter contribution',
                  controller: _promoterContributionController,
                ),
                LabelledTextField(
                  label: "Purpose of Loan*",
                  hintText: 'Enter purpose of loan',
                  controller: _purposeOfLoanController,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelledTextField(
                  label: "Projected Sales FY $currentYear-${currentYear % 100 + 1}*",
                  hintText: 'Enter projected sales',
                  controller: _projectedSalesController,
                ),
                Text('Is your business ISO certified?', style: GoogleFonts.poppins(fontSize: 20)),
                CustomSwitch(
                  current: _isISOCertified,
                  onChanged: (value) => setState(() => _isISOCertified = value),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelledTextField(
                  label: "Factory Premise*",
                  hintText: 'Enter factory premise',
                  controller: _factoryPremiseController,
                ),
                LabelledTextField(
                  label: "Projected Know How*",
                  hintText: 'Enter projected know how',
                  controller: _projectedKnowHowController,
                ),
                LabelledTextField(
                  label: "Competition*",
                  hintText: 'Enter competition',
                  controller: _competitionController,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
