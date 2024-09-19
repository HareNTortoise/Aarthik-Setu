import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../constants/colors.dart';
import '../../../../../global_components/labelled_text_field.dart';

class Collateral {
  final TextEditingController collateralType;
  final TextEditingController collateralAmount;

  Collateral({required this.collateralType, required this.collateralAmount});
}

class DeclareCollateralForm extends StatefulWidget {
  const DeclareCollateralForm({super.key});

  @override
  State<DeclareCollateralForm> createState() => _DeclareCollateralFormState();
}

class _DeclareCollateralFormState extends State<DeclareCollateralForm> {
  bool _hasCollateralSecurity = false;

  List<Collateral> _collaterals = [];

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
            Row(
              children: [
                const Text(
                  "Declare Collateral Security",
                  style: TextStyle(fontSize: 26),
                ),
                const Spacer(),
                SizedBox(
                  width: 160,
                  height: 60,
                  child: AnimatedToggleSwitch<bool>.dual(
                    current: _hasCollateralSecurity,
                    first: false,
                    second: true,
                    borderWidth: 6,
                    textBuilder: (index) => index == true
                        ? Text(
                            "Yes",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          )
                        : Text(
                            "No",
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
                    styleBuilder: (index) => index == true
                        ? const ToggleStyle(indicatorColor: Colors.green)
                        : ToggleStyle(indicatorColor: AppColors.primaryColorOne),
                    iconBuilder: (index) => index == true
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
                        _hasCollateralSecurity = value;
                        if (_hasCollateralSecurity) {
                          _collaterals = [
                            Collateral(
                                collateralType: TextEditingController(), collateralAmount: TextEditingController())
                          ];
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_hasCollateralSecurity)
              Column(
                children: [
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey, thickness: 0.5),
                  const SizedBox(height: 20),
                  for (int i = 0; i < _collaterals.length; i++)
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            LabelledTextField(
                              width: 500,
                              label: "Collateral Type",
                              hintText: 'Enter Collateral Type',
                              controller: TextEditingController(),
                            ),
                            const Spacer(),
                            LabelledTextField(
                              label: "Collateral Amount (₹)",
                              hintText: 'Enter Collateral Amount',
                              controller: TextEditingController(),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              height: 70,
                              width: 70,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _collaterals.removeAt(i);
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
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 60,
                      width: 300,
                      child: FilledButton.tonal(
                        onPressed: () {
                          setState(() {
                            _collaterals.add(
                              Collateral(
                                collateralType: TextEditingController(),
                                collateralAmount: TextEditingController(),
                              ),
                            );
                          });
                        },
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            SizedBox(width: 10),
                            Text(
                              "Add Collateral",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
