import 'package:aarthik_setu/global_components/date_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/form_constants.dart';
import '../../../../../global_components/custom_dropdown.dart';
import '../../../../../global_components/custom_switch.dart';
import '../../../../../global_components/labelled_text_field.dart';

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
                        Text("Add Stakeholder", style: GoogleFonts.poppins(fontSize: 22)),
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Select Stakeholder",
                              style: TextStyle(color: Colors.black, fontSize: 22),
                            ),
                            SizedBox(width: 20),
                            Icon(Icons.arrow_drop_down, color: Colors.black, size: 30),
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
                        label: 'Salutation',
                        hintText: 'Enter salutation',
                        controller: stakeholders[currentStakeholderIndex!].salutationController,
                      ),
                      LabelledTextField(
                        label: 'Relationship type',
                        hintText: 'Enter relationship',
                        controller: stakeholders[currentStakeholderIndex!].relationshipTypeController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelledTextField(
                        label: 'First Name',
                        hintText: 'Enter first name',
                        controller: stakeholders[currentStakeholderIndex!].firstNameController,
                      ),
                      LabelledTextField(
                        label: 'Middle Name',
                        hintText: 'Enter middle name',
                        controller: stakeholders[currentStakeholderIndex!].middleNameController,
                      ),
                      LabelledTextField(
                        label: 'Last Name',
                        hintText: 'Enter last name',
                        controller: stakeholders[currentStakeholderIndex!].lastNameController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelledTextField(
                        label: 'Ownership %',
                        hintText: 'Enter Ownership %',
                        controller: stakeholders[currentStakeholderIndex!].ownershipController,
                      ),
                      LabelledTextField(
                        label: 'Gender',
                        hintText: 'Enter gender',
                        controller: stakeholders[currentStakeholderIndex!].genderController,
                      ),
                      LabelledTextField(
                        label: 'Father Name',
                        hintText: 'Enter father name',
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
                        label: 'Date of Birth',
                        onDateSelected: (date) {
                          setState(() {
                            stakeholders[currentStakeholderIndex!].dob = date;
                          });
                        },
                      ),
                      LabelledTextField(
                        label: 'Mobile Number',
                        hintText: 'Enter mobile number',
                        controller: stakeholders[currentStakeholderIndex!].mobileNumberController,
                      ),
                      LabelledTextField(
                        label: 'Residence Status',
                        hintText: 'Enter residence status',
                        controller: stakeholders[currentStakeholderIndex!].residenceStatusController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelledTextField(
                        label: 'Enter PAN',
                        hintText: 'Enter PAN',
                        controller: stakeholders[currentStakeholderIndex!].panController,
                      ),
                      LabelledTextField(
                        label: 'Education Status',
                        hintText: 'Enter education status',
                        controller: stakeholders[currentStakeholderIndex!].educationStatusController,
                      ),
                      LabelledTextField(
                        label: 'Total Experience (years)',
                        hintText: 'Enter total experience',
                        controller: stakeholders[currentStakeholderIndex!].totalExperienceController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelledTextField(
                        label: 'Net Worth (INR)',
                        hintText: 'Enter net worth',
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
                        label: 'Address Line One*',
                        hintText: 'Enter Building No.',
                        controller: stakeholders[currentStakeholderIndex!].addressLineOneController,
                      ),
                      LabelledTextField(
                        label: 'Address Line Two',
                        hintText: 'Enter Street',
                        controller: stakeholders[currentStakeholderIndex!].addressLineTwoController,
                      ),
                      LabelledTextField(
                        label: 'Landmark',
                        hintText: 'Enter Landmark',
                        controller: stakeholders[currentStakeholderIndex!].landmarkController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelledTextField(
                        label: 'Pincode',
                        hintText: 'Enter pincode',
                        controller: stakeholders[currentStakeholderIndex!].pincodeController,
                      ),
                      CustomDropdown(
                        label: 'Country',
                        buttonLabel: stakeholders[currentStakeholderIndex!].country ?? 'Select country',
                        items: Countries.countryList,
                        onChanged: (value) {
                          setState(() {
                            stakeholders[currentStakeholderIndex!].country = value;
                          });
                        },
                      ),
                      CustomDropdown(
                        label: 'State',
                        buttonLabel: stakeholders[currentStakeholderIndex!].state ?? 'Select state',
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
                        label: 'City',
                        buttonLabel: stakeholders[currentStakeholderIndex!].city ?? 'Select city',
                        items: IndiaCities.citiesMap[stakeholders[currentStakeholderIndex!].state] ?? [],
                        onChanged: (value) {
                          setState(() {
                            stakeholders[currentStakeholderIndex!].city = value;
                          });
                        },
                      ),
                      LabelledTextField(
                        label: 'District',
                        hintText: 'Enter district',
                        controller: stakeholders[currentStakeholderIndex!].districtController,
                      ),
                      LabelledTextField(
                        label: 'Sub-district',
                        hintText: 'Enter sub-district',
                        controller: stakeholders[currentStakeholderIndex!].subDistrictController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LabelledTextField(
                        label: 'Village',
                        hintText: 'Enter village',
                        controller: stakeholders[currentStakeholderIndex!].villageController,
                      ),
                      LabelledTextField(
                        label: 'Phone',
                        hintText: 'Enter phone',
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
                        label: 'Visually Impaired',
                        hintText: 'Enter level',
                        controller: stakeholders[currentStakeholderIndex!].visuallyImpairedController,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Is is Guarantor?",
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
                            _isEditing ? "Delete" : "Discard",
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
                          child: const Text(
                            "Save",
                            style: TextStyle(fontSize: 20),
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
  }
}
