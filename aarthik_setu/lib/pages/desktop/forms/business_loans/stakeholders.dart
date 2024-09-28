import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:aarthik_setu/global_components/labelled_text_field.dart';
import 'package:aarthik_setu/global_components/month_picker.dart';
import 'package:aarthik_setu/pages/desktop/forms/business_loans/components/add_stakeholders.dart';
import 'package:aarthik_setu/pages/desktop/forms/business_loans/components/main_partner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../global_components/year_picker.dart';

class StakeholdersForm extends StatefulWidget {
  const StakeholdersForm({super.key});

  @override
  State<StakeholdersForm> createState() => _StakeholdersFormState();
}

class _StakeholdersFormState extends State<StakeholdersForm> {
  int currentYear = DateTime.now().year;

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
                    "Declare Business Stakeholders",
                    style: GoogleFonts.poppins(fontSize: 80),
                  ),
                  const SizedBox(height: 60),
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
                        children: [
                          Text(
                            "Business details",
                            style: GoogleFonts.poppins(fontSize: 40),
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
                                label: 'Street',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LabelledTextField(
                                label: 'Village',
                                hintText: 'Enter village',
                                controller: TextEditingController(),
                              ),
                              MonthPickerButton(
                                label: 'Month',
                                onMonthSelected: (month) {},
                              ),
                              YearPickerButton(
                                label: 'Year',
                                onYearSelected: (year) {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const AddStakeholders(),
                  const MainPartnerForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
