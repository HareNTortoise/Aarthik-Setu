import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:aarthik_setu/constants/form_constants.dart';
import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../constants/app_constants.dart';
import '../../../../global_components/labelled_text_field.dart';
import '../../../../global_components/language_dropdown.dart';
import '../../../../global_components/procees_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmploymentDetailsForm extends StatefulWidget {
  const EmploymentDetailsForm({super.key});

  @override
  State<EmploymentDetailsForm> createState() => _EmploymentDetailsFormState();
}

class _EmploymentDetailsFormState extends State<EmploymentDetailsForm> {
  String? _employmentStatus;
  String? _designation;
  String? _employmentType;
  String? _modeOfSalary;
  final TextEditingController _grossMonthlyIncomeController = TextEditingController();
  final TextEditingController _netMonthlyIncomeController = TextEditingController();

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
                    const SizedBox(height: 60),
                    Text(
                      AppLocalizations.of(context)!.employmentDetails,
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
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomDropdown(
                                label: AppLocalizations.of(context)!.employmentStatus,
                                buttonLabel: _employmentStatus ?? AppLocalizations.of(context)!.selectEmploymentStatus,
                                items: EmploymentStatus.getEmploymentStatuses(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _employmentStatus = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                              CustomDropdown(
                                label: AppLocalizations.of(context)!.designation,
                                buttonLabel: _designation ?? AppLocalizations.of(context)!.selectDesignation,
                                items: Designations.getDesignations(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _designation = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                              CustomDropdown(
                                label: AppLocalizations.of(context)!.employmentType,
                                buttonLabel: _employmentType ?? AppLocalizations.of(context)!.selectEmploymentType,
                                items: EmploymentType.getEmploymentTypes(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _employmentType = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomDropdown(
                                label: AppLocalizations.of(context)!.modeOfSalary,
                                buttonLabel: _modeOfSalary ?? AppLocalizations.of(context)!.selectModeOfSalary,
                                items: ModesOfSalary.getModesOfSalary(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _modeOfSalary = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                              LabelledTextField(
                                label: AppLocalizations.of(context)!.grossMonthlyIncome,
                                hintText: AppLocalizations.of(context)!.enterGrossMonthlyIncome,
                                controller: _grossMonthlyIncomeController,
                              ),
                              const SizedBox(height: 20),
                              LabelledTextField(
                                label: AppLocalizations.of(context)!.netMonthlyIncome,
                                hintText: AppLocalizations.of(context)!.enterNetMonthlyIncome,
                                controller: _netMonthlyIncomeController,
                              ),
                            ],
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
                          )
                        ]),
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
