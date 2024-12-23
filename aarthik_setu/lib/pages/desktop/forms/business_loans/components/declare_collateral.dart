import 'package:aarthik_setu/global_components/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../bloc/l10n/l10n_bloc.dart';
import '../../../../../constants/colors.dart';
import '../../../../../global_components/labelled_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CollateralInputUnit {
  final TextEditingController collateralType;
  final TextEditingController collateralAmount;

  CollateralInputUnit({required this.collateralType, required this.collateralAmount});
}

class DeclareCollateralForm extends StatefulWidget {
  const DeclareCollateralForm({super.key});

  @override
  State<DeclareCollateralForm> createState() => _DeclareCollateralFormState();
}

class _DeclareCollateralFormState extends State<DeclareCollateralForm> {
  bool _hasCollateralSecurity = false;

  final List<CollateralInputUnit> _collaterals = [];

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
              Row(
                children: [
                  Text(
                  AppLocalizations.of(context)!.declare_collateral_security,
                    style: const TextStyle(fontSize: 26),
                  ),
                  const Spacer(),
                  CustomSwitch(
                    current: _hasCollateralSecurity,
                    onChanged: (value) => setState(() => _hasCollateralSecurity = value),
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
                                label: AppLocalizations.of(context)!.collateral_type,
                                hintText: AppLocalizations.of(context)!.collateral_type_hint,
                                controller: _collaterals[i].collateralType,
                              ),
                              const Spacer(),
                              LabelledTextField(
                                label: AppLocalizations.of(context)!.collateral_amount,
                                hintText: AppLocalizations.of(context)!.collateral_amount_hint,
                                controller: _collaterals[i].collateralAmount,
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
                                CollateralInputUnit(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add),
                              const SizedBox(width: 10),
                              Text(
                                AppLocalizations.of(context)!.add_collateral,
                                style: const TextStyle(fontSize: 20),
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
        },
      ),
    );
  }
}
