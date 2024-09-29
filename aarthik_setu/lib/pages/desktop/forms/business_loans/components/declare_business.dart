import 'package:aarthik_setu/constants/form_constants.dart';
import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/date_picker.dart';
import 'package:aarthik_setu/global_components/procees_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../global_components/custom_dropdown.dart';
import '../../../../../global_components/labelled_text_field.dart';

class DeclareBusiness extends StatefulWidget {
  const DeclareBusiness({super.key});

  @override
  State<DeclareBusiness> createState() => _DeclareBusinessState();
}

class _DeclareBusinessState extends State<DeclareBusiness> {
  int currentYear = DateTime.now().year;

  final TextEditingController _businessNameController = TextEditingController();
  DateTime? _incorporationDate;
  final TextEditingController _constitutionController = TextEditingController();

  String? _state;
  String? _city;
  final TextEditingController _customersController = TextEditingController();

  final TextEditingController _panController = TextEditingController();
  final TextEditingController _highestSaleController = TextEditingController();

  final TextEditingController _januarySalesController = TextEditingController();
  final TextEditingController _februarySalesController = TextEditingController();
  final TextEditingController _marchSalesController = TextEditingController();
  final TextEditingController _aprilSalesController = TextEditingController();
  final TextEditingController _maySalesController = TextEditingController();
  final TextEditingController _juneSalesController = TextEditingController();
  final TextEditingController _julySalesController = TextEditingController();
  final TextEditingController _augustSalesController = TextEditingController();
  final TextEditingController _septemberSalesController = TextEditingController();
  final TextEditingController _octoberSalesController = TextEditingController();
  final TextEditingController _novemberSalesController = TextEditingController();
  final TextEditingController _decemberSalesController = TextEditingController();

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
                    controller: _businessNameController,
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
                    controller: _constitutionController,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDropdown(
                    label: "State*",
                    buttonLabel: _state ?? "Select State",
                    items: IndiaStates.getAllStatesAndUTs(),
                    onChanged: (value) {
                      setState(() {
                        _state = value;
                      });
                    },
                  ),
                  CustomDropdown(
                    label: "City*",
                    buttonLabel: _city ?? "Select City",
                    items: IndiaCities.citiesMap[_state] ?? [],
                    onChanged: (value) {
                      setState(() {
                        _city = value;
                      });
                    },
                  ),
                  LabelledTextField(
                    label: "No. of Customers*",
                    hintText: "Enter your number of customers",
                    controller: _customersController,
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
                    controller: _panController,
                  ),
                  LabelledTextField(
                    label: "Highest sale recorded*",
                    hintText: "Enter your highest sale recorded",
                    controller: _highestSaleController,
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
                        controller: _januarySalesController,
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
                        controller: _februarySalesController,
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
                        controller: _marchSalesController,
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
                        controller: _aprilSalesController,
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
                        controller: _maySalesController,
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
                        controller: _juneSalesController,
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
                        controller: _julySalesController,
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
                        controller: _augustSalesController,
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
                        controller: _septemberSalesController,
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
                        controller: _octoberSalesController,
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
                        controller: _novemberSalesController,
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
                        controller: _decemberSalesController,
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
            BackButtonCustom(onPressed: () => context.pop()),
            const SizedBox(width: 40),
            ProceedButtonCustom(onPressed: () {}),
          ],
        )
      ],
    );
  }
}
