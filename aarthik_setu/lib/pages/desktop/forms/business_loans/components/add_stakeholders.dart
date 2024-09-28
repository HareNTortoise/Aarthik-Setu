import 'package:aarthik_setu/global_components/date_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../constants/colors.dart';
import '../../../../../global_components/custom_switch.dart';
import '../../../../../global_components/labelled_text_field.dart';

class AddStakeholders extends StatefulWidget {
  const AddStakeholders({super.key});

  @override
  State<AddStakeholders> createState() => _AddStakeholdersState();
}

class _AddStakeholdersState extends State<AddStakeholders> {
  bool _formVisible = false;
  bool _isGuarantor = false;
  bool _isEditing = false;

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
                    onPressed: () {
                      setState(() {
                        _formVisible = !_formVisible;
                        _isEditing = false;
                      });
                    },
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
                        for (int i = 0; i < 10; i++)
                          DropdownMenuItem(
                            value: i,
                            child: Row(
                              children: [
                                Text("Stakeholder $i", style: GoogleFonts.poppins(fontSize: 18)),
                              ],
                            ),
                          )
                      ],
                      onChanged: (value) {

                        setState(() {
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
            if (_formVisible)
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
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: 'Relationship type',
                        hintText: 'Enter relationship',
                        controller: TextEditingController(),
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
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: 'Middle Name',
                        hintText: 'Enter middle name',
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: 'Last Name',
                        hintText: 'Enter last name',
                        controller: TextEditingController(),
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
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: 'Gender',
                        hintText: 'Enter gender',
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: 'Father Name',
                        hintText: 'Enter father name',
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DatePickerButton(
                        label: 'Date of Birth',
                        onDateSelected: (date) {},
                      ),
                      LabelledTextField(
                        label: 'Mobile Number',
                        hintText: 'Enter mobile number',
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: 'Residence Status',
                        hintText: 'Enter residence status',
                        controller: TextEditingController(),
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
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: 'Education Status',
                        hintText: 'Enter education status',
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: 'Total Experience (years)',
                        hintText: 'Enter total experience',
                        controller: TextEditingController(),
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
                        label: 'Building No.',
                        hintText: 'Enter Building No.',
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: 'Street Name',
                        hintText: 'Enter Street',
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: 'Landmark',
                        hintText: 'Enter Landmark',
                        controller: TextEditingController(),
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
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: 'Country',
                        hintText: 'Enter country',
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: 'State',
                        hintText: 'Enter state',
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelledTextField(
                        label: 'City',
                        hintText: 'Enter city',
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: 'District',
                        hintText: 'Enter district',
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: 'Sub-district',
                        hintText: 'Enter sub-district',
                        controller: TextEditingController(),
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
                        controller: TextEditingController(),
                      ),
                      LabelledTextField(
                        label: 'Phone',
                        hintText: 'Enter phone',
                        controller: TextEditingController(),
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
                        controller: TextEditingController(),
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
                            current: _isGuarantor,
                            first: false,
                            second: true,
                            onChanged: (value) {
                              setState(() {
                                _isGuarantor = value;
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
                          onPressed: () {},
                          child: Text(
                            _isEditing ? "Delete" :"Discard",
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
  }
}
