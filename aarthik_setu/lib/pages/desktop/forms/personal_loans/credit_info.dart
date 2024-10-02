import 'package:aarthik_setu/constants/form_constants.dart';
import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/custom_dropdown.dart';
import 'package:aarthik_setu/global_components/procees_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../bloc/l10n/l10n_bloc.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/colors.dart';
import '../../../../global_components/labelled_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../global_components/language_dropdown.dart';

class CreditInfoInputUnit {
  String? loanType;
  final TextEditingController lender;
  final TextEditingController sanctionedAmount;
  final TextEditingController outstandingAmount;
  final TextEditingController emiAmount;

  CreditInfoInputUnit({
    required this.loanType,
    required this.lender,
    required this.sanctionedAmount,
    required this.outstandingAmount,
    required this.emiAmount,
  });
}

class CreditInfoForm extends StatefulWidget {
  const CreditInfoForm({super.key});

  @override
  State<CreditInfoForm> createState() => _CreditInfoFormState();
}

class _CreditInfoFormState extends State<CreditInfoForm> {
  final List<CreditInfoInputUnit> _creditInfo = [];

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
                      AppLocalizations.of(context)!.creditInformationTitle,
                      style: GoogleFonts.poppins(fontSize: 80),
                    ),
                    const SizedBox(height: 40),
                    IntrinsicHeight(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        margin: const EdgeInsets.only(bottom: 100),
                        width: 1700,
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
                              AppLocalizations.of(context)!.declareCreditInformation,
                              style: const TextStyle(fontSize: 26),
                            ),
                            const SizedBox(height: 20),
                            const Divider(color: Colors.grey, thickness: 0.5),
                            const SizedBox(height: 20),
                            for (int i = 0; i < _creditInfo.length; i++)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                                margin: const EdgeInsets.only(bottom: 10, top: 20),
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
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        CustomDropdown(
                                          label: AppLocalizations.of(context)!.loanTypeLabel,
                                          buttonLabel: _creditInfo[i].loanType ?? AppLocalizations.of(context)!.selectLoanType,
                                          items: LoanTypes.getLoanTypes(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              _creditInfo[i].loanType = value;
                                            });
                                          },
                                        ),
                                        LabelledTextField(
                                          width: 250,
                                          label: AppLocalizations.of(context)!.lenderLabel,
                                          hintText: AppLocalizations.of(context)!.enterLenderPlaceholder,
                                          controller: _creditInfo[i].lender,
                                        ),
                                        LabelledTextField(
                                          width: 250,
                                          label: AppLocalizations.of(context)!.sanctionedAmountLabel,
                                          hintText: AppLocalizations.of(context)!.enterSanctionedAmountPlaceholder,
                                          controller: _creditInfo[i].sanctionedAmount,
                                        ),
                                        LabelledTextField(
                                          width: 250,
                                          label: AppLocalizations.of(context)!.outstandingAmountLabel,
                                          hintText: AppLocalizations.of(context)!.enterOutstandingAmountPlaceholder,
                                          controller: _creditInfo[i].outstandingAmount,
                                        ),
                                        LabelledTextField(
                                          width: 250,
                                          label: AppLocalizations.of(context)!.emiAmountLabel,
                                          hintText: AppLocalizations.of(context)!.enterEmiAmountPlaceholder,
                                          controller: _creditInfo[i].emiAmount,
                                        ),
                                        SizedBox(
                                          height: 65,
                                          width: 65,
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _creditInfo.removeAt(i);
                                                });
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStateProperty.all(AppColors.primaryColorOne.withOpacity(0.35)),
                                                shape: WidgetStateProperty.all(
                                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                              ),
                                              icon: const Icon(Icons.delete, color: Colors.red, size: 30)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: 60,
                                width: 300,
                                child: FilledButton.tonal(
                                  onPressed: () {
                                    setState(() {
                                      _creditInfo.add(
                                        CreditInfoInputUnit(
                                          loanType: null,
                                          lender: TextEditingController(),
                                          sanctionedAmount: TextEditingController(),
                                          outstandingAmount: TextEditingController(),
                                          emiAmount: TextEditingController(),
                                        ),
                                      );
                                    });
                                  },
                                  style: ButtonStyle(
                                    shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.add),
                                      const SizedBox(width: 10),
                                      Text(
                                        AppLocalizations.of(context)!.addExistingLoanButton,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
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
