import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:aarthik_setu/constants/colors.dart';
import 'package:aarthik_setu/repository/govt_schemes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SchemeInfoPopup extends StatelessWidget {
  const SchemeInfoPopup({super.key, required this.governmentScheme});

  final GovernmentScheme governmentScheme;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Dialog(
        child: Container(
          width: 1400,
          height: 800,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 1100,
                            child: Text(
                              governmentScheme.relatedScheme,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 42,
                              ),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 150,
                            height: 40,
                            child: FilledButton.tonal(
                              onPressed: () => context.pop(),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(AppColors.primaryColorOne.withOpacity(0.4)),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Close',
                                    style: GoogleFonts.jost(color: Colors.black, fontSize: 18),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Description',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColorTwo.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            governmentScheme.description,
                            style: GoogleFonts.jost(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Nature of Assistance',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColorTwo.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            governmentScheme.natureOfAssistance,
                            style: GoogleFonts.jost(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Who can Apply',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColorTwo.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            governmentScheme.whoCanApply,
                            style: GoogleFonts.jost(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'How to Apply',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColorTwo.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            governmentScheme.howToApply,
                            style: GoogleFonts.jost(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
