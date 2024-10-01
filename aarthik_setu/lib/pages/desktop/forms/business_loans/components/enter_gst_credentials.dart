import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/date_picker.dart';
import 'package:aarthik_setu/global_components/procees_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../bloc/l10n/l10n_bloc.dart';
import '../../../../../constants/colors.dart';
import '../../../../../global_components/labelled_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BusinessInputUnit {
  final TextEditingController gstNumberController;
  final TextEditingController gstUsernameController;
  final TextEditingController cityController;
  final TextEditingController totalPurchaseController;
  final TextEditingController totalSalesController;
  DateTime? updateOn;

  BusinessInputUnit({
    required this.gstNumberController,
    required this.gstUsernameController,
    required this.cityController,
    required this.totalPurchaseController,
    required this.totalSalesController,
    this.updateOn,
  });
}

class EnterGSTCredentials extends StatefulWidget {
  const EnterGSTCredentials({super.key});

  @override
  State<EnterGSTCredentials> createState() => _EnterGSTCredentialsState();
}

class _EnterGSTCredentialsState extends State<EnterGSTCredentials> {
  List<BusinessInputUnit> businesses = [];
  int? currentBusinessIndex;

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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                  for (int i = 0; i < businesses.length; i++) ...[
                    SizedBox(
                      width: 250,
                      height: 100,
                      child: FilledButton.tonal(
                        onPressed: () {
                          setState(() {
                            currentBusinessIndex = i;
                          });
                        },
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          backgroundColor: WidgetStateProperty.all(AppColors.primaryColorOne.withOpacity(0.6)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.business, color: Colors.black, size: 30),
                            const SizedBox(width: 10),
                            Text("${AppLocalizations.of(context)!.businessButtonLabel}${i + 1}", style: GoogleFonts.poppins(fontSize: 22)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                SizedBox(
                  width: 250,
                  height: 100,
                  child: FilledButton.tonal(
                    onPressed: () {
                      setState(() {
                        businesses.add(BusinessInputUnit(
                          gstNumberController: TextEditingController(),
                          gstUsernameController: TextEditingController(),
                          cityController: TextEditingController(),
                          totalPurchaseController: TextEditingController(),
                          totalSalesController: TextEditingController(),
                        ));
                      });
                    },
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      backgroundColor: WidgetStateProperty.all(AppColors.primaryColorOne.withOpacity(0.6)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add, color: Colors.black, size: 30),
                        const SizedBox(width: 10),
                        Text(AppLocalizations.of(context)!.addBusinessButtonLabel, style: GoogleFonts.poppins(fontSize: 22)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.grey, thickness: 0.5),
          const SizedBox(height: 20),
          if (currentBusinessIndex != null)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LabelledTextField(
                      label: AppLocalizations.of(context)!.gstNumberLabel,
                      hintText: AppLocalizations.of(context)!.gstNumberHint,
                      controller: businesses[currentBusinessIndex!].gstNumberController,
                    ),
                    LabelledTextField(
                      label: AppLocalizations.of(context)!.gstUsernameLabel,
                      hintText: AppLocalizations.of(context)!.gstUsernameHint,
                      controller: businesses[currentBusinessIndex!].gstUsernameController,
                    ),
                    LabelledTextField(
                      label: AppLocalizations.of(context)!.cityLabelGST,
                      hintText: AppLocalizations.of(context)!.cityHint,
                      controller: businesses[currentBusinessIndex!].cityController,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LabelledTextField(
                      label: AppLocalizations.of(context)!.totalPurchaseLabel,
                      hintText: AppLocalizations.of(context)!.totalPurchaseHint,
                      controller: businesses[currentBusinessIndex!].totalPurchaseController,
                    ),
                    LabelledTextField(
                      label: AppLocalizations.of(context)!.totalSalesLabel,
                      hintText: AppLocalizations.of(context)!.totalSalesHint,
                      controller: businesses[currentBusinessIndex!].totalSalesController,
                    ),
                    DatePickerButton(
                      current: businesses[currentBusinessIndex!].updateOn,
                      label: AppLocalizations.of(context)!.updateOnLabel,
                      onDateSelected: (date) {
                        setState(() {
                          businesses[currentBusinessIndex!].updateOn = date;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              businesses.removeAt(currentBusinessIndex!);
                              currentBusinessIndex = null;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(AppColors.primaryColorOne.withOpacity(0.35)),
                            shape:
                                WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          ),
                          icon: const Icon(Icons.delete, color: Colors.red, size: 30)),
                    ),
                  ],
                ),
              ],
            ),
          if (currentBusinessIndex == null)
            Center(child: Text(AppLocalizations.of(context)!.selectBusinessToEdit, style: GoogleFonts.poppins(fontSize: 22))),
          const SizedBox(height: 20),
          const Divider(color: Colors.grey, thickness: 0.5),
          const SizedBox(height: 40),
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
