import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../global_components/labelled_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return Localizations.override(
      context: context,
      locale: (context.watch<L10nBloc>().state as L10n).locale,
      child: BlocBuilder<L10nBloc, L10nState>(
        builder: (context, state) {
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
                  Text(
                    AppLocalizations.of(context)!.business_details,
                    style: const TextStyle(fontSize: 26),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey, thickness: 0.5),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelledTextField(
                        label: AppLocalizations.of(context)!.industry,
                        hintText: AppLocalizations.of(context)!.industry_hint,
                        controller: _industryController,
                      ),
                      LabelledTextField(
                        label: AppLocalizations.of(context)!.sector_name,
                        hintText: AppLocalizations.of(context)!.sector_name_hint,
                        controller: _sectorNameController,
                      ),
                      LabelledTextField(
                        label: AppLocalizations.of(context)!.sub_sector_name,
                        hintText: AppLocalizations.of(context)!.sub_sector_name_hint,
                        controller: _subSectorNameController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelledTextField(
                        label: AppLocalizations.of(context)!.msme_registration_number,
                        hintText: AppLocalizations.of(context)!.msme_registration_number_hint,
                        controller: _msmeRegistrationController,
                      ),
                      LabelledTextField(
                        label: AppLocalizations.of(context)!.udyog_aadhar_memorandum_no,
                        hintText: AppLocalizations.of(context)!.udyog_aadhar_memorandum_no_hint,
                        controller: _udyogAadharController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LabelledTextField(
                    label: AppLocalizations.of(context)!.product_service_description,
                    hintText: AppLocalizations.of(context)!.product_service_description_hint,
                    controller: _productDescriptionController,
                    width: double.infinity,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
