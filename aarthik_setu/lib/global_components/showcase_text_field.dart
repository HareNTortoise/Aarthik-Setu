import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowcaseTextFieldContainer extends StatelessWidget {
  final String label;
  final String value;
  final double fontSize;
  final double width;
  final double height;

  const ShowcaseTextFieldContainer({
    super.key,
    required this.label,
    required this.value,
    this.fontSize = 18,
    this.width = 300,
    this.height = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: fontSize),
        ),
        const SizedBox(height: 5),
        Container(
          width: width,
          padding: EdgeInsets.symmetric(vertical: height, horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Text(
            value,
            style: GoogleFonts.poppins(fontSize: fontSize),
          ),
        ),
      ],
    );
  }
}
