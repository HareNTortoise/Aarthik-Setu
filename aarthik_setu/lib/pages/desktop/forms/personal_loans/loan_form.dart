import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/custom_dropdown.dart';
import 'package:aarthik_setu/global_components/custom_switch.dart';
import 'package:aarthik_setu/global_components/labelled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/form_constants.dart';
import '../../../../global_components/language_dropdown.dart';
import '../../../../global_components/procees_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoanFormPersonal extends StatefulWidget {
  const LoanFormPersonal({super.key});

  @override
  State<LoanFormPersonal> createState() => _LoanFormPersonalState();
}

class _LoanFormPersonalState extends State<LoanFormPersonal> {
  bool _emiBySalaryAccount = false;
  bool _payOutstandingByTerminalPayments = false;
  bool _paySalaryInSalaryAccount = false;

  bool _issueLetterToYourEmployerToPayOutstandingLoan = false;
  bool _issueLetterToYourEmployerToNotChangeSalaryAccount = false;

  String? _loanPurpose;

  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();
  final TextEditingController _retirementAgeController = TextEditingController();

  String? _repaymentMethod;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Localizations.override(
        context: context,
        locale: (context.watch<L10nBloc>().state as L10n).locale,
        child: BlocBuilder<L10nBloc, L10nState>(
          builder: (context, state) {
            return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: SizedBox.expand(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const LanguageDropdown(),
                    Text(
                      AppLocalizations.of(context)!.loanFormTitle,
                      style: GoogleFonts.poppins(fontSize: 80),
                    ),
                    const SizedBox(height: 40),
                    IntrinsicHeight(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        margin: const EdgeInsets.only(bottom: 100),
                        width: 1200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 7,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              AppLocalizations.of(context)!.loanDetailsTitle,
                              style: const TextStyle(fontSize: 26),
                            ),
                            const SizedBox(height: 20),
                            const Divider(color: Colors.grey, thickness: 0.5),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: CustomDropdown(
                                    label: AppLocalizations.of(context)!.loanPurposeLabel,
                                    buttonLabel: _loanPurpose ?? AppLocalizations.of(context)!.loanPurposePlaceholder,
                                    items: LoanTypes.getLoanTypes(),
                                    onChanged: (value) {
                                      setState(() {
                                        _loanPurpose = value;
                                      });
                                    },
                                  ),
                                ),
                                LabelledTextField(
                                  width: 250,
                                  label: AppLocalizations.of(context)!.loanAmountLabel,
                                  hintText: AppLocalizations.of(context)!.loanAmountHint,
                                  controller: _loanAmountController,
                                ),
                                LabelledTextField(
                                  width: 250,
                                  label: AppLocalizations.of(context)!.tenureLabel,
                                  hintText: AppLocalizations.of(context)!.tenureHint,
                                  controller: _tenureController,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                LabelledTextField(
                                  width: 250,
                                  label: AppLocalizations.of(context)!.retirementAgeLabel,
                                  hintText: AppLocalizations.of(context)!.retirementAgeHint,
                                  controller: _retirementAgeController,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    IntrinsicHeight(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        margin: const EdgeInsets.only(bottom: 100),
                        width: 1200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 7,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              AppLocalizations.of(context)!.yourEmployerWillTitle,
                              style: const TextStyle(fontSize: 26),
                            ),
                            const SizedBox(height: 20),
                            const Divider(color: Colors.grey, thickness: 0.5),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    AppLocalizations.of(context)!.emiFromSalaryAccountText,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                CustomSwitch(
                                  current: _emiBySalaryAccount,
                                  onChanged: (value) {
                                    setState(() {
                                      _emiBySalaryAccount = value;
                                    });
                                  },
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    AppLocalizations.of(context)!.outstandingLoanTerminalPaymentsText,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                CustomSwitch(
                                  current: _payOutstandingByTerminalPayments,
                                  onChanged: (value) {
                                    setState(() {
                                      _payOutstandingByTerminalPayments = value;
                                    });
                                  },
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    AppLocalizations.of(context)!.salaryAccountConfirmationText,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                CustomSwitch(
                                  current: _paySalaryInSalaryAccount,
                                  onChanged: (value) {
                                    setState(() {
                                      _paySalaryInSalaryAccount = value;
                                    });
                                  },
                                )
                              ],
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                    IntrinsicHeight(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        margin: const EdgeInsets.only(bottom: 100),
                        width: 1200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 7,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              AppLocalizations.of(context)!.whetherYouWillTitle,
                              style: const TextStyle(fontSize: 26),
                            ),
                            const SizedBox(height: 20),
                            const Divider(color: Colors.grey, thickness: 0.5),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    AppLocalizations.of(context)!.issueLetterOutstandingLoanText,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                CustomSwitch(
                                  current: _issueLetterToYourEmployerToPayOutstandingLoan,
                                  onChanged: (value) {
                                    setState(() {
                                      _issueLetterToYourEmployerToPayOutstandingLoan = value;
                                    });
                                  },
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    AppLocalizations.of(context)!.issueLetterNotChangeAccountText,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                CustomSwitch(
                                  current: _issueLetterToYourEmployerToNotChangeSalaryAccount,
                                  onChanged: (value) {
                                    setState(() {
                                      _issueLetterToYourEmployerToNotChangeSalaryAccount = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomDropdown(
                                  label: AppLocalizations.of(context)!.repaymentMethodLabel,
                                  buttonLabel: _repaymentMethod ?? AppLocalizations.of(context)!.repaymentMethodPlaceholder,
                                  items: RepaymentMethods.getRepaymentModes(),
                                  onChanged: (value) {
                                    setState(() {
                                      _repaymentMethod = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            const Divider(color: Colors.grey, thickness: 0.5),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                BackButtonCustom(onPressed: () => context.pop()),
                                const SizedBox(width: 40),
                                ProceedButtonCustom(onPressed: () {}),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
          },
        ),
      ),
    );
  }
}
