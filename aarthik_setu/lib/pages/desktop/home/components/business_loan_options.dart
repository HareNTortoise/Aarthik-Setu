import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class BusinessLoanOptions extends StatelessWidget {
  const BusinessLoanOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 500,
          width: 500,
          child: FilledButton.tonal(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              shadowColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.5)),
              elevation: MaterialStateProperty.all(7),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  Text('MSME Loans', style: GoogleFonts.poppins(fontSize: 32)),
                  const SizedBox(height: 20),
                  const Spacer(),
                  const Icon(LineIcons.industry, size: 150),
                  const Spacer(),
                  Text('Get MSME loans up to ₹5 Crores with low interest rates and flexible repayment options.',
                      style: GoogleFonts.poppins(fontSize: 18), textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 500,
          width: 500,
          child: FilledButton.tonal(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              shadowColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.5)),
              elevation: MaterialStateProperty.all(7),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  Text('Term Loans', style: GoogleFonts.poppins(fontSize: 32)),
                  const SizedBox(height: 20),
                  const Spacer(),
                  const Icon(LineIcons.handshake, size: 150),
                  const Spacer(),
                  Text('Get term loans up to ₹50 Lakhs with competitive rates and flexible repayment terms.',
                      style: GoogleFonts.poppins(fontSize: 18), textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 500,
          width: 500,
          child: FilledButton.tonal(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              shadowColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.5)),
              elevation: MaterialStateProperty.all(7),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  Text('Mudra Loans', style: GoogleFonts.poppins(fontSize: 32)),
                  const SizedBox(height: 20),
                  const Spacer(),
                  const Icon(LineIcons.piggyBank, size: 150),
                  const Spacer(),
                  Text('Get Mudra loans up to ₹10 Lakhs for micro-enterprises with flexible repayment.',
                      style: GoogleFonts.poppins(fontSize: 18), textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
