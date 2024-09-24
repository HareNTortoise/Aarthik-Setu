import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LargeTileButton extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final Icon icon;
  final String description;
  final VoidCallback onPressed;

  const LargeTileButton({
    super.key,
    this.width = 500,
    this.height = 500,
    required this.title,
    required this.icon,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FilledButton.tonal(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          shadowColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.5)),
          elevation: WidgetStateProperty.all(7),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              AutoSizeText(
                title,
                style: GoogleFonts.poppins(fontSize: 32),
              ),
              const SizedBox(height: 20),
              const Spacer(),
              icon,
              const Spacer(),
              AutoSizeText(
                description,
                style: GoogleFonts.poppins(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
