import 'package:aarthik_setu/global_components/date_picker.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../../constants/colors.dart';
import '../../../../../global_components/labelled_text_field.dart';

class DeclareBusiness extends StatefulWidget {
  const DeclareBusiness({super.key});

  @override
  State<DeclareBusiness> createState() => _DeclareBusinessState();
}

class _DeclareBusinessState extends State<DeclareBusiness> {
  DateTime? _incorporationDate;

  int currentYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          "Declare your business details",
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
                    label: "Business Name*",
                    hintText: "Enter business name",
                    controller: TextEditingController(),
                  ),
                  DatePickerButton(
                    label: 'Date of Incorporation',
                    onDateSelected: (date) {
                      setState(() {
                        _incorporationDate = date;
                      });
                    },
                  ),
                  LabelledTextField(
                    label: "Constitution*",
                    hintText: "Enter your constitution",
                    controller: TextEditingController(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  LabelledTextField(
                    label: "No. of Customers*",
                    hintText: "Enter your number of customers",
                    controller: TextEditingController(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LabelledTextField(
                    label: "PAN*",
                    hintText: "Enter your PAN",
                    controller: TextEditingController(),
                  ),
                  LabelledTextField(
                    label: "Highest sale recorded*",
                    hintText: "Enter your highest sale recorded",
                    controller: TextEditingController(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey, thickness: 0.5),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Last Year's Sales",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Text('January', style: GoogleFonts.poppins(fontSize: 20)),
                      LabelledTextField(
                        label: "Sales (Jan)",
                        hintText: "Enter sales",
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('February', style: GoogleFonts.poppins(fontSize: 20)),
                      LabelledTextField(
                        label: "Sales (Feb)",
                        hintText: "Enter sales",
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('March', style: GoogleFonts.poppins(fontSize: 20)),
                      LabelledTextField(
                        label: "Sales (Mar)",
                        hintText: "Enter sales",
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('April', style: GoogleFonts.poppins(fontSize: 20)),
                      LabelledTextField(
                        label: "Sales (Apr)",
                        hintText: "Enter sales",
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('May', style: GoogleFonts.poppins(fontSize: 20)),
                      LabelledTextField(
                        label: "Sales (May)",
                        hintText: "Enter sales",
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('June', style: GoogleFonts.poppins(fontSize: 20)),
                      LabelledTextField(
                        label: "Sales (Jun)",
                        hintText: "Enter sales",
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('July', style: GoogleFonts.poppins(fontSize: 20)),
                      LabelledTextField(
                        label: "Sales (Jul)",
                        hintText: "Enter sales",
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('August', style: GoogleFonts.poppins(fontSize: 20)),
                      LabelledTextField(
                        label: "Sales (Aug)",
                        hintText: "Enter sales",
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('September', style: GoogleFonts.poppins(fontSize: 20)),
                      LabelledTextField(
                        label: "Sales (Sep)",
                        hintText: "Enter sales",
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('October', style: GoogleFonts.poppins(fontSize: 20)),
                      LabelledTextField(
                        label: "Sales (Oct)",
                        hintText: "Enter sales",
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('November', style: GoogleFonts.poppins(fontSize: 20)),
                      LabelledTextField(
                        label: "Sales (Nov)",
                        hintText: "Enter sales",
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('December', style: GoogleFonts.poppins(fontSize: 20)),
                      LabelledTextField(
                        label: "Sales (Dec)",
                        hintText: "Enter sales",
                        controller: TextEditingController(),
                      ),
                    ],
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
    );
  }
}
