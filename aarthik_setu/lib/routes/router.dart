import 'package:aarthik_setu/pages/breakpoints/sign_in.dart';
import 'package:aarthik_setu/pages/desktop/forms/business_loans/gst_form.dart';
import 'package:aarthik_setu/pages/desktop/forms/loan_form_journey_template.dart';
import 'package:aarthik_setu/pages/desktop/forms/personal_loans/bank_details.dart';
import 'package:aarthik_setu/pages/desktop/forms/personal_loans/basic_details.dart';
import 'package:aarthik_setu/pages/desktop/forms/personal_loans/credit_info.dart';
import 'package:aarthik_setu/pages/desktop/forms/personal_loans/itr_form.dart';
import 'package:aarthik_setu/pages/desktop/forms/personal_loans/loan_form.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aarthik_setu/pages/desktop/home/dashboard.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../pages/desktop/forms/business_loans/bank_details.dart';
import '../pages/desktop/forms/business_loans/itr_form.dart';
import '../pages/desktop/forms/business_loans/loan_form.dart';
import '../pages/desktop/forms/business_loans/stakeholders.dart';
import '../pages/desktop/forms/personal_loans/contact_details.dart';
import '../pages/desktop/forms/personal_loans/employment_details.dart';

final GoRouter router = GoRouter(
  initialLocation: '/business-loan-journey/abc/gst-details',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(child: SignInPage()),
    ),
    GoRoute(
      path: '/dashboard',
      pageBuilder: (context, state) => const MaterialPage(child: DashboardDesktop()),
    ),
    GoRoute(
      path: '/personal-loan-journey/:loanType',
      pageBuilder: (context, state) => MaterialPage(
        child: LoanFormJourneyTemplate(
          formTitle: "Auto Loan",
          formLinks: [
            SizedBox(
              width: 500,
              height: 500,
              child: FilledButton.tonal(
                onPressed: () {},
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  shadowColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.4)),
                  elevation: WidgetStateProperty.all(10),
                ),
                child: Text("Basic Details", style: GoogleFonts.poppins(fontSize: 40)),
              ),
            ),
          ],
        ),
      ),
      routes: [
        GoRoute(
          path: 'itr',
          pageBuilder: (context, state) => const MaterialPage(child: ITRFormPersonal()),
        ),
        GoRoute(
          path: 'bank-details',
          pageBuilder: (context, state) => const MaterialPage(child: BankDetailsPersonalForm()),
        ),
        GoRoute(
          path: 'basic-details',
          pageBuilder: (context, state) => const MaterialPage(child: BasicDetailsForm()),
        ),
        GoRoute(
          path: 'employment-details',
          pageBuilder: (context, state) => const MaterialPage(child: EmploymentDetailsForm()),
        ),
        GoRoute(
          path: 'contact-details',
          pageBuilder: (context, state) => const MaterialPage(child: ContactDetailsForm()),
        ),
        GoRoute(
          path: 'credit-info',
          pageBuilder: (context, state) => const MaterialPage(child: CreditInfoForm()),
        ),
        GoRoute(
          path: 'loan-form',
          pageBuilder: (context, state) => const MaterialPage(child: LoanFormPersonal()),
        ),
      ],
    ),
    GoRoute(
      path: '/business-loan-journey/:loanType',
      pageBuilder: (context, state) => const MaterialPage(
        child: LoanFormJourneyTemplate(
          formTitle: "Business Loan",
          formLinks: [],
        ),
      ),
      routes: [
        GoRoute(
          path: 'gst-details',
          pageBuilder: (context, state) => const MaterialPage(child: GSTDetailsForm()),
        ),
        GoRoute(
          path: 'itr',
          pageBuilder: (context, state) => const MaterialPage(child: ITRFormBusiness()),
        ),
        GoRoute(
          path: 'bank-details',
          pageBuilder: (context, state) => const MaterialPage(child: BankDetailsBusinessForm()),
        ),
        GoRoute(
          path: 'stakeholders',
          pageBuilder: (context, state) => const MaterialPage(child: StakeholdersForm()),
        ),
        GoRoute(
          path: 'loan-form',
          pageBuilder: (context, state) => const MaterialPage(child: LoanFormBusiness()),
        ),
      ],
    ),
  ],
);
