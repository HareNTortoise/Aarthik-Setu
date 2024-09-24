import 'package:aarthik_setu/pages/breakpoints/sign_in.dart';
import 'package:aarthik_setu/pages/desktop/forms/business_loans/gst_form.dart';
import 'package:aarthik_setu/pages/desktop/forms/template/loan_form_journey_template.dart';
import 'package:aarthik_setu/pages/desktop/forms/personal_loans/bank_details.dart';
import 'package:aarthik_setu/pages/desktop/forms/personal_loans/basic_details.dart';
import 'package:aarthik_setu/pages/desktop/forms/personal_loans/credit_info.dart';
import 'package:aarthik_setu/pages/desktop/forms/personal_loans/itr_form.dart';
import 'package:aarthik_setu/pages/desktop/forms/personal_loans/loan_form.dart';
import 'package:aarthik_setu/pages/desktop/home/dashboard.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../pages/desktop/forms/business_loans/bank_details.dart';
import '../pages/desktop/forms/business_loans/itr_form.dart';
import '../pages/desktop/forms/business_loans/loan_form.dart';
import '../pages/desktop/forms/business_loans/stakeholders.dart';
import '../pages/desktop/forms/personal_loans/contact_details.dart';
import '../pages/desktop/forms/personal_loans/employment_details.dart';
import '../pages/desktop/loading.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', pageBuilder: (context, state) => const MaterialPage(child: LoadingPage())),
    GoRoute(
      path: '/sign-in',
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
          formTitle: state.pathParameters['loanType'] == 'personal'
              ? "Personal Loan"
              : state.pathParameters['loanType'] == 'home'
                  ? "Home Loan"
                  : "Auto Loan",
          loanType: state.pathParameters['loanType'],
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
      pageBuilder: (context, state) => MaterialPage(
        child: LoanFormJourneyTemplate(
          formTitle: state.pathParameters['loanType'] == 'msme'
              ? "MSME Loan"
              : state.pathParameters['loanType'] == 'term'
                  ? "Term Loan"
                  : "Mudra Loan",
          loanType: state.pathParameters['loanType'],
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
