import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/labelled_text_field.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/colors.dart';
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
                              LabelledTextField(
                                width: 250,
                                label: "Loan Purpose*",
                                hintText: 'Enter loan purpose',
                                controller: TextEditingController(),
                              ),
                              LabelledTextField(
                                width: 250,
                                label: "Loan Amount Required*",
                                hintText: 'Enter loan amount',
                                controller: TextEditingController(),
                              ),
                              LabelledTextField(
                                width: 250,
                                label: "Tenure (Years)*",
                                hintText: 'Enter tenure',
                                controller: TextEditingController(),
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
                                controller: TextEditingController(),
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
                              SizedBox(
                                width: 160,
                                height: 60,
                                child: AnimatedToggleSwitch<bool>.dual(
                                  current: _emiBySalaryAccount,
                                  first: false,
                                  second: true,
                                  borderWidth: 6,
                                  textBuilder: (index) => index == true
                                      ? Text(
                                          "Yes",
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        )
                                      : Text(
                                          "No",
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                  indicatorSize: const Size.fromWidth(50),
                                  style: ToggleStyle(
                                    backgroundColor: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50),
                                    borderColor: Colors.transparent,
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(0, 1.5),
                                      ),
                                    ],
                                  ),
                                  styleBuilder: (index) => index == true
                                      ? const ToggleStyle(indicatorColor: Colors.green)
                                      : ToggleStyle(indicatorColor: AppColors.primaryColorOne),
                                  iconBuilder: (index) => index == true
                                      ? const Icon(
                                          Icons.check,
                                          size: 30,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.close,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                  onChanged: (value) {
                                    setState(() {
                                      _emiBySalaryAccount = value;
                                    });
                                  },
                                ),
                              ),
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
                              SizedBox(
                                width: 160,
                                height: 60,
                                child: AnimatedToggleSwitch<bool>.dual(
                                  current: _payOutstandingByTerminalPayments,
                                  first: false,
                                  second: true,
                                  borderWidth: 6,
                                  textBuilder: (index) => index == true
                                      ? Text(
                                          "Yes",
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        )
                                      : Text(
                                          "No",
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                  indicatorSize: const Size.fromWidth(50),
                                  style: ToggleStyle(
                                    backgroundColor: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50),
                                    borderColor: Colors.transparent,
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(0, 1.5),
                                      ),
                                    ],
                                  ),
                                  styleBuilder: (index) => index == true
                                      ? const ToggleStyle(indicatorColor: Colors.green)
                                      : ToggleStyle(indicatorColor: AppColors.primaryColorOne),
                                  iconBuilder: (index) => index == true
                                      ? const Icon(
                                          Icons.check,
                                          size: 30,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.close,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                  onChanged: (value) {
                                    setState(() {
                                      _payOutstandingByTerminalPayments = value;
                                    });
                                  },
                                ),
                              ),
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
                              SizedBox(
                                width: 160,
                                height: 60,
                                child: AnimatedToggleSwitch<bool>.dual(
                                  current: _paySalaryInSalaryAccount,
                                  first: false,
                                  second: true,
                                  borderWidth: 6,
                                  textBuilder: (index) => index == true
                                      ? Text(
                                          "Yes",
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        )
                                      : Text(
                                          "No",
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                  indicatorSize: const Size.fromWidth(50),
                                  style: ToggleStyle(
                                    backgroundColor: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50),
                                    borderColor: Colors.transparent,
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(0, 1.5),
                                      ),
                                    ],
                                  ),
                                  styleBuilder: (index) => index == true
                                      ? const ToggleStyle(indicatorColor: Colors.green)
                                      : ToggleStyle(indicatorColor: AppColors.primaryColorOne),
                                  iconBuilder: (index) => index == true
                                      ? const Icon(
                                          Icons.check,
                                          size: 30,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.close,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                  onChanged: (value) {
                                    setState(() {
                                      _paySalaryInSalaryAccount = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
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
                              SizedBox(
                                width: 160,
                                height: 60,
                                child: AnimatedToggleSwitch<bool>.dual(
                                  current: _issueLetterToYourEmployerToPayOutstandingLoan,
                                  first: false,
                                  second: true,
                                  borderWidth: 6,
                                  textBuilder: (index) => index == true
                                      ? Text(
                                          "Yes",
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        )
                                      : Text(
                                          "No",
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                  indicatorSize: const Size.fromWidth(50),
                                  style: ToggleStyle(
                                    backgroundColor: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50),
                                    borderColor: Colors.transparent,
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(0, 1.5),
                                      ),
                                    ],
                                  ),
                                  styleBuilder: (index) => index == true
                                      ? const ToggleStyle(indicatorColor: Colors.green)
                                      : ToggleStyle(indicatorColor: AppColors.primaryColorOne),
                                  iconBuilder: (index) => index == true
                                      ? const Icon(
                                          Icons.check,
                                          size: 30,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.close,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                  onChanged: (value) {
                                    setState(() {
                                      _issueLetterToYourEmployerToPayOutstandingLoan = value;
                                    });
                                  },
                                ),
                              ),
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
                              SizedBox(width: 20),
                              SizedBox(
                                width: 160,
                                height: 60,
                                child: AnimatedToggleSwitch<bool>.dual(
                                  current: _issueLetterToYourEmployerToNotChangeSalaryAccount,
                                  first: false,
                                  second: true,
                                  borderWidth: 6,
                                  textBuilder: (index) => index == true
                                      ? Text(
                                          "Yes",
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        )
                                      : Text(
                                          "No",
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                  indicatorSize: const Size.fromWidth(50),
                                  style: ToggleStyle(
                                    backgroundColor: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50),
                                    borderColor: Colors.transparent,
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(0, 1.5),
                                      ),
                                    ],
                                  ),
                                  styleBuilder: (index) => index == true
                                      ? const ToggleStyle(indicatorColor: Colors.green)
                                      : ToggleStyle(indicatorColor: AppColors.primaryColorOne),
                                  iconBuilder: (index) => index == true
                                      ? const Icon(
                                          Icons.check,
                                          size: 30,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.close,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                  onChanged: (value) {
                                    setState(() {
                                      _issueLetterToYourEmployerToNotChangeSalaryAccount = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LabelledTextField(
                                label: "Choose Repayment Method*",
                                hintText: 'Enter repayment method',
                                controller: TextEditingController(),
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
