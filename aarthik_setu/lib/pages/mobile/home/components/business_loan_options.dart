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
          return Column( // Use Column for mobile layout
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LargeTileButton(
                title: AppLocalizations.of(context)!.msmeLoans,
                icon: const Icon(LineIcons.industry, size: 80), // Reduced icon size for mobile
                description: AppLocalizations.of(context)!.msmeLoanDescription,
                onPressed: () => context.go('/business-loan-journey/msme'),
              ),
              const SizedBox(height: 20), // Add spacing between tiles
              LargeTileButton(
                title: AppLocalizations.of(context)!.termLoans,
                icon: const Icon(LineIcons.handshake, size: 80), // Reduced icon size
                description: AppLocalizations.of(context)!.termLoanDescription,
                onPressed: () => context.go('/business-loan-journey/term'),
              ),
              const SizedBox(height: 20), // Add spacing between tiles
              LargeTileButton(
                title: AppLocalizations.of(context)!.mudraLoans,
                icon: const Icon(LineIcons.piggyBank, size: 80), // Reduced icon size
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
