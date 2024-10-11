import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:aarthik_setu/constants/colors.dart';
import 'package:aarthik_setu/repository/govt_schemes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SchemeInfoPopupMobile extends StatelessWidget {
  const SchemeInfoPopupMobile({super.key, required this.governmentScheme});

  final GovernmentScheme governmentScheme;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,  // Adjust width for mobile
        height: MediaQuery.of(context).size.height * 0.8, // Adjust height for mobile
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Smaller padding for mobile
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            governmentScheme.relatedScheme,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 24, // Smaller font size for mobile
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.black),
                          onPressed: () => context.pop(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Description',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 22, // Reduced font size
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColorTwo.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0), // Smaller padding
                        child: Text(
                          governmentScheme.description,
                          style: GoogleFonts.jost(
                            color: Colors.black,
                            fontSize: 16, // Smaller font size
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Nature of Assistance',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColorTwo.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          governmentScheme.natureOfAssistance,
                          style: GoogleFonts.jost(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Who can Apply',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColorTwo.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          governmentScheme.whoCanApply,
                          style: GoogleFonts.jost(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'How to Apply',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColorTwo.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          governmentScheme.howToApply,
                          style: GoogleFonts.jost(
                            color: Colors.black,
                            fontSize: 16,
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
    );
  }
}
// Compare this snippet from lib/pages/mobile/home/components/scheme_info_popup.dart: