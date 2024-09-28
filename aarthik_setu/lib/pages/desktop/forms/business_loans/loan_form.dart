import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/procees_button.dart';
import 'package:aarthik_setu/pages/desktop/forms/business_loans/components/business_details.dart';
import 'package:aarthik_setu/pages/desktop/forms/business_loans/components/declare_collateral.dart';
import 'package:aarthik_setu/pages/desktop/forms/business_loans/components/existing_loans.dart';
import 'package:aarthik_setu/pages/desktop/forms/business_loans/components/loan_details.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../constants/app_constants.dart';
import '../../../../global_components/labelled_text_field.dart';

class LoanFormBusiness extends StatefulWidget {
  const LoanFormBusiness({super.key});

  @override
  State<LoanFormBusiness> createState() => _LoanFormBusinessState();
}

class _LoanFormBusinessState extends State<LoanFormBusiness> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    "Loan Form",
                    style: GoogleFonts.poppins(fontSize: 80),
                  ),
                  const SizedBox(height: 40),
                  BusinessDetailsForm(),
                  const DeclareCollateralForm(),
                  const LoanDetailsForm(),
                  const ExistingLoansForm(),
                  IntrinsicHeight(
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
                            "Total Loan",
                            style: TextStyle(fontSize: 26),
                          ),
                          const SizedBox(height: 20),
                          const Divider(color: Colors.grey, thickness: 0.5),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 55,
                            child: RichText(
                              softWrap: true,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Note",
                                    style: GoogleFonts.poppins(
                                        fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        " : The Banker will have the option to request shifting of existing facilities/limits to their bank or ask for pari passu charges.",
                                    style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              LabelledTextField(
                                enabled: false,
                                label: "Existing loans",
                                hintText: '',
                                controller: TextEditingController(),
                              ),
                              const SizedBox(
                                height: 70,
                                child: Center(child: Icon(Icons.add, color: Colors.grey)),
                              ),
                              LabelledTextField(
                                enabled: false,
                                label: "Additional Loan Required",
                                hintText: '',
                                controller: TextEditingController(),
                              ),
                              const SizedBox(
                                height: 70,
                                child: Center(child: Icon(LineIcons.equals, color: Colors.grey)),
                              ),
                              LabelledTextField(
                                enabled: false,
                                label: "Total loan",
                                hintText: '',
                                controller: TextEditingController(),
                              ),
                              const SizedBox(width: 60),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Divider(color: Colors.grey, thickness: 0.5),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BackButtonCustom(onPressed: () => context.pop()),
                              const SizedBox(width: 40),
                              ProceedButtonCustom(label: 'Submit', onPressed: () {})
                            ],
                          ),
                        ],
                      ),
                    ),
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
