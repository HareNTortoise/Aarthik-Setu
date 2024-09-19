import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:aarthik_setu/pages/desktop/forms/personal_loans/components/itr_file.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ITRFormBusiness extends StatefulWidget {
  const ITRFormBusiness({super.key});

  @override
  State<ITRFormBusiness> createState() => _ITRFormBusinessState();
}

class _ITRFormBusinessState extends State<ITRFormBusiness> {
  int currentYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100.0),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    "ITR Details",
                    style: GoogleFonts.poppins(fontSize: 80),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Upload ITR upto 3 years",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 60),
                  const ItrFilePersonal() ,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
