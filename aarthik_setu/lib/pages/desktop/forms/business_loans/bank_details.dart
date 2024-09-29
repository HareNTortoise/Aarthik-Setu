import 'package:aarthik_setu/constants/colors.dart';
import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/month_picker.dart';
import 'package:aarthik_setu/global_components/procees_button.dart';
import 'package:aarthik_setu/global_components/year_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../constants/app_constants.dart';
import '../../../../global_components/labelled_text_field.dart';

class BankDetailsInputUnit {
  final TextEditingController bankName;
  DateTime? accountSinceMonth;
  DateTime? accountSinceYear;
  FilePickerResult? bankStatementOne;
  FilePickerResult? bankStatementTwo;
  FilePickerResult? bankStatementThree;

  BankDetailsInputUnit({
    required this.bankName,
    this.accountSinceMonth,
    this.accountSinceYear,
    this.bankStatementOne,
    this.bankStatementTwo,
    this.bankStatementThree,
  });
}

class BankDetailsBusinessForm extends StatefulWidget {
  const BankDetailsBusinessForm({super.key});

  @override
  State<BankDetailsBusinessForm> createState() => _BankDetailsBusinessFormState();
}

class _BankDetailsBusinessFormState extends State<BankDetailsBusinessForm> {
  DropzoneViewController? dropZoneController;
  final List<BankDetailsInputUnit> banks = [];
  int? currentBankIndex;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100.0),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    "Bank Details",
                    style: GoogleFonts.poppins(fontSize: 80),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "You can add up to 3 bank accounts",
                    style: TextStyle(fontSize: 20),
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
                          const Text(
                            "Upload Bank Statement (PDF)",
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              for (int i = 0; i < banks.length; i++) ...[
                                SizedBox(
                                  width: 250,
                                  height: 100,
                                  child: FilledButton.tonal(
                                    onPressed: () {
                                      setState(() {
                                        currentBankIndex = i;
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
                                        const Icon(Icons.monetization_on_outlined, color: Colors.black, size: 30),
                                        const SizedBox(width: 10),
                                        Text("Bank ${i + 1}", style: GoogleFonts.poppins(fontSize: 22)),
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
                                      banks.add(BankDetailsInputUnit(
                                        bankName: TextEditingController(),
                                        accountSinceMonth: null,
                                        accountSinceYear: null,
                                        bankStatementOne: null,
                                        bankStatementTwo: null,
                                        bankStatementThree: null,
                                      ));
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
                                      Text("Add Account", style: GoogleFonts.poppins(fontSize: 22)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Divider(color: Colors.grey, thickness: 0.5),
                          const SizedBox(height: 20),
                          if (currentBankIndex != null) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                LabelledTextField(
                                  label: "Bank Name*",
                                  hintText: "Enter bank name",
                                  controller: banks[currentBankIndex!].bankName,
                                ),
                                MonthPickerButton(
                                  current: banks[currentBankIndex!].accountSinceMonth,
                                  label: "Account Since (Month)*",
                                  onMonthSelected: (DateTime month) {
                                    setState(() {
                                      banks[currentBankIndex!].accountSinceMonth = month;
                                    });
                                  },
                                ),
                                YearPickerButton(
                                  current: banks[currentBankIndex!].accountSinceYear,
                                  label: "Account Since (Year)*",
                                  onYearSelected: (DateTime year) {
                                    setState(() {
                                      banks[currentBankIndex!].accountSinceYear = year;
                                    });
                                  },
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
                                child: Stack(
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
                                            if (banks[currentBankIndex!].bankStatementOne == null) {
                                              banks[currentBankIndex!].bankStatementOne = FilePickerResult(
                                                [PlatformFile(name: name, size: size ?? 0, bytes: data)],
                                              );
                                            } else if (banks[currentBankIndex!].bankStatementTwo == null) {
                                              banks[currentBankIndex!].bankStatementTwo = FilePickerResult(
                                                [PlatformFile(name: name, size: size ?? 0, bytes: data)],
                                              );
                                            } else if (banks[currentBankIndex!].bankStatementThree == null) {
                                              banks[currentBankIndex!].bankStatementThree = FilePickerResult(
                                                [PlatformFile(name: name, size: size ?? 0, bytes: data)],
                                              );
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        "Drag file here",
                                        style: GoogleFonts.poppins(fontSize: 24),
                                      ),
                                    )
                                  ],
                                )),
                          ],
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
