import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    this.current = false,
    this.first = true,
    required this.onChanged,
    required this.second,
    this.firstText = "No",
    this.secondText = "Yes",
  });

  final bool current;
  final bool first;
  final bool second;
  final String firstText;
  final String secondText;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 60,
      child: AnimatedToggleSwitch<bool>.dual(
        current: current,
        first: first,
        second: true,
        borderWidth: 6,
        textBuilder: (index) => index == true
            ? Text(
                firstText,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                ),
              )
            : Text(
                secondText,
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
        onChanged: onChanged,
      ),
    );
  }
}
