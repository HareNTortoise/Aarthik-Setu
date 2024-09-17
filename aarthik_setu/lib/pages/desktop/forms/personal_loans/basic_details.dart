import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/colors.dart';
import '../../../../global_components/labelled_text_field.dart';

class BasicDetailsForm extends StatefulWidget {
  const BasicDetailsForm({super.key});

  @override
  State<BasicDetailsForm> createState() => _BasicDetailsFormState();
}

class _BasicDetailsFormState extends State<BasicDetailsForm> {
  DateTime? _selectedDate;
  int currentYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal:0),
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
                                    LabelledTextField(
                                      label: "Salutation*",
                                      hintText: "Enter your salutation",
                                      controller: TextEditingController(),
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
                                      controller: TextEditingController(),
                                    ),
                                    LabelledTextField(
                                      label: "Middle Name",
                                      hintText: "Enter your middle name",
                                      controller: TextEditingController(),
                                    ),
                                    LabelledTextField(
                                      label: "Last Name*",
                                      hintText: "Enter your last name",
                                      controller: TextEditingController(),
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
                                                  _selectedDate = results[0];
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
                                            child: _selectedDate != null
                                                ? Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Icon(Icons.calendar_month, size: 30, color: Colors.black),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
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
                                      label: "PAN Number",
                                      hintText: "Enter your PAN number",
                                      controller: TextEditingController(),
                                    ),
                                    LabelledTextField(
                                      label: "Gender",
                                      hintText: "Enter your Gender",
                                      controller: TextEditingController(),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    LabelledTextField(
                                      label: "Category",
                                      hintText: "Enter your category",
                                      controller: TextEditingController(),
                                    ),
                                    LabelledTextField(
                                      label: "Mobile No*",
                                      hintText: "Enter your mobile number",
                                      controller: TextEditingController(),
                                    ),
                                    LabelledTextField(
                                      label: "Email (Personal)*",
                                      hintText: "Enter your email",
                                      controller: TextEditingController(),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    LabelledTextField(
                                      label: "Father's Name*",
                                      hintText: "Enter your father's name",
                                      controller: TextEditingController(),
                                    ),
                                    LabelledTextField(
                                      label: "Education Qualification",
                                      hintText: "Enter your education qualification",
                                      controller: TextEditingController(),
                                    ),
                                    LabelledTextField(
                                      label: "Net Worth",
                                      hintText: "Enter your net worth",
                                      controller: TextEditingController(),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    LabelledTextField(
                                      label: "Nationality",
                                      hintText: "Enter your nationality",
                                      controller: TextEditingController(),
                                    ),
                                    LabelledTextField(
                                      label: "Dependent",
                                      hintText: "Enter your dependent",
                                      controller: TextEditingController(),
                                    ),
                                    LabelledTextField(
                                      label: "Marital Status",
                                      hintText: "Enter your marital status",
                                      controller: TextEditingController(),
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
                              SizedBox(
                                width: 200,
                                height: 50,
                                child: FilledButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(Colors.white),
                                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(color: HexColor("#568737")),
                                    )),
                                  ),
                                  child: Text(
                                    "Back",
                                    style: TextStyle(fontSize: 20, color: HexColor("#568737")),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                              SizedBox(
                                width: 200,
                                height: 50,
                                child: FilledButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(HexColor("#568737")),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    "Proceed",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
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
