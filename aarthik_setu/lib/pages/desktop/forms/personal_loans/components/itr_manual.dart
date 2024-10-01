import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:aarthik_setu/constants/form_constants.dart';
import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/custom_dropdown.dart';
import 'package:aarthik_setu/global_components/procees_button.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../constants/colors.dart';
import '../../../../../global_components/labelled_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItrManual extends StatefulWidget {
  const ItrManual({super.key});

  @override
  State<ItrManual> createState() => _ItrManualState();
}

class _ItrManualState extends State<ItrManual> {
  int currentYear = DateTime.now().year;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  DateTime? _dateOfBirth;
  final TextEditingController _panNumberController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _premisesController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();

  final TextEditingController _landmarkController = TextEditingController();
  String? country;
  String? state;

  String? city;
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();

  final TextEditingController _subDistrictController = TextEditingController();
  final TextEditingController _netAnnualIncomeControllerOne =
      TextEditingController();
  final TextEditingController _netAnnualIncomeControllerTwo =
      TextEditingController();
  final TextEditingController _netAnnualIncomeControllerThree =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Localizations.override(
        context: context,
        locale: (context.watch<L10nBloc>().state as L10n).locale,
        child: BlocBuilder<L10nBloc, L10nState>(
          builder: (context, _) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                    AppLocalizations.of(context)!.declareFinancialDetails,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey, thickness: 0.5),
                  const SizedBox(height: 20),
                  Form(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LabelledTextField(
                              label: AppLocalizations.of(context)!.firstName,
                              hintText: AppLocalizations.of(context)!.firstNameHint,
                              controller: _firstNameController,
                            ),
                            LabelledTextField(
                              label: AppLocalizations.of(context)!.middleName,
                              hintText: AppLocalizations.of(context)!.middleNameHint,
                              controller: _middleNameController,
                            ),
                            LabelledTextField(
                              label: AppLocalizations.of(context)!.lastName,
                              hintText: AppLocalizations.of(context)!.lastNameHint,
                              controller: _lastNameController,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.dateOfBirth,
                                  style: GoogleFonts.poppins(fontSize: 18),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: 300,
                                  height: 60,
                                  child: FilledButton(
                                    onPressed: () async {
                                      List<DateTime?>? results =
                                          await showCalendarDatePicker2Dialog(
                                        context: context,
                                        config:
                                            CalendarDatePicker2WithActionButtonsConfig(),
                                        dialogSize: const Size(525, 400),
                                        value: [DateTime.now()],
                                        borderRadius: BorderRadius.circular(15),
                                      );
                                      if (results != null) {
                                        setState(() {
                                          _dateOfBirth = results[0];
                                        });
                                      }
                                    },
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      backgroundColor: WidgetStateProperty.all(
                                          AppColors.primaryColorTwo
                                              .withOpacity(0.5)),
                                    ),
                                    child: _dateOfBirth != null
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.calendar_month,
                                                  size: 30,
                                                  color: Colors.black),
                                              const SizedBox(width: 10),
                                              Text(
                                                "${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.calendar_month,
                                                  size: 30,
                                                  color: Colors.black),
                                              const SizedBox(width: 10),
                                              Text(AppLocalizations.of(context)!.selectDateOfBirth,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                            LabelledTextField(
                              label: AppLocalizations.of(context)!.panNumber,
                              hintText: AppLocalizations.of(context)!.panNumberHint,
                              controller: _panNumberController,
                            ),
                            LabelledTextField(
                              label: AppLocalizations.of(context)!.mobileNumber,
                              hintText: AppLocalizations.of(context)!.mobileNumberHint,
                              controller: _mobileNumberController,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LabelledTextField(
                              label: AppLocalizations.of(context)!.email,
                              hintText: AppLocalizations.of(context)!.emailHint,
                              controller: _emailController,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Divider(color: Colors.grey, thickness: 0.5),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LabelledTextField(
                              label: AppLocalizations.of(context)!.addressLine1,
                              hintText: AppLocalizations.of(context)!.addressLine1Hint,
                              controller: _premisesController,
                            ),
                            LabelledTextField(
                              label: AppLocalizations.of(context)!.addressLine2,
                              hintText: AppLocalizations.of(context)!.addressLine2Hint,
                              controller: _streetController,
                            ),
                            LabelledTextField(
                              label: AppLocalizations.of(context)!.landmark,
                              hintText: AppLocalizations.of(context)!.landmarkHint,
                              controller: _landmarkController,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomDropdown(
                              label: AppLocalizations.of(context)!.country,
                              buttonLabel: country ?? 'Select Country',
                              items: Countries.countryList,
                              onChanged: (String? selectedCountry) {
                                setState(() {
                                  country = selectedCountry;
                                });
                              },
                            ),
                            CustomDropdown(
                              label: AppLocalizations.of(context)!.state,
                              buttonLabel: state ?? 'Select State',
                              items: IndiaStates.getAllStatesAndUTs(),
                              onChanged: (String? selectedState) {
                                setState(() {
                                  state = selectedState;
                                  city = null;
                                });
                              },
                            ),
                            CustomDropdown(
                              label: AppLocalizations.of(context)!.city,
                              buttonLabel: city ?? 'Select City',
                              items: IndiaCities.citiesMap[state] ?? [],
                              onChanged: (String? selectedCity) {
                                setState(() {
                                  city = selectedCity;
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
                              label: AppLocalizations.of(context)!.pinCode,
                              hintText: AppLocalizations.of(context)!.pinCodeHint,
                              controller: _pinCodeController,
                            ),
                            LabelledTextField(
                              label: AppLocalizations.of(context)!.village,
                              hintText: AppLocalizations.of(context)!.villageHint,
                              controller: _villageController,
                            ),
                            LabelledTextField(
                              label: AppLocalizations.of(context)!.district,
                              hintText: AppLocalizations.of(context)!.districtHint,
                              controller: _districtController,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LabelledTextField(
                              label: AppLocalizations.of(context)!.subDistrict,
                              hintText: AppLocalizations.of(context)!.subDistrictHint,
                              controller: _subDistrictController,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Divider(color: Colors.grey, thickness: 0.5),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              AppLocalizations.of(context)!.netAnnualIncome,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LabelledTextField(
                              label: "${AppLocalizations.of(context)!.fyLabel} ${currentYear - 1}-$currentYear*",
                              hintText: AppLocalizations.of(context)!.annualIncomeHint,
                              controller: _netAnnualIncomeControllerOne,
                            ),
                            LabelledTextField(
                              label: "${AppLocalizations.of(context)!.fyLabel} ${currentYear - 2}-${currentYear - 1}",
                              hintText: AppLocalizations.of(context)!.annualIncomeHint,
                              controller: _netAnnualIncomeControllerTwo,
                            ),
                            LabelledTextField(
                              label: "${AppLocalizations.of(context)!.fyLabel} ${currentYear - 3}-${currentYear - 2}",
                              hintText: AppLocalizations.of(context)!.annualIncomeHint,
                              controller: _netAnnualIncomeControllerThree,
                            ),
                          ],
                        ),
                      ],
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
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
