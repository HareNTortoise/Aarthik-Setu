import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:aarthik_setu/constants/form_constants.dart';
import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/custom_dropdown.dart';
import 'package:aarthik_setu/global_components/month_picker.dart';
import 'package:aarthik_setu/global_components/procees_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../constants/app_constants.dart';
import '../../../../global_components/labelled_text_field.dart';
import '../../../../global_components/language_dropdown.dart';
import '../../../../global_components/year_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactDetailsForm extends StatefulWidget {
  const ContactDetailsForm({super.key});

  @override
  State<ContactDetailsForm> createState() => _ContactDetailsFormState();
}

class _ContactDetailsFormState extends State<ContactDetailsForm> {
  int? _selectedMonth;
  int? _selectedYear;

  final TextEditingController _addressLineOneController = TextEditingController();
  final TextEditingController _addressLineTwoController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();

  String? _country;
  String? _state;
  String? _city;

  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();

  final TextEditingController _subDistrictController = TextEditingController();

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
                      AppLocalizations.of(context)!.contactDetailsTitle,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                LabelledTextField(
                                  label: AppLocalizations.of(context)!.addressLine1Label,
                                  hintText: AppLocalizations.of(context)!.addressLine1Placeholder,
                                  controller: _addressLineOneController,
                                ),
                                LabelledTextField(
                                  label: AppLocalizations.of(context)!.addressLine2Label,
                                  hintText: AppLocalizations.of(context)!.addressLine2Placeholder,
                                  controller: _addressLineTwoController,
                                ),
                                LabelledTextField(
                                  label: AppLocalizations.of(context)!.landmarkLabel,
                                  hintText: AppLocalizations.of(context)!.landmarkPlaceholder,
                                  controller: _landmarkController,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomDropdown(
                                  label: AppLocalizations.of(context)!.countryLabel,
                                  buttonLabel: _country ?? AppLocalizations.of(context)!.countryPlaceholder,
                                  items: Countries.countryList,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _country = value;
                                    });
                                  },
                                ),
                                CustomDropdown(
                                  label: AppLocalizations.of(context)!.stateLabel,
                                  buttonLabel: _state ?? AppLocalizations.of(context)!.statePlaceholder,
                                  items: IndiaStates.getAllStatesAndUTs(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _state = value;
                                    });
                                  },
                                ),
                                CustomDropdown(
                                  label: AppLocalizations.of(context)!.cityLabel,
                                  buttonLabel: _city ?? AppLocalizations.of(context)!.cityPlaceholder,
                                  items: IndiaCities.citiesMap[_state] ?? [],
                                  onChanged: (String? value) {
                                    setState(() {
                                      _city = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                LabelledTextField(
                                  label: AppLocalizations.of(context)!.pinCodeLabel,
                                  hintText: AppLocalizations.of(context)!.pinCodePlaceholder,
                                  controller: _pinCodeController,
                                ),
                                LabelledTextField(
                                  label: AppLocalizations.of(context)!.villageLabel,
                                  hintText: AppLocalizations.of(context)!.villagePlaceholder,
                                  controller: _villageController,
                                ),
                                LabelledTextField(
                                  label: AppLocalizations.of(context)!.districtLabel,
                                  hintText: AppLocalizations.of(context)!.districtPlaceholder,
                                  controller: _districtController,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                LabelledTextField(
                                  label: AppLocalizations.of(context)!.subDistrictLabel,
                                  hintText: AppLocalizations.of(context)!.subDistrictPlaceholder,
                                  controller: _subDistrictController,
                                ),
                                MonthPickerButton(
                                  label: AppLocalizations.of(context)!.residenceSinceMonthLabel,
                                  onMonthSelected: (DateTime value) {
                                    setState(() {
                                      _selectedMonth = value.month;
                                    });
                                  },
                                ),
                                YearPickerButton(
                                  label: AppLocalizations.of(context)!.residenceSinceYearLabel,
                                  onYearSelected: (DateTime value) {
                                    setState(() {
                                      _selectedYear = value.year;
                                    });
                                  },
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
