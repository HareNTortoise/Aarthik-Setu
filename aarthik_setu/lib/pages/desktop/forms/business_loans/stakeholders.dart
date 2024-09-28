import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:aarthik_setu/constants/form_constants.dart';
import 'package:aarthik_setu/global_components/custom_dropdown.dart';
import 'package:aarthik_setu/global_components/labelled_text_field.dart';
import 'package:aarthik_setu/global_components/month_picker.dart';
import 'package:aarthik_setu/pages/desktop/forms/business_loans/components/add_stakeholders.dart';
import 'package:aarthik_setu/pages/desktop/forms/business_loans/components/main_partner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../global_components/year_picker.dart';

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
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    "Declare Business Stakeholders",
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
                            "Business details",
                            style: GoogleFonts.poppins(fontSize: 40),
                          ),
                          const SizedBox(height: 20),
                          const Divider(color: Colors.grey, thickness: 0.5),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LabelledTextField(
                                label: 'Address Line 1*',
                                hintText: 'Enter address',
                                controller: _addressLineOneController,
                              ),
                              LabelledTextField(
                                label: 'Address Line 2',
                                hintText: 'Enter address',
                                controller: _addressLineTwoController,
                              ),
                              LabelledTextField(
                                label: 'Landmark',
                                hintText: 'Enter Landmark',
                                controller: _landmarkController,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LabelledTextField(
                                label: 'Pin code',
                                hintText: 'Enter pin code',
                                controller: _pinCodeController,
                              ),
                              CustomDropdown(
                                label: 'Country*',
                                buttonLabel: _country ?? 'Select country',
                                items: Countries.countryList,
                                onChanged: (value) {
                                  setState(() {
                                    _country = value;
                                  });
                                },
                              ),
                             CustomDropdown(
                                label: 'State*',
                                buttonLabel: _state ?? 'Select state',
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
                                label: 'City*',
                                buttonLabel: _city ?? 'Select city',
                                items: IndiaCities.citiesMap[_state] ?? [],
                                onChanged: (value) {
                                  setState(() {
                                    _city = value;
                                  });
                                },
                              ),
                              LabelledTextField(
                                label: 'District',
                                hintText: 'Enter district',
                                controller: _districtController,
                              ),
                              LabelledTextField(
                                label: 'Sub-district',
                                hintText: 'Enter sub-district',
                                controller: _subDistrictController,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LabelledTextField(
                                label: 'Village',
                                hintText: 'Enter village',
                                controller: _villageController,
                              ),
                              MonthPickerButton(
                                current: accountSinceMonth,
                                label: 'Month',
                                onMonthSelected: (month) {
                                  setState(() {
                                    accountSinceMonth = month;
                                  });
                                },
                              ),
                              YearPickerButton(
                                current: accountSinceYear,
                                label: 'Year',
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
      ),
    );
  }
}
