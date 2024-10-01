import 'package:aarthik_setu/constants/form_constants.dart';
import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/date_picker.dart';
import 'package:aarthik_setu/global_components/procees_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../bloc/l10n/l10n_bloc.dart';
import '../../../../../global_components/custom_dropdown.dart';
import '../../../../../global_components/labelled_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return Localizations.override(
      context: context,
      locale: (context.watch<L10nBloc>().state as L10n).locale,
      child: BlocBuilder<L10nBloc, L10nState>(
        builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.declareBusinessLabel,
            style: const TextStyle(fontSize: 30),
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
                      label: AppLocalizations.of(context)!.businessNameLabel,
                      hintText: AppLocalizations.of(context)!.businessNameHint,
                      controller: _businessNameController,
                    ),
                    DatePickerButton(
                      label: AppLocalizations.of(context)!.dateOfIncorporationLabel,
                      onDateSelected: (date) {
                        setState(() {
                          _incorporationDate = date;
                        });
                      },
                    ),
                    LabelledTextField(
                      label: AppLocalizations.of(context)!.constitutionLabel,
                      hintText: AppLocalizations.of(context)!.constitutionHint,
                      controller: _constitutionController,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDropdown(
                      label: AppLocalizations.of(context)!.stateLabel,
                      buttonLabel: _state ?? AppLocalizations.of(context)!.statePlaceholder,
                      items: IndiaStates.getAllStatesAndUTs(),
                      onChanged: (value) {
                        setState(() {
                          _state = value;
                        });
                      },
                    ),
                    CustomDropdown(
                      label: AppLocalizations.of(context)!.cityLabel,
                      buttonLabel: _city ?? AppLocalizations.of(context)!.cityPlaceholder,
                      items: IndiaCities.citiesMap[_state] ?? [],
                      onChanged: (value) {
                        setState(() {
                          _city = value;
                        });
                      },
                    ),
                    LabelledTextField(
                      label: AppLocalizations.of(context)!.customersLabel,
                      hintText: AppLocalizations.of(context)!.customersHint,
                      controller: _customersController,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LabelledTextField(
                      label: AppLocalizations.of(context)!.panLabel,
                      hintText: AppLocalizations.of(context)!.panHint,
                      controller: _panController,
                    ),
                    LabelledTextField(
                      label: AppLocalizations.of(context)!.highestSaleLabel,
                      hintText: AppLocalizations.of(context)!.highestSaleHint,
                      controller: _highestSaleController,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.grey, thickness: 0.5),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.lastYearsSalesLabel,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.januaryLabel, style: GoogleFonts.poppins(fontSize: 20)),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.januarySalesLabel,
                          hintText: AppLocalizations.of(context)!.salesHint,
                          controller: _januarySalesController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.februaryLabel, style: GoogleFonts.poppins(fontSize: 20)),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.februarySalesLabel,
                          hintText: AppLocalizations.of(context)!.salesHint,
                          controller: _februarySalesController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.marchLabel, style: GoogleFonts.poppins(fontSize: 20)),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.marchSalesLabel,
                          hintText: AppLocalizations.of(context)!.salesHint,
                          controller: _marchSalesController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.aprilLabel, style: GoogleFonts.poppins(fontSize: 20)),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.aprilSalesLabel,
                          hintText: AppLocalizations.of(context)!.salesHint,
                          controller: _aprilSalesController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.mayLabel, style: GoogleFonts.poppins(fontSize: 20)),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.maySalesLabel,
                          hintText: AppLocalizations.of(context)!.salesHint,
                          controller: _maySalesController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.juneLabel, style: GoogleFonts.poppins(fontSize: 20)),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.juneSalesLabel,
                          hintText: AppLocalizations.of(context)!.salesHint,
                          controller: _juneSalesController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.julyLabel, style: GoogleFonts.poppins(fontSize: 20)),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.julySalesLabel,
                          hintText: AppLocalizations.of(context)!.salesHint,
                          controller: _julySalesController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.augustLabel, style: GoogleFonts.poppins(fontSize: 20)),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.augustSalesLabel,
                          hintText: AppLocalizations.of(context)!.salesHint,
                          controller: _augustSalesController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.septemberLabel, style: GoogleFonts.poppins(fontSize: 20)),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.septemberSalesLabel,
                          hintText: AppLocalizations.of(context)!.salesHint,
                          controller: _septemberSalesController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.octoberLabel, style: GoogleFonts.poppins(fontSize: 20)),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.octoberSalesLabel,
                          hintText: AppLocalizations.of(context)!.salesHint,
                          controller: _octoberSalesController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.novemberLabel, style: GoogleFonts.poppins(fontSize: 20)),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.novemberSalesLabel,
                          hintText: AppLocalizations.of(context)!.salesHint,
                          controller: _novemberSalesController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.decemberLabel, style: GoogleFonts.poppins(fontSize: 20)),
                        LabelledTextField(
                          label: AppLocalizations.of(context)!.decemberSalesLabel,
                          hintText: AppLocalizations.of(context)!.salesHint,
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
        },
      ),
    );
  }
}
