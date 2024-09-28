import 'package:aarthik_setu/constants/form_constants.dart';
import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/custom_dropdown.dart';
import 'package:aarthik_setu/global_components/month_picker.dart';
import 'package:aarthik_setu/global_components/procees_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../constants/app_constants.dart';
import '../../../../global_components/labelled_text_field.dart';
import '../../../../global_components/year_picker.dart';

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
                    "Contact Details",
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
                                label: "Address Line 1*",
                                hintText: "Enter your building number",
                                controller: _addressLineOneController,
                              ),
                              LabelledTextField(
                                label: "Address Line 2",
                                hintText: "Enter your street name",
                                controller: _addressLineTwoController,
                              ),
                              LabelledTextField(
                                label: "Landmark",
                                hintText: "Enter your landmark",
                                controller: _landmarkController,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomDropdown(
                                label: "Country*",
                                buttonLabel: _country ?? "Select your country",
                                items: Countries.countryList,
                                onChanged: (String? value) {
                                  setState(() {
                                    _country = value;
                                  });
                                },
                              ),
                              CustomDropdown(
                                label: "State*",
                                buttonLabel: _state ?? "Select your state",
                                items: IndiaStates.getAllStatesAndUTs(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _state = value;
                                  });
                                },
                              ),
                              CustomDropdown(
                                label: "City*",
                                buttonLabel: _city ?? "Select your city",
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
                                label: "Pin code*",
                                hintText: "Enter your pin code",
                                controller: _pinCodeController,
                              ),
                              LabelledTextField(
                                label: "Village/Town",
                                hintText: "Enter your village/town",
                                controller: _villageController,
                              ),
                              LabelledTextField(
                                label: "District*",
                                hintText: "Enter your district",
                                controller: _districtController,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LabelledTextField(
                                label: "Sub-District*",
                                hintText: "Enter your sub-district",
                                controller: _subDistrictController,
                              ),
                              MonthPickerButton(
                                label: 'Residence Since (Month)',
                                onMonthSelected: (DateTime value) {
                                  setState(() {
                                    _selectedMonth = value.month;
                                  });
                                },
                              ),
                              YearPickerButton(
                                label: 'Residence Since (Year)',
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
      ),
    );
  }
}
