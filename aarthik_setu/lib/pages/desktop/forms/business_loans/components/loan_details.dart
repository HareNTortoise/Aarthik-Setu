import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../constants/colors.dart';
import '../../../../../global_components/labelled_text_field.dart';

class LoanDetailsForm extends StatefulWidget {
  const LoanDetailsForm({super.key});

  @override
  State<LoanDetailsForm> createState() => _LoanDetailsFormState();
}

class _LoanDetailsFormState extends State<LoanDetailsForm> {
  bool _isISOCertified = false;
  int currentYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
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
              "Loan details",
              style: TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelledTextField(
                  label: "Loan Amount Required*",
                  hintText: 'Enter Loan Amount',
                  controller: TextEditingController(),
                ),
                LabelledTextField(
                  label: "Promoter Contribution*",
                  hintText: 'Enter promoter contribution',
                  controller: TextEditingController(),
                ),
                LabelledTextField(
                  label: "Purpose of Loan*",
                  hintText: 'Enter purpose of loan',
                  controller: TextEditingController(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelledTextField(
                  label: "Projected Sales FY $currentYear-${currentYear % 100 + 1}*",
                  hintText: 'Enter projected sales',
                  controller: TextEditingController(),
                ),
                Text('Is your business ISO certified?', style: GoogleFonts.poppins(fontSize: 20)),
                SizedBox(
                  width: 160,
                  height: 60,
                  child: AnimatedToggleSwitch<bool>.dual(
                    current: _isISOCertified,
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
                        _isISOCertified = value;
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
                LabelledTextField(
                  label: "Factory Premise*",
                  hintText: 'Enter factory premise',
                  controller: TextEditingController(),
                ),
                LabelledTextField(
                  label: "Projected Know How*",
                  hintText: 'Enter projected know how',
                  controller: TextEditingController(),
                ),
                LabelledTextField(
                  label: "Competition*",
                  hintText: 'Enter competition',
                  controller: TextEditingController(),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
