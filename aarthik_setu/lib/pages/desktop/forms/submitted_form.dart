import 'package:aarthik_setu/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SubmittedFormPage extends StatelessWidget {
  const SubmittedFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 150,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              'Form Submitted Successfully!',
              style: GoogleFonts.poppins(
                fontSize: 104,
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 300,
              height: 70,
              child: FilledButton.tonal(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.primaryColorTwo  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () {
                  context.go('/dashboard');
                },
                child: Text('Go to Dashboard', style: GoogleFonts.poppins(fontSize: 24)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
