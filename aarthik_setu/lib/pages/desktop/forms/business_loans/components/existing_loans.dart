import 'package:flutter/material.dart';
import '../../../../../constants/colors.dart';
import '../../../../../global_components/labelled_text_field.dart';

class ExistingLoans {
  final TextEditingController nameOfLender;
  final TextEditingController sanctionedAmount;
  final TextEditingController outstandingAmount;
  final TextEditingController emiAmount;
  final TextEditingController loanType;
  final TextEditingController collateralAmount;
  final TextEditingController status;

  ExistingLoans({
    required this.nameOfLender,
    required this.sanctionedAmount,
    required this.outstandingAmount,
    required this.emiAmount,
    required this.loanType,
    required this.collateralAmount,
    required this.status,
  });
}

class ExistingLoansForm extends StatefulWidget {
  const ExistingLoansForm({super.key});

  @override
  State<ExistingLoansForm> createState() => _ExistingLoansFormState();
}

class _ExistingLoansFormState extends State<ExistingLoansForm> {

  List<ExistingLoans> _existingLoans = [];


  @override
  Widget build(BuildContext context) {
    return  IntrinsicHeight(
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
              "Existing Loans",
              style: TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 20),
            for (int i = 0; i < _existingLoans.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                margin: const EdgeInsets.only(bottom: 50, top: 20),
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
                        LabelledTextField(
                          label: "Name of Lender*",
                          hintText: 'Enter lender name',
                          controller: _existingLoans[i].nameOfLender,
                        ),
                        LabelledTextField(
                          label: "Sanctioned Amount (₹)*",
                          hintText: 'Enter collateral amount',
                          controller: _existingLoans[i].sanctionedAmount,
                        ),
                        LabelledTextField(
                          label: "Outstanding Amount (₹)*",
                          hintText: 'Enter outstanding amount',
                          controller: _existingLoans[i].outstandingAmount,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabelledTextField(
                          label: "EMI Amount (₹)*",
                          hintText: 'Enter EMI amount',
                          controller: _existingLoans[i].emiAmount,
                        ),
                        LabelledTextField(
                          label: "Loan Type*",
                          hintText: 'Enter loan type',
                          controller: _existingLoans[i].loanType,
                        ),
                        LabelledTextField(
                          label: "Collateral Amount (₹)*",
                          hintText: 'Enter collateral amount',
                          controller: _existingLoans[i].collateralAmount,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabelledTextField(
                          label: "Status*",
                          hintText: 'Enter status',
                          controller: _existingLoans[i].status,
                        ),
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _existingLoans.removeAt(i);
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                WidgetStateProperty.all(AppColors.primaryColorOne.withOpacity(0.35)),
                                shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                              ),
                              icon: const Icon(Icons.delete, color: Colors.red, size: 30)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 60,
                width: 300,
                child: FilledButton.tonal(
                  onPressed: () {
                    setState(() {
                      _existingLoans.add(
                        ExistingLoans(
                          nameOfLender: TextEditingController(),
                          sanctionedAmount: TextEditingController(),
                          outstandingAmount: TextEditingController(),
                          emiAmount: TextEditingController(),
                          loanType: TextEditingController(),
                          collateralAmount: TextEditingController(),
                          status: TextEditingController(),
                        ),
                      );
                    });
                  },
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 10),
                      Text(
                        "Add Existing Loan",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
