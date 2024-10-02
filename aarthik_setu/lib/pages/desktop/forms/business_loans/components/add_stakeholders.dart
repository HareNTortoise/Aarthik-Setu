import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:aarthik_setu/global_components/date_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/form_constants.dart';
import '../../../../../global_components/custom_dropdown.dart';
import '../../../../../global_components/custom_switch.dart';
import '../../../../../global_components/labelled_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StakeholderFormInputUnit {
  TextEditingController salutationController;
  TextEditingController relationshipTypeController;
  TextEditingController firstNameController;
  TextEditingController middleNameController;
  TextEditingController lastNameController;
  TextEditingController ownershipController;
  TextEditingController genderController;
  TextEditingController fatherNameController;
  DateTime? dob;
  TextEditingController mobileNumberController;
  TextEditingController residenceStatusController;
  TextEditingController panController;
  TextEditingController educationStatusController;
  TextEditingController totalExperienceController;
  TextEditingController netWorthController;
  TextEditingController addressLineOneController;
  TextEditingController addressLineTwoController;
  TextEditingController landmarkController;
  TextEditingController pincodeController;
  String? country;
  String? state;
  String? city;
  TextEditingController districtController;
  TextEditingController subDistrictController;
  TextEditingController villageController;
  TextEditingController phoneController;
  TextEditingController visuallyImpairedController;
  bool isGuarantor;

  StakeholderFormInputUnit({
    required this.salutationController,
    required this.relationshipTypeController,
    required this.firstNameController,
    required this.middleNameController,
    required this.lastNameController,
    required this.ownershipController,
    required this.genderController,
    required this.fatherNameController,
    required this.dob,
    required this.mobileNumberController,
    required this.residenceStatusController,
    required this.panController,
    required this.educationStatusController,
    required this.totalExperienceController,
    required this.netWorthController,
    required this.addressLineOneController,
    required this.addressLineTwoController,
    required this.landmarkController,
    required this.pincodeController,
    required this.country,
    required this.state,
    required this.city,
    required this.districtController,
    required this.subDistrictController,
    required this.villageController,
    required this.phoneController,
    required this.visuallyImpairedController,
    required this.isGuarantor,
  });
}

class AddStakeholders extends StatefulWidget {
  const AddStakeholders({super.key});

  @override
  State<AddStakeholders> createState() => _AddStakeholdersState();
}

class _AddStakeholdersState extends State<AddStakeholders> {
  bool _formVisible = false;
  bool _isEditing = false;

  List<StakeholderFormInputUnit> stakeholders = [];
  int? currentStakeholderIndex;

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: (context.watch<L10nBloc>().state as L10n).locale,
      child: BlocBuilder<L10nBloc, L10nState>(
        builder: (context, state) {
      return IntrinsicHeight(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 500,
                    height: 100,
                    child: FilledButton.tonal(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      ),
                      onPressed: !_formVisible
                          ? () {
                              setState(() {
                                stakeholders.add(StakeholderFormInputUnit(
                                  salutationController: TextEditingController(),
                                  relationshipTypeController: TextEditingController(),
                                  firstNameController: TextEditingController(),
                                  middleNameController: TextEditingController(),
                                  lastNameController: TextEditingController(),
                                  ownershipController: TextEditingController(),
                                  genderController: TextEditingController(),
                                  fatherNameController: TextEditingController(),
                                  dob: null,
                                  mobileNumberController: TextEditingController(),
                                  residenceStatusController: TextEditingController(),
                                  panController: TextEditingController(),
                                  educationStatusController: TextEditingController(),
                                  totalExperienceController: TextEditingController(),
                                  netWorthController: TextEditingController(),
                                  addressLineOneController: TextEditingController(),
                                  addressLineTwoController: TextEditingController(),
                                  landmarkController: TextEditingController(),
                                  pincodeController: TextEditingController(),
                                  country: null,
                                  state: null,
                                  city: null,
                                  districtController: TextEditingController(),
                                  subDistrictController: TextEditingController(),
                                  villageController: TextEditingController(),
                                  phoneController: TextEditingController(),
                                  visuallyImpairedController: TextEditingController(),
                                  isGuarantor: false,
                                ));
                                currentStakeholderIndex = stakeholders.length - 1;
                                _formVisible = true;
                                _isEditing = false;
                              });
                            }
                          : () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add, size: 40),
                          const SizedBox(width: 10),
                          Text(AppLocalizations.of(context)!.add_stakeholder, style: GoogleFonts.poppins(fontSize: 22)),
                        ],
                      ),
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primaryColorOne.withOpacity(0.5),
                      ),
                      width: 500,
                      height: 100,
                      child: DropdownButton2(
                        items: [
                          if (!_formVisible)
                            for (int i = 0; i < stakeholders.length; i++)
                              DropdownMenuItem(
                                value: i,
                                child: Row(
                                  children: [
                                    Text(stakeholders[i].firstNameController.text,
                                        style: const TextStyle(color: Colors.black, fontSize: 22)),
                                    const SizedBox(width: 20),
                                    if (i == currentStakeholderIndex) const Icon(Icons.check, color: Colors.black)
                                  ],
                                ),
                              )
                        ],
                        onChanged: (int? value) {
                          setState(() {
                            currentStakeholderIndex = value;
                            _formVisible = true;
                            _isEditing = true;
                          });
                        },
                        customButton: Ink(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.select_stakeholder,
                                style: const TextStyle(color: Colors.black, fontSize: 22),
                              ),
                              const SizedBox(width: 20),
                              const Icon(Icons.arrow_drop_down, color: Colors.black, size: 30),
                            ],
                          ),
                        ),
                        iconStyleData: const IconStyleData(icon: Icon(null)),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 500,
                          width: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          offset: const Offset(0, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: WidgetStateProperty.all(6),
                            thumbVisibility: WidgetStateProperty.all(true),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black, fontSize: 18),
                        buttonStyleData: ButtonStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (_formVisible && currentStakeholderIndex != null)
                Column(
                  children: [
                    const SizedBox(height: 20),
                    const Divider(color: Colors.grey, thickness: 0.5),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.salutation,
                          hintText: AppLocalizations.of(context)!.selectSalutation,
                          controller: stakeholders[currentStakeholderIndex!].salutationController,
                        ),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.relationship_type,
                          hintText: AppLocalizations.of(context)!.relationship_type_hint,
                          controller: stakeholders[currentStakeholderIndex!].relationshipTypeController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.firstName,
                          hintText: AppLocalizations.of(context)!.firstNameHint,
                          controller: stakeholders[currentStakeholderIndex!].firstNameController,
                        ),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.middleName,
                          hintText: AppLocalizations.of(context)!.middleNameHint,
                          controller: stakeholders[currentStakeholderIndex!].middleNameController,
                        ),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.lastName,
                          hintText: AppLocalizations.of(context)!.lastNameHint,
                          controller: stakeholders[currentStakeholderIndex!].lastNameController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.ownership_percentage,
                          hintText: AppLocalizations.of(context)!.ownership_percentage_hint,
                          controller: stakeholders[currentStakeholderIndex!].ownershipController,
                        ),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.gender,
                          hintText: AppLocalizations.of(context)!.selectGender,
                          controller: stakeholders[currentStakeholderIndex!].genderController,
                        ),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.fatherName,
                          hintText: AppLocalizations.of(context)!.enterFatherName,
                          controller: stakeholders[currentStakeholderIndex!].fatherNameController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DatePickerButton(
                          current: stakeholders[currentStakeholderIndex!].dob,
                          label: AppLocalizations.of(context)!.dob,
                          onDateSelected: (date) {
                            setState(() {
                              stakeholders[currentStakeholderIndex!].dob = date;
                            });
                          },
                        ),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.mobileNumber,
                          hintText: AppLocalizations.of(context)!.mobileNumberHint,
                          controller: stakeholders[currentStakeholderIndex!].mobileNumberController,
                        ),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.residence_status,
                          hintText: AppLocalizations.of(context)!.residence_status_hint,
                          controller: stakeholders[currentStakeholderIndex!].residenceStatusController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.pan,
                          hintText: AppLocalizations.of(context)!.panHint,
                          controller: stakeholders[currentStakeholderIndex!].panController,
                        ),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.education_status,
                          hintText: AppLocalizations.of(context)!.education_status_hint,
                          controller: stakeholders[currentStakeholderIndex!].educationStatusController,
                        ),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.total_experience,
                          hintText: AppLocalizations.of(context)!.total_experience_hint,
                          controller: stakeholders[currentStakeholderIndex!].totalExperienceController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.net_worth,
                          hintText: AppLocalizations.of(context)!.net_worth_hint,
                          controller: stakeholders[currentStakeholderIndex!].netWorthController,
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
                          hintText: AppLocalizations.of(context)!.addressLine1Placeholder,
                          controller: stakeholders[currentStakeholderIndex!].addressLineOneController,
                        ),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.addressLine2,
                          hintText: AppLocalizations.of(context)!.addressLine2Placeholder,
                          controller: stakeholders[currentStakeholderIndex!].addressLineTwoController,
                        ),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.landmark,
                          hintText: AppLocalizations.of(context)!.landmarkHint,
                          controller: stakeholders[currentStakeholderIndex!].landmarkController,
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
                          controller: stakeholders[currentStakeholderIndex!].pincodeController,
                        ),
                        CustomDropdown(
                          label: AppLocalizations.of(context)!.country,
                          buttonLabel: stakeholders[currentStakeholderIndex!].country ?? AppLocalizations.of(context)!.countryPlaceholder,
                          items: Countries.countryList,
                          onChanged: (value) {
                            setState(() {
                              stakeholders[currentStakeholderIndex!].country = value;
                            });
                          },
                        ),
                        CustomDropdown(
                          label: AppLocalizations.of(context)!.state,
                          buttonLabel: stakeholders[currentStakeholderIndex!].state ?? AppLocalizations.of(context)!.statePlaceholder,
                          items: IndiaStates.getAllStatesAndUTs(),
                          onChanged: (value) {
                            setState(() {
                              stakeholders[currentStakeholderIndex!].state = value;
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
                          buttonLabel: stakeholders[currentStakeholderIndex!].city ?? AppLocalizations.of(context)!.cityPlaceholder,
                          items: IndiaCities.citiesMap[stakeholders[currentStakeholderIndex!].state] ?? [],
                          onChanged: (value) {
                            setState(() {
                              stakeholders[currentStakeholderIndex!].city = value;
                            });
                          },
                        ),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.district,
                          hintText: AppLocalizations.of(context)!.districtHint,
                          controller: stakeholders[currentStakeholderIndex!].districtController,
                        ),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.subDistrict,
                          hintText: AppLocalizations.of(context)!.subDistrictHint,
                          controller: stakeholders[currentStakeholderIndex!].subDistrictController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.village,
                          hintText: AppLocalizations.of(context)!.villageHint,
                          controller: stakeholders[currentStakeholderIndex!].villageController,
                        ),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.phone,
                          hintText: AppLocalizations.of(context)!.phone_hint,
                          controller: stakeholders[currentStakeholderIndex!].phoneController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Divider(color: Colors.grey, thickness: 0.5),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.visually_impaired,
                          hintText: AppLocalizations.of(context)!.visually_impaired_hint,
                          controller: stakeholders[currentStakeholderIndex!].visuallyImpairedController,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.is_guarantor,
                              style: GoogleFonts.poppins(fontSize: 18),
                            ),
                            const SizedBox(width: 20),
                            CustomSwitch(
                              current: stakeholders[currentStakeholderIndex!].isGuarantor,
                              first: false,
                              second: true,
                              onChanged: (value) {
                                setState(() {
                                  stakeholders[currentStakeholderIndex!].isGuarantor = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 40),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(AppColors.primaryColorOne),
                            ),
                            onPressed: () {
                              setState(() {
                                stakeholders.removeAt(currentStakeholderIndex!);
                                currentStakeholderIndex = null;
                                _formVisible = false;
                              });
                            },
                            child: Text(
                              _isEditing ? AppLocalizations.of(context)!.delete : AppLocalizations.of(context)!.discard,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(AppColors.primaryColorOne),
                            ),
                            onPressed: () {
                              setState(() {
                                currentStakeholderIndex = null;
                                _formVisible = false;
                              });
                            },
                            child: Text(
                              AppLocalizations.of(context)!.save,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
            ],
          ),
        ),
      );
        },
      ),
    );
  }
}
