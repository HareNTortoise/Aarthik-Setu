import 'package:aarthik_setu/pages/breakpoints/sign_in.dart';
import 'package:aarthik_setu/pages/desktop/forms/loan_form_journey_template.dart';
import 'package:aarthik_setu/pages/desktop/forms/personal_loans/itr_form.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final GoRouter router = GoRouter(
  initialLocation: '/itr-personal',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(child: SignInPage()),
    ),
    GoRoute(
      path: '/personal-loans',
      pageBuilder: (context, state) => MaterialPage(
        child: LoanFormJourneyTemplate(
          formTitle: "Auto Loan",
          forms: [
            FilledButton.tonal(
              onPressed: () {},
              child: Text("Bsic Details", style: GoogleFonts.poppins(fontSize: 40)),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              ),
            ),
            FilledButton.tonal(
              onPressed: () {},
              child: Text("Bsic Details", style: GoogleFonts.poppins(fontSize: 40)),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              ),
            ),
            FilledButton.tonal(
              onPressed: () {},
              child: Text("Bsic Details", style: GoogleFonts.poppins(fontSize: 40)),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              ),
            ),
            FilledButton.tonal(
              onPressed: () {},
              child: Text("Bsic Details", style: GoogleFonts.poppins(fontSize: 40)),
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.all(20)),
                backgroundColor: WidgetStateProperty.all(Colors.white),
                foregroundColor: WidgetStateProperty.all(Colors.black),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              ),
            ),
          ],
        ),
      ),
    ),
    GoRoute(
      path: '/itr-personal',
      pageBuilder: (context, state) => const MaterialPage(child: ITRFormPersonal()),
    )
  ],
);
