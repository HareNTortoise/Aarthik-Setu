import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabelledTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final double fontSize;
  final double width;
  final double height;
  final FormFieldValidator<String>? validator; // Added validator parameter

  const LabelledTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.fontSize = 18,
    this.width = 300,
    this.height = 25,
    this.validator, // Added validator to constructor
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
        SizedBox(
          width: width,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(vertical: height, horizontal: 20),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            validator: validator, // Added validator property to TextFormField
          ),
        ),
      ],
    );
  }
}
