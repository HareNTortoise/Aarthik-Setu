import 'package:aarthik_setu/global_components/month_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
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
                                label: "Premises/Building No.",
                                hintText: "Enter your building number",
                                controller: TextEditingController(),
                              ),
                              LabelledTextField(
                                label: "Street Name",
                                hintText: "Enter your street name",
                                controller: TextEditingController(),
                              ),
                              LabelledTextField(
                                label: "Landmark",
                                hintText: "Enter your landmark",
                                controller: TextEditingController(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LabelledTextField(
                                label: "Country",
                                hintText: "Enter your country",
                                controller: TextEditingController(),
                              ),
                              LabelledTextField(
                                label: "State",
                                hintText: "Enter your state",
                                controller: TextEditingController(),
                              ),
                              LabelledTextField(
                                label: "City",
                                hintText: "Enter your city",
                                controller: TextEditingController(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LabelledTextField(
                                label: "Pincode",
                                hintText: "Enter your pincode",
                                controller: TextEditingController(),
                              ),
                              LabelledTextField(
                                label: "Village/Town",
                                hintText: "Enter your village/town",
                                controller: TextEditingController(),
                              ),
                              LabelledTextField(
                                label: "District",
                                hintText: "Enter your district",
                                controller: TextEditingController(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LabelledTextField(
                                label: "Sub-District",
                                hintText: "Enter your sub-district",
                                controller: TextEditingController(),
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
