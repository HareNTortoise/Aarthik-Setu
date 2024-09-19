import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../../constants/colors.dart';
import '../../../../../global_components/labelled_text_field.dart';

class ItrManual extends StatefulWidget {
  const ItrManual({super.key});

  @override
  State<ItrManual> createState() => _ItrManualState();
}

class _ItrManualState extends State<ItrManual> {
  DateTime? _selectedDate;
  int currentYear = DateTime.now().year;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Declare your financial details",
              style: TextStyle(fontSize: 30),
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
                                backgroundColor: WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.5)),
                              ),
                              child: _selectedDate != null
                                  ?
                                  Row(
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
                                            style: GoogleFonts.poppins(fontSize: 20, color: Colors.black)),
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
                        label: "Mobile Number",
                        hintText: "Enter your mobile number",
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelledTextField(
                        label: "Email (Personal)*",
                        hintText: "Enter your email",
                        controller: TextEditingController(),
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
                        label: "Premises/Building No.*",
                        hintText: "Enter your address",
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: "Street/Area*",
                        hintText: "Enter your address",
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: "Landmark*",
                        hintText: "Enter your address",
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelledTextField(
                        label: "Country*",
                        hintText: "Enter your country",
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: "State*",
                        hintText: "Enter your state",
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: "City*",
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
                        label: "Pincode*",
                        hintText: "Enter your pincode",
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: "Village",
                        hintText: "Enter your village",
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
                        label: "Enter sub-district",
                        hintText: "Enter your sub-district",
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey, thickness: 0.5),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Net Annual Income Details",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelledTextField(
                        label: "FY ${currentYear - 1}-$currentYear*",
                        hintText: "Enter your net annual income",
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: "FY ${currentYear - 2}-${currentYear - 1}",
                        hintText: "Enter your net annual income",
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: "FY ${currentYear - 3}-${currentYear - 2}",
                        hintText: "Enter your net annual income",
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
    );
  }
}
