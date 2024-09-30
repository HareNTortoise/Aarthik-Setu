import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:aarthik_setu/constants/colors.dart';
import 'package:aarthik_setu/global_components/procees_button.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../constants/app_constants.dart';
import '../../../../global_components/back_button.dart';
import '../../../../global_components/labelled_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../global_components/language_dropdown.dart';

class BankDetailsPersonalForm extends StatefulWidget {
  const BankDetailsPersonalForm({super.key});

  @override
  State<BankDetailsPersonalForm> createState() => _BankDetailsPersonalFormState();
}

class _BankDetailsPersonalFormState extends State<BankDetailsPersonalForm> {
  List<String> banks = [];
  bool _formOpened = false;
  bool _isSalaryAccount = false;
  DateTime? _selectedYear;
  DateTime? _selectedMonth;
  DropzoneViewController? dropZoneController;
  FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Localizations.override(
        context: context,
        locale: (context.watch<L10nBloc>().state as L10n).locale,
        child: BlocBuilder<L10nBloc, L10nState>(
          builder: (context, state) {
            return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: SizedBox.expand(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const LanguageDropdown(),
                    const SizedBox(height: 60),
                    Text(
                      AppLocalizations.of(context)!.bankDetails,
                      style: GoogleFonts.poppins(fontSize: 80),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!.addUpTo3Accounts,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 40),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              AppLocalizations.of(context)!.uploadBankStatement,
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                for (var i in banks)
                                  Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      i,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                SizedBox(
                                  width: 250,
                                  height: 100,
                                  child: FilledButton.tonal(
                                    onPressed: () {
                                      setState(() {
                                        _formOpened = true;
                                      });
                                    },
                                    style: ButtonStyle(
                                      padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
                                      shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                      backgroundColor:
                                          WidgetStateProperty.all(AppColors.primaryColorOne.withOpacity(0.6)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.add, color: Colors.black, size: 30),
                                        const SizedBox(width: 10),
                                        Text(AppLocalizations.of(context)!.addAccount, style: GoogleFonts.poppins(fontSize: 22)),
                                      ],
                                    ),
                                  ),
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
                                  label: AppLocalizations.of(context)!.bankName,
                                  hintText: AppLocalizations.of(context)!.enterBankName,
                                  controller: TextEditingController(),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.accountSinceMonth,
                                      style: GoogleFonts.poppins(fontSize: 18),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: 250,
                                      height: 60,
                                      child: FilledButton(
                                        onPressed: () async {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  child: Container(
                                                    width: 600,
                                                    height: 600,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    child: SfDateRangePicker(
                                                      onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                                                        setState(() {
                                                          _selectedMonth = args.value;
                                                        });
                                                      },
                                                      selectionTextStyle:
                                                          const TextStyle(color: Colors.black, fontSize: 20),
                                                      allowViewNavigation: false,
                                                      view: DateRangePickerView.year,
                                                      showNavigationArrow: false,
                                                      navigationMode: DateRangePickerNavigationMode.none,
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        style: ButtonStyle(
                                          shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          backgroundColor:
                                              WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.5)),
                                        ),
                                        child: _selectedMonth != null
                                            ? Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.calendar_month, size: 30, color: Colors.black),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "${_selectedMonth!.month}",
                                                    style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.calendar_month, size: 30, color: Colors.black),
                                                  const SizedBox(width: 10),
                                                  Text(AppLocalizations.of(context)!.month,
                                                      style: GoogleFonts.poppins(fontSize: 20, color: Colors.black)),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.accountSinceYear,
                                      style: GoogleFonts.poppins(fontSize: 18),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: 250,
                                      height: 60,
                                      child: FilledButton(
                                        onPressed: () async {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  child: Container(
                                                    width: 600,
                                                    height: 600,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    child: SfDateRangePicker(
                                                      onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                                                        setState(() {
                                                          _selectedYear = args.value;
                                                        });
                                                      },
                                                      selectionTextStyle:
                                                          const TextStyle(color: Colors.black, fontSize: 20),
                                                      allowViewNavigation: false,
                                                      view: DateRangePickerView.decade,
                                                      showNavigationArrow: false,
                                                      navigationMode: DateRangePickerNavigationMode.none,
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        style: ButtonStyle(
                                          shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          backgroundColor:
                                              WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.5)),
                                        ),
                                        child: _selectedYear != null
                                            ? Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.calendar_month, size: 30, color: Colors.black),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "${_selectedYear!.year}",
                                                    style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.calendar_month, size: 30, color: Colors.black),
                                                  const SizedBox(width: 10),
                                                  Text(AppLocalizations.of(context)!.yearButton,
                                                      style: GoogleFonts.poppins(fontSize: 20, color: Colors.black)),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.isSalaryAccount,
                                  style: GoogleFonts.poppins(fontSize: 18),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 160,
                                  height: 60,
                                  child: AnimatedToggleSwitch<bool>.dual(
                                    current: _isSalaryAccount,
                                    first: false,
                                    second: true,
                                    borderWidth: 6,
                                    textBuilder: (index) => index == false
                                        ? Text(
                                      AppLocalizations.of(context)!.yesButton,
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          )
                                        : Text(
                                      AppLocalizations.of(context)!.noButton,
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                    indicatorSize: const Size.fromWidth(50),
                                    style: ToggleStyle(
                                      backgroundColor: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(50),
                                      borderColor: Colors.transparent,
                                      boxShadow: [
                                        const BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(0, 1.5),
                                        ),
                                      ],
                                    ),
                                    styleBuilder: (index) => index == false
                                        ? const ToggleStyle(indicatorColor: Colors.green)
                                        : ToggleStyle(indicatorColor: AppColors.primaryColorOne),
                                    iconBuilder: (index) => index == false
                                        ? const Icon(
                                            Icons.check,
                                            size: 30,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.close,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                    onChanged: (value) {
                                      setState(() {
                                        _isSalaryAccount = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: result == null
                                  ? Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade100,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: DropzoneView(
                                            operation: DragOperation.copy,
                                            cursor: CursorType.grab,
                                            onCreated: (DropzoneViewController ctrl) => dropZoneController = ctrl,
                                            onDrop: (dynamic ev) async {
                                              final data = await dropZoneController?.getFileData(ev);
                                              final size = await dropZoneController?.getFileSize(ev);
                                              final name = 'bank_statement_${DateTime.now().millisecondsSinceEpoch}.pdf';
                                              setState(() {
                                                result = FilePickerResult([
                                                  PlatformFile(
                                                    name: name,
                                                    bytes: data,
                                                    size: size ?? 0,
                                                  )
                                                ]);
                                                Logger().i(result?.files[0].name);
                                              });
                                              Logger().i(result?.files[0].name);
                                            },
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            AppLocalizations.of(context)!.drag_file_here,
                                            style: GoogleFonts.poppins(fontSize: 24),
                                          ),
                                        )
                                      ],
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade100,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              result?.files[0].name ?? "",
                                              style: GoogleFonts.poppins(fontSize: 24),
                                            ),
                                            const SizedBox(width: 20),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  result = null;
                                                });
                                              },
                                              icon: const Icon(Icons.close),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                BackButtonCustom(
                                  onPressed: () => context.pop()
                                ),
                                const SizedBox(width: 40),
                                ProceedButtonCustom(onPressed: () {})
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
          },
        ),
      ),
    );
  }
}
