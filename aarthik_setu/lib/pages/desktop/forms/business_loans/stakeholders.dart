import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:aarthik_setu/constants/form_constants.dart';
import 'package:aarthik_setu/global_components/custom_dropdown.dart';
import 'package:aarthik_setu/global_components/labelled_text_field.dart';
import 'package:aarthik_setu/global_components/month_picker.dart';
import 'package:aarthik_setu/pages/desktop/forms/business_loans/components/add_stakeholders.dart';
import 'package:aarthik_setu/pages/desktop/forms/business_loans/components/main_partner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../bloc/l10n/l10n_bloc.dart';
import '../../../../global_components/language_dropdown.dart';
import '../../../../global_components/year_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StakeholdersForm extends StatefulWidget {
  const StakeholdersForm({super.key});

  @override
  State<StakeholdersForm> createState() => _StakeholdersFormState();
}

class _StakeholdersFormState extends State<StakeholdersForm> {
  int currentYear = DateTime.now().year;

  final TextEditingController _addressLineOneController = TextEditingController();
  final TextEditingController _addressLineTwoController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();

  final TextEditingController _pinCodeController = TextEditingController();
  String? _country;
  String? _state;

  String? _city;
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _subDistrictController = TextEditingController();

  final TextEditingController _villageController = TextEditingController();
  DateTime? accountSinceMonth;
  DateTime? accountSinceYear;

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
                      AppLocalizations.of(context)!.declare_business_stakeholders,
                      style: GoogleFonts.poppins(fontSize: 80),
                    ),
                    const SizedBox(height: 60),
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
                          children: [
                            Text(
                              AppLocalizations.of(context)!.business_details,
                              style: GoogleFonts.poppins(fontSize: 40),
                            ),
                            const SizedBox(height: 20),
                            const Divider(color: Colors.grey, thickness: 0.5),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                LabelledTextField(
                                  label: AppLocalizations.of(context)!.address_line_1,
                                  hintText: AppLocalizations.of(context)!.addressLine1Placeholder,
                                  controller: _addressLineOneController,
                                ),
                                LabelledTextField(
                                  label: AppLocalizations.of(context)!.address_line_2,
                                  hintText: AppLocalizations.of(context)!.addressLine2Placeholder,
                                  controller: _addressLineTwoController,
                                ),
                                LabelledTextField(
                                  label: AppLocalizations.of(context)!.landmark,
                                  hintText: AppLocalizations.of(context)!.landmarkPlaceholder,
                                  controller: _landmarkController,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                LabelledTextField(
                                  label: AppLocalizations.of(context)!.pinCode,
                                  hintText: AppLocalizations.of(context)!.pinCodePlaceholder,
                                  controller: _pinCodeController,
                                ),
                                CustomDropdown(
                                  label: AppLocalizations.of(context)!.country,
                                  buttonLabel: _country ?? AppLocalizations.of(context)!.countryPlaceholder,
                                  items: Countries.countryList,
                                  onChanged: (value) {
                                    setState(() {
                                      _country = value;
                                    });
                                  },
                                ),
                               CustomDropdown(
                                  label: AppLocalizations.of(context)!.state,
                                  buttonLabel: _state ?? AppLocalizations.of(context)!.statePlaceholder,
                                  items: IndiaStates.getAllStatesAndUTs(),
                                  onChanged: (value) {
                                    setState(() {
                                      _state = value;
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
                                  label: AppLocalizations.of(context)!.city,
                                  buttonLabel: _city ?? AppLocalizations.of(context)!.cityPlaceholder,
                                  items: IndiaCities.citiesMap[_state] ?? [],
                                  onChanged: (value) {
                                    setState(() {
                                      _city = value;
                                    });
                                  },
                                ),
                                LabelledTextField(
                                  label: AppLocalizations.of(context)!.district,
                                  hintText: AppLocalizations.of(context)!.districtHint,
                                  controller: _districtController,
                                ),
                                LabelledTextField(
                                  label: AppLocalizations.of(context)!.subDistrict,
                                  hintText: AppLocalizations.of(context)!.subDistrictHint,
                                  controller: _subDistrictController,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                LabelledTextField(
                                  label: AppLocalizations.of(context)!.village,
                                  hintText: AppLocalizations.of(context)!.villageHint,
                                  controller: _villageController,
                                ),
                                MonthPickerButton(
                                  current: accountSinceMonth,
                                  label: AppLocalizations.of(context)!.month,
                                  onMonthSelected: (month) {
                                    setState(() {
                                      accountSinceMonth = month;
                                    });
                                  },
                                ),
                                YearPickerButton(
                                  current: accountSinceYear,
                                  label: AppLocalizations.of(context)!.yearButton,
                                  onYearSelected: (year) {
                                    setState(() {
                                      accountSinceYear = year;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const AddStakeholders(),
                    const MainPartnerForm(),
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
