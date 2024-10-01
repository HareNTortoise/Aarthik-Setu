import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:aarthik_setu/global_components/large_tile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersonalLoanOptions extends StatelessWidget {
  const PersonalLoanOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: (BlocProvider.of<L10nBloc>(context).state as L10n).locale,
      child: BlocBuilder<L10nBloc, L10nState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LargeTileButton(
                title: AppLocalizations.of(context)!.personalLoans,
                icon: const Icon(LineIcons.moneyBill, size: 150),
                description: AppLocalizations.of(context)!.personalLoanDescription,
                onPressed: () => context.go('/personal-loan-journey/personal'),
              ),
              LargeTileButton(
                title: AppLocalizations.of(context)!.homeLoans,
                icon: const Icon(LineIcons.home, size: 150),
                description: AppLocalizations.of(context)!.homeLoanDescription,
                onPressed: () => context.go('/personal-loan-journey/home'),
              ),
              LargeTileButton(
                title: AppLocalizations.of(context)!.autoLoans,
                icon: const Icon(LineIcons.car, size: 150),
                description: AppLocalizations.of(context)!.autoLoanDescription,
                onPressed: () => context.go('/personal-loan-journey/auto'),
              )
            ],
          );
        },
      ),
    );
  }
}
