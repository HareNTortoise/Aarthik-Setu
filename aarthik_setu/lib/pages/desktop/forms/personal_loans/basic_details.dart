import 'package:aarthik_setu/constants/form_constants.dart';
import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/custom_dropdown.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/colors.dart';
import '../../../../global_components/labelled_text_field.dart';
import '../../../../global_components/procees_button.dart';

class BasicDetailsForm extends StatefulWidget {
  const BasicDetailsForm({super.key});

  @override
  State<BasicDetailsForm> createState() => _BasicDetailsFormState();
}

class _BasicDetailsFormState extends State<BasicDetailsForm> {
  int currentYear = DateTime.now().year;

  String? _salutation;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();
  DateTime? _dateOfBirth;
  final TextEditingController _panController = TextEditingController();
  String? _gender;

  String? _category;
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailPersonalController = TextEditingController();

  final TextEditingController _fatherNameController = TextEditingController();
  String? _educationQualification;
  final TextEditingController _netWorthController = TextEditingController();

  String? _nationality;
  String? _dependents;
  String? _maritalStatus;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    "Basic Details",
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
                          Form(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomDropdown(
                                      label: "Salutation*",
                                      buttonLabel: _salutation ?? "Select Salutation",
                                      items: Salutations.getSalutations(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _salutation = value;
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
                                      label: "First Name*",
                                      hintText: "Enter your first name",
                                      controller: _firstNameController,
                                    ),
                                    LabelledTextField(
                                      label: "Middle Name",
                                      hintText: "Enter your middle name",
                                      controller: _middleNameController,
                                    ),
                                    LabelledTextField(
                                      label: "Last Name*",
                                      hintText: "Enter your last name",
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
                                          'Date of Birth*',
                                          style: GoogleFonts.poppins(fontSize: 18),
                                        ),
                                        const SizedBox(height: 5),
                                        SizedBox(
                                          width: 300,
                                          height: 60,
                                          child: FilledButton(
                                            onPressed: () async {
                                              List<DateTime?>? results = await showCalendarDatePicker2Dialog(
                                                context: context,
                                                config: CalendarDatePicker2WithActionButtonsConfig(),
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
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              backgroundColor:
                                                  WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.5)),
                                            ),
                                            child: _dateOfBirth != null
                                                ? Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Icon(Icons.calendar_month, size: 30, color: Colors.black),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        "${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}",
                                                        style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
                                                      ),
                                                    ],
                                                  )
                                                : Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Icon(Icons.calendar_month, size: 30, color: Colors.black),
                                                      const SizedBox(width: 10),
                                                      Text("Date of Birth",
                                                          style:
                                                              GoogleFonts.poppins(fontSize: 20, color: Colors.black)),
                                                    ],
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    LabelledTextField(
                                      label: "PAN Number*",
                                      hintText: "Enter your PAN number",
                                      controller: _panController,
                                    ),
                                    CustomDropdown(
                                        label: 'Gender*',
                                        buttonLabel: _gender ?? 'Select Gender',
                                        items: Genders.getGenders(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            _gender = value;
                                          });
                                        })
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomDropdown(
                                      label: "Category*",
                                      buttonLabel: _category ?? "Select Category",
                                      items: Categories.getCategories(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _category = value;
                                        });
                                      },
                                    ),
                                    LabelledTextField(
                                      label: "Mobile No*",
                                      hintText: "Enter your mobile number",
                                      controller: _mobileController,
                                    ),
                                    LabelledTextField(
                                      label: "Email (Personal)*",
                                      hintText: "Enter your email",
                                      controller: _emailPersonalController,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    LabelledTextField(
                                      label: "Father's Name",
                                      hintText: "Enter your father's name",
                                      controller: _fatherNameController,
                                    ),
                                    CustomDropdown(
                                      label: "Education Qualification*",
                                      buttonLabel: _educationQualification ?? "Select Education Qualification",
                                      items: EducationQualifications.getEducationQualifications(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _educationQualification = value;
                                        });
                                      },
                                    ),
                                    LabelledTextField(
                                      label: "Net Worth*",
                                      hintText: "Enter your net worth",
                                      controller: _netWorthController,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomDropdown(
                                        label: 'Nationality*',
                                        buttonLabel: _nationality ?? 'Select Nationality',
                                        items: Nationalities.getNationalities(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            _nationality = value;
                                          });
                                        }),
                                    CustomDropdown(
                                      label: "Dependents*",
                                      buttonLabel: _dependents ?? "Select Dependents",
                                      items: Dependents.getDependents(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _dependents = value;
                                        });
                                      },
                                    ),
                                    CustomDropdown(
                                      label: "Marital Status*",
                                      buttonLabel: _maritalStatus ?? "Select Marital Status",
                                      items: MaritalStatus.getMaritalStatuses(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _maritalStatus = value;
                                        });
                                      },
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
