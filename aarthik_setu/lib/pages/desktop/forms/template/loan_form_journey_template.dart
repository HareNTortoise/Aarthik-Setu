import 'package:aarthik_setu/pages/desktop/forms/template/business_loan_journey.dart';
import 'package:aarthik_setu/pages/desktop/forms/template/personal_loan_journey.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../constants/app_constants.dart';

class LoanFormJourneyTemplate extends StatelessWidget {
  const LoanFormJourneyTemplate({super.key, required this.formTitle, this.formDescription, required this.loanType});

  final String formTitle;
  final String? formDescription;
  final String? loanType;

  @override
  Widget build(BuildContext context) {
    List<String> personalLoanTypes = ['personal', 'home', 'auto'];
    List<String> businessLoanTypes = ['msme', 'term', 'mudra'];
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    formTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 80,
                    ),
                  ),
                  const SizedBox(height: 40),
                  if (personalLoanTypes.contains(loanType))
                    const SizedBox(child: PersonalLoanJourney())
                  else if (businessLoanTypes.contains(loanType))
                    const SizedBox(child: BusinessLoanJourney()),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
