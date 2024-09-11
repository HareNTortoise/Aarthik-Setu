import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../constants/app_constants.dart';

class LoanFormJourneyTemplate extends StatelessWidget {
  const LoanFormJourneyTemplate({super.key, required this.formTitle, this.formDescription, required this.forms});

  final String formTitle;
  final String? formDescription;
  final List<Widget> forms;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
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
                height: 800,
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 120,
                  mainAxisSpacing: 120,
                  children: forms,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
