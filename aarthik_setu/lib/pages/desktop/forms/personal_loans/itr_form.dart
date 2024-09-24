import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:aarthik_setu/constants/colors.dart';
import 'package:aarthik_setu/pages/desktop/forms/personal_loans/components/itr_file.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'components/itr_manual.dart';

class ITRFormPersonal extends StatefulWidget {
  const ITRFormPersonal({super.key});

  @override
  State<ITRFormPersonal> createState() => _ITRFormPersonalState();
}

class _ITRFormPersonalState extends State<ITRFormPersonal> {
  bool _isManual = false;
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
                  _isManual
                      ? const Text(
                          "Declare your financial details if your annual income is less than 2.5 LPA",
                          style: TextStyle(fontSize: 20),
                        )
                      : Text(
                          "ITR Details of Financial Year ${currentYear - 2}-${currentYear - 1} is mandatory",
                          style: const TextStyle(fontSize: 20),
                        ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 350,
                    height: 100,
                    child: AnimatedToggleSwitch<bool>.dual(
                      current: _isManual,
                      first: false,
                      second: true,
                      borderWidth: 10,
                      textBuilder: (index) => index == false
                          ? Text(
                              "Upload ITR",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            )
                          : Text(
                              "Manual Declaration",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 22,
                              ),
                            ),
                      indicatorSize: const Size.fromWidth(85),
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
                      styleBuilder: (index) => index == false
                          ? ToggleStyle(indicatorColor: AppColors.primaryColorOne)
                          : ToggleStyle(indicatorColor: AppColors.primaryColorTwo),
                      iconBuilder: (index) => index == false
                          ? const Icon(
                              Icons.upload,
                              size: 30,
                              color: Colors.white,
                            )
                          : const Icon(Icons.edit, size: 30),
                      onChanged: (value) {
                        setState(() {
                          _isManual = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 60),
                  if (!_isManual) const ItrFilePersonal() else const ItrManual(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
