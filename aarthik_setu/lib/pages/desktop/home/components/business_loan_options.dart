import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import '../../../../bloc/l10n/l10n_bloc.dart';
import '../../../../global_components/large_tile_button.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BusinessLoanOptions extends StatelessWidget {
  const BusinessLoanOptions({super.key});

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
                title: AppLocalizations.of(context)!.msmeLoans,
                icon: const Icon(LineIcons.industry, size: 150),
                description: AppLocalizations.of(context)!.msmeLoanDescription,
                onPressed: () => context.go('/business-loan-journey/msme'),
              ),
              LargeTileButton(
                title: AppLocalizations.of(context)!.termLoans,
                icon: const Icon(LineIcons.handshake, size: 150),
                description: AppLocalizations.of(context)!.termLoanDescription,
                onPressed: () => context.go('/business-loan-journey/term'),
              ),
              LargeTileButton(
                title: AppLocalizations.of(context)!.mudraLoans,
                icon: const Icon(LineIcons.piggyBank, size: 150),
                description: AppLocalizations.of(context)!.mudraLoanDescription,
                onPressed: () => context.go('/business-loan-journey/mudra'),
              )
            ],
          );
        },
      ),
    );
  }
}
