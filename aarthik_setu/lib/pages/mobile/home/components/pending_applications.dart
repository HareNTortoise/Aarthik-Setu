import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PendingApplications extends StatelessWidget {
  const PendingApplications({super.key});

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: (BlocProvider.of<L10nBloc>(context).state as L10n).locale,
      child: BlocBuilder<L10nBloc, L10nState>(
        builder: (context, state) {
          final size = MediaQuery.of(context).size; // To handle mobile screen size
          return Dialog(
            child: SizedBox(
              width: size.width * 0.9, // Adjust width based on mobile screen size
              height: size.height * 0.6, // Adjust height for mobile
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.pendingApplicationsTitle,
                      style: GoogleFonts.poppins(fontSize: 24), // Smaller font size for mobile
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.noPendingApplications,
                      style: GoogleFonts.poppins(fontSize: 16), // Adjust font size
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: size.width * 0.4, // Adjust button width for mobile
                        height: 40,
                        child: FilledButton.tonal(
                          onPressed: () => context.pop(),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.redAccent[100]),
                            shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.closeButton,
                            style: GoogleFonts.poppins(fontSize: 16), // Smaller text for button on mobile
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
