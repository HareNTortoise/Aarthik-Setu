import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class BackButtonCustom extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double width;
  final double height;

  const BackButtonCustom({
    super.key,
    required this.onPressed,
    this.label = "Back",
    this.width = 200.0,
    this.height = 65.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: HexColor("#568737")),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back,
              color: HexColor("#568737"),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.poppins(fontSize: 20, color: HexColor("#568737")),
            ),
          ],
        ),
      ),
    );
  }
}