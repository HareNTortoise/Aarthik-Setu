import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class PersonalLoanOptions extends StatelessWidget {
  const PersonalLoanOptions({super.key});

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
              backgroundColor: WidgetStateProperty.all(Colors.white),
              shape: WidgetStateProperty.all( RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              shadowColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.5)),
              elevation: WidgetStateProperty.all(7),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  Text('Personal Loans', style: GoogleFonts.poppins(fontSize: 32)),
                  const SizedBox(height: 20),
                  const Spacer(),
                  const Icon(LineIcons.moneyBill, size: 150),
                  const Spacer(),
                  Text('Get a personal loan with low interest rates and flexible repayment options.',
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
              backgroundColor: WidgetStateProperty.all(Colors.white),
              shape: WidgetStateProperty.all( RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              shadowColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.5)),
              elevation: WidgetStateProperty.all(7),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  Text('Home Loans', style: GoogleFonts.poppins(fontSize: 32)),
                  const SizedBox(height: 20),
                  const Spacer(),
                  const Icon(LineIcons.home, size: 150),
                  const Spacer(),
                  Text('Get a home loan with low interest rates and flexible repayment options.',
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
              backgroundColor: WidgetStateProperty.all(Colors.white),
              shape: WidgetStateProperty.all( RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              shadowColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.5)),
              elevation: WidgetStateProperty.all(7),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  Text('Business Loans', style: GoogleFonts.poppins(fontSize: 32)),
                  const SizedBox(height: 20),
                  const Spacer(),
                  const Icon(LineIcons.businessTime, size: 150),
                  const Spacer(),
                  Text('Get a business loan with low interest rates and flexible repayment options.',
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
