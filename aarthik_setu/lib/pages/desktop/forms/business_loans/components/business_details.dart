import 'package:flutter/material.dart';
import '../../../../../global_components/labelled_text_field.dart';

class BusinessDetailsForm extends StatelessWidget {
  BusinessDetailsForm({super.key});

  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _sectorNameController = TextEditingController();
  final TextEditingController _subSectorNameController = TextEditingController();
  final TextEditingController _msmeRegistrationController = TextEditingController();
  final TextEditingController _udyogAadharController = TextEditingController();
  final TextEditingController _productDescriptionController = TextEditingController();

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
              "Business details",
              style: TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelledTextField(
                  label: "Industry*",
                  hintText: 'Enter Industry',
                  controller: _industryController,
                ),
                LabelledTextField(
                  label: "Sector Name*",
                  hintText: 'Enter sector name',
                  controller: _sectorNameController,
                ),
                LabelledTextField(
                  label: "Sub Sector Name*",
                  hintText: 'Enter sub sector name',
                  controller: _subSectorNameController,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelledTextField(
                  label: "MSME Registration Number*",
                  hintText: 'Enter MSME Registration Number',
                  controller: _msmeRegistrationController,
                ),
                LabelledTextField(
                  label: "Udyog Aadhar Memorandum No.",
                  hintText: 'Enter Udyog Aadhar Memorandum No.',
                  controller: _udyogAadharController,
                ),
              ],
            ),
            const SizedBox(height: 20),
            LabelledTextField(
              label: "Product/Service Description*",
              hintText: 'Enter Product/Service Description',
              controller: _productDescriptionController,
              width: double.infinity,
              maxLines: 5,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
