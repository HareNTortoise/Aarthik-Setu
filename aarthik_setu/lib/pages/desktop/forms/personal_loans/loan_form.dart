import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/custom_dropdown.dart';
import 'package:aarthik_setu/global_components/custom_switch.dart';
import 'package:aarthik_setu/global_components/labelled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/form_constants.dart';
import '../../../../global_components/procees_button.dart';

class LoanFormPersonal extends StatefulWidget {
  const LoanFormPersonal({super.key});

  @override
  State<LoanFormPersonal> createState() => _LoanFormPersonalState();
}

class _LoanFormPersonalState extends State<LoanFormPersonal> {
  bool _emiBySalaryAccount = false;
  bool _payOutstandingByTerminalPayments = false;
  bool _paySalaryInSalaryAccount = false;

  bool _issueLetterToYourEmployerToPayOutstandingLoan = false;
  bool _issueLetterToYourEmployerToNotChangeSalaryAccount = false;

  String? _loanPurpose;

  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();
  final TextEditingController _retirementAgeController = TextEditingController();

  String? _repaymentMethod;

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
                            "Loan Details",
                            style: TextStyle(fontSize: 26),
                          ),
                          const SizedBox(height: 20),
                          const Divider(color: Colors.grey, thickness: 0.5),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 250,
                                child: CustomDropdown(
                                  label: "Loan Purpose*",
                                  buttonLabel: _loanPurpose ?? "Select Loan Purpose",
                                  items: LoanTypes.getLoanTypes(),
                                  onChanged: (value) {
                                    setState(() {
                                      _loanPurpose = value;
                                    });
                                  },
                                ),
                              ),
                              LabelledTextField(
                                width: 250,
                                label: "Loan Amount Required*",
                                hintText: 'Enter loan amount',
                                controller: _loanAmountController,
                              ),
                              LabelledTextField(
                                width: 250,
                                label: "Tenure (Years)*",
                                hintText: 'Enter tenure',
                                controller: _tenureController,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LabelledTextField(
                                width: 250,
                                label: "Retirement Age (Years)*",
                                hintText: 'Enter retirement age',
                                controller: _retirementAgeController,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
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
                            "Your Employer Will",
                            style: TextStyle(fontSize: 26),
                          ),
                          const SizedBox(height: 20),
                          const Divider(color: Colors.grey, thickness: 0.5),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                child: Text(
                                  'Pay EMI directly from your salary account?',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              const SizedBox(width: 20),
                              CustomSwitch(
                                current: _emiBySalaryAccount,
                                onChanged: (value) {
                                  setState(() {
                                    _emiBySalaryAccount = value;
                                  });
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                child: Text(
                                  'Agree to pay outstanding loan amount from terminal payments in event you leave your employer?',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              const SizedBox(width: 20),
                              CustomSwitch(
                                current: _payOutstandingByTerminalPayments,
                                onChanged: (value) {
                                  setState(() {
                                    _payOutstandingByTerminalPayments = value;
                                  });
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                child: Text(
                                  'Pay salary only in your salary account and take confirmation (NOC) from bank before shifting your salary account?',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              const SizedBox(width: 20),
                              CustomSwitch(
                                current: _paySalaryInSalaryAccount,
                                onChanged: (value) {
                                  setState(() {
                                    _paySalaryInSalaryAccount = value;
                                  });
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
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
                            "Whether you (Employer/Borrower) will",
                            style: TextStyle(fontSize: 26),
                          ),
                          const SizedBox(height: 20),
                          const Divider(color: Colors.grey, thickness: 0.5),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                child: Text(
                                  'Issue letter to your employer, to pay outstanding loan from your terminal payments in event you leave your employer?',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              const SizedBox(width: 20),
                              CustomSwitch(
                                current: _issueLetterToYourEmployerToPayOutstandingLoan,
                                onChanged: (value) {
                                  setState(() {
                                    _issueLetterToYourEmployerToPayOutstandingLoan = value;
                                  });
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Flexible(
                                child: Text(
                                  'Issue letter to your employer to not change your salary account and take confirmation from bank (NOC) in case of a change?',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              const SizedBox(width: 20),
                              CustomSwitch(
                                current: _issueLetterToYourEmployerToNotChangeSalaryAccount,
                                onChanged: (value) {
                                  setState(() {
                                    _issueLetterToYourEmployerToNotChangeSalaryAccount = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomDropdown(
                                label: "Repayment Method*",
                                buttonLabel: _repaymentMethod ?? "Select Repayment Method",
                                items: RepaymentMethods.getRepaymentModes(),
                                onChanged: (value) {
                                  setState(() {
                                    _repaymentMethod = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
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
