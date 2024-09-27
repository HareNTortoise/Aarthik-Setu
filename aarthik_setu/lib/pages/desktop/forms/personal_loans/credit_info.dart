import 'package:aarthik_setu/constants/form_constants.dart';
import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/custom_dropdown.dart';
import 'package:aarthik_setu/global_components/procees_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/colors.dart';
import '../../../../global_components/labelled_text_field.dart';

class CreditInfoInputUnit {
  String? loanType;
  final TextEditingController lender;
  final TextEditingController sanctionedAmount;
  final TextEditingController outstandingAmount;
  final TextEditingController emiAmount;

  CreditInfoInputUnit({
    required this.loanType,
    required this.lender,
    required this.sanctionedAmount,
    required this.outstandingAmount,
    required this.emiAmount,
  });
}

class CreditInfoForm extends StatefulWidget {
  const CreditInfoForm({super.key});

  @override
  State<CreditInfoForm> createState() => _CreditInfoFormState();
}

class _CreditInfoFormState extends State<CreditInfoForm> {
  final List<CreditInfoInputUnit> _creditInfo = [];

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
                    "Credit Information",
                    style: GoogleFonts.poppins(fontSize: 80),
                  ),
                  const SizedBox(height: 40),
                  IntrinsicHeight(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      margin: const EdgeInsets.only(bottom: 100),
                      width: 1700,
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
                            "Declare Credit Information",
                            style: TextStyle(fontSize: 26),
                          ),
                          const SizedBox(height: 20),
                          const Divider(color: Colors.grey, thickness: 0.5),
                          const SizedBox(height: 20),
                          for (int i = 0; i < _creditInfo.length; i++)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                              margin: const EdgeInsets.only(bottom: 10, top: 20),
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
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      CustomDropdown(
                                        label: "Loan Type*",
                                        buttonLabel: _creditInfo[i].loanType ?? "Select Loan Type",
                                        items: LoanTypes.getLoanTypes(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            _creditInfo[i].loanType = value;
                                          });
                                        },
                                      ),
                                      LabelledTextField(
                                        width: 250,
                                        label: "Lender*",
                                        hintText: 'Enter lender',
                                        controller: _creditInfo[i].lender,
                                      ),
                                      LabelledTextField(
                                        width: 250,
                                        label: "Sanctioned Amount (₹)*",
                                        hintText: 'Enter sanctioned amount',
                                        controller: _creditInfo[i].sanctionedAmount,
                                      ),
                                      LabelledTextField(
                                        width: 250,
                                        label: "Outstanding Amount (₹)*",
                                        hintText: 'Enter outstanding amount',
                                        controller: _creditInfo[i].outstandingAmount,
                                      ),
                                      LabelledTextField(
                                        width: 250,
                                        label: "EMI Amount (₹)*",
                                        hintText: 'Enter EMI amount',
                                        controller: _creditInfo[i].emiAmount,
                                      ),
                                      SizedBox(
                                        height: 65,
                                        width: 65,
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _creditInfo.removeAt(i);
                                              });
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(AppColors.primaryColorOne.withOpacity(0.35)),
                                              shape: WidgetStateProperty.all(
                                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                            ),
                                            icon: const Icon(Icons.delete, color: Colors.red, size: 30)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: 60,
                              width: 300,
                              child: FilledButton.tonal(
                                onPressed: () {
                                  setState(() {
                                    _creditInfo.add(
                                      CreditInfoInputUnit(
                                        loanType: null,
                                        lender: TextEditingController(),
                                        sanctionedAmount: TextEditingController(),
                                        outstandingAmount: TextEditingController(),
                                        emiAmount: TextEditingController(),
                                      ),
                                    );
                                  });
                                },
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add),
                                    SizedBox(width: 10),
                                    Text(
                                      "Add Existing Loan",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Divider(color: Colors.grey, thickness: 0.5),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BackButtonCustom(onPressed: () => context.pop()),
                              const SizedBox(width: 40),
                              ProceedButtonCustom(onPressed: () {}),
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
