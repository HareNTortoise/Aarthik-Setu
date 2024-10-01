import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:aarthik_setu/global_components/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../global_components/labelled_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoanDetailsForm extends StatefulWidget {
  const LoanDetailsForm({super.key});

  @override
  State<LoanDetailsForm> createState() => _LoanDetailsFormState();
}

class _LoanDetailsFormState extends State<LoanDetailsForm> {
  int currentYear = DateTime.now().year;

  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _promoterContributionController = TextEditingController();
  final TextEditingController _purposeOfLoanController = TextEditingController();

  final TextEditingController _projectedSalesController = TextEditingController();
  bool _isISOCertified = false;
  final TextEditingController _factoryPremiseController = TextEditingController();

  final TextEditingController _projectedKnowHowController = TextEditingController();
  final TextEditingController _competitionController = TextEditingController();

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
                AppLocalizations.of(context)!.loan_detail,
                style: const TextStyle(fontSize: 26),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey, thickness: 0.5),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LabelledTextField(
                    label: AppLocalizations.of(context)!.loan_amount_required,
                    hintText: AppLocalizations.of(context)!.loan_amount_hint,
                    controller: _loanAmountController,
                  ),
                  LabelledTextField(
                    label: AppLocalizations.of(context)!.promoter_contribution,
                    hintText: AppLocalizations.of(context)!.promoter_contribution_hint,
                    controller: _promoterContributionController,
                  ),
                  LabelledTextField(
                    label: AppLocalizations.of(context)!.purpose_of_loan,
                    hintText: AppLocalizations.of(context)!.purpose_of_loan_hint,
                    controller: _purposeOfLoanController,
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
                    label: "${AppLocalizations.of(context)!.projected_sales} $currentYear-${currentYear % 100 + 1}*",
                    hintText: AppLocalizations.of(context)!.projected_sales_hint,
                    controller: _projectedSalesController,
                  ),
                  Text(AppLocalizations.of(context)!.iso_certified, style: GoogleFonts.poppins(fontSize: 20)),
                  CustomSwitch(
                    current: _isISOCertified,
                    onChanged: (value) => setState(() => _isISOCertified = value),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LabelledTextField(
                    label: AppLocalizations.of(context)!.factory_premise,
                    hintText: AppLocalizations.of(context)!.factory_premise_hint,
                    controller: _factoryPremiseController,
                  ),
                  LabelledTextField(
                    label: AppLocalizations.of(context)!.projected_know_how,
                    hintText: AppLocalizations.of(context)!.projected_know_how_hint,
                    controller: _projectedKnowHowController,
                  ),
                  LabelledTextField(
                    label: AppLocalizations.of(context)!.competition,
                    hintText: AppLocalizations.of(context)!.competition_hint,
                    controller: _competitionController,
                  ),
                ],
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
