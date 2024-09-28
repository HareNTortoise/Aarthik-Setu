import 'package:aarthik_setu/global_components/custom_dropdown.dart';
import 'package:aarthik_setu/global_components/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../global_components/back_button.dart';
import '../../../../../global_components/labelled_text_field.dart';
import '../../../../../global_components/procees_button.dart';

class MainPartnerForm extends StatefulWidget {
  const MainPartnerForm({super.key});

  @override
  State<MainPartnerForm> createState() => _MainPartnerFormState();
}

class _MainPartnerFormState extends State<MainPartnerForm> {
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
            Text(
              "Main Partner",
              style: GoogleFonts.poppins(fontSize: 40),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDropdown(
                  label: 'Main Partner',
                  buttonLabel: 'Select Main Partner',
                  labelFontSize: 18,
                  items: [
                  ],
                  onChanged: (_) {},
                ),
                Column(
                  children: [
                    Text(
                      'Owning a House?',
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    CustomSwitch(onChanged: (_) {}, current: true,),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Assessed for Income Tax?',
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    CustomSwitch(onChanged: (_) {}, current: true,),

                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Have Life Insurance?',
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    CustomSwitch(onChanged: (_) {}, current: true,),
                  ],
                ),
                LabelledTextField(
                  label: "Marital Status",
                  hintText: "Enter Marital Status",
                  controller: TextEditingController(),
                ),
                LabelledTextField(
                  label: "Spouse Name",
                  hintText: "Enter Spouse Name",
                  controller: TextEditingController(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelledTextField(
                  label: "No. of Children",
                  hintText: "Enter No. of Children",
                  controller: TextEditingController(),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BackButtonCustom(onPressed: () => context.pop()),
                const SizedBox(width: 40),
                ProceedButtonCustom(onPressed: () {})
              ],
            )
          ],
        ),
      ),
    );
  }
}
