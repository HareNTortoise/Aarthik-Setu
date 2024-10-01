import 'package:aarthik_setu/global_components/custom_dropdown.dart';
import 'package:aarthik_setu/global_components/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../bloc/l10n/l10n_bloc.dart';
import '../../../../../global_components/back_button.dart';
import '../../../../../global_components/labelled_text_field.dart';
import '../../../../../global_components/procees_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPartnerForm extends StatefulWidget {
  const MainPartnerForm({super.key});

  @override
  State<MainPartnerForm> createState() => _MainPartnerFormState();
}

class _MainPartnerFormState extends State<MainPartnerForm> {
  String? _mainPartner;
  bool _owningAHouse = false;
  bool _assessedForIncomeTax = false;
  bool _haveLifeInsurance = false;
  final TextEditingController _maritalStatusController = TextEditingController();
  final TextEditingController _spouseNameController = TextEditingController();
  final TextEditingController _noOfChildrenController = TextEditingController();

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
                children: [
                  Text(
                    AppLocalizations.of(context)!.main_partner,
                    style: GoogleFonts.poppins(fontSize: 40),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey, thickness: 0.5),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomDropdown(
                        current: _mainPartner,
                        label: AppLocalizations.of(context)!.main_partner,
                        buttonLabel: AppLocalizations.of(context)!.select_main_partner,
                        labelFontSize: 18,
                        items: [],
                        onChanged: (_) {},
                      ),
                      Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.owning_a_house,
                            style: GoogleFonts.poppins(fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          CustomSwitch(
                            onChanged: (_) {
                              setState(() {
                                _owningAHouse = !_owningAHouse;
                              });
                            },
                            current: _owningAHouse,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.assessed_for_income_tax,
                            style: GoogleFonts.poppins(fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          CustomSwitch(
                            onChanged: (_) {
                              setState(() {
                                _assessedForIncomeTax = !_assessedForIncomeTax;
                              });
                            },
                            current: _assessedForIncomeTax,
                          ),
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
                            AppLocalizations.of(context)!.have_life_insurance,
                            style: GoogleFonts.poppins(fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          CustomSwitch(
                            onChanged: (_) {
                              setState(() {
                                _haveLifeInsurance = !_haveLifeInsurance;
                              });
                            },
                            current: _haveLifeInsurance,
                          ),
                        ],
                      ),
                      LabelledTextField(
                        label: AppLocalizations.of(context)!.marital_status,
                        hintText: AppLocalizations.of(context)!.marital_status_hint,
                        controller: _maritalStatusController,
                      ),
                      LabelledTextField(
                        label: AppLocalizations.of(context)!.spouse_name,
                        hintText: AppLocalizations.of(context)!.spouse_name_hint,
                        controller: _spouseNameController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelledTextField(
                        label: AppLocalizations.of(context)!.no_of_children,
                        hintText: AppLocalizations.of(context)!.no_of_children_hint,
                        controller: _noOfChildrenController,
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
        },
      ),
    );
  }
}
