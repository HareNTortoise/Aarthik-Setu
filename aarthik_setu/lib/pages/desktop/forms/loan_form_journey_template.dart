import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../constants/app_constants.dart';

class LoanFormJourneyTemplate extends StatelessWidget {
  const LoanFormJourneyTemplate({super.key, required this.formTitle, this.formDescription, required this.formLinks});

  final String formTitle;
  final String? formDescription;
  final List<Widget> formLinks;

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      runSpacing: 100,
                      alignment: WrapAlignment.spaceAround,
                      children: formLinks
                    ),
                  ),
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
