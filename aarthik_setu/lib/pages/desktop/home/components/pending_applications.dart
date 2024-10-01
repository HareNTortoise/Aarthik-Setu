import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../constants/app_constants.dart';

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
      return ResponsiveScaledBox(
        width: AppConstants.desktopScaleWidth,
        child: Dialog(
          child: SizedBox(
            width: 800,
            height: 800,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(AppLocalizations.of(context)!.pendingApplicationsTitle, style: GoogleFonts.poppins(fontSize: 32)),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  Text(AppLocalizations.of(context)!.noPendingApplications, style: GoogleFonts.poppins(fontSize: 18)),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 100,
                      height: 40,
                      child: FilledButton.tonal(
                        onPressed: () => context.pop(),
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                          backgroundColor: WidgetStateProperty.all(Colors.redAccent[100]),
                          textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 20, color: Colors.white)),
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                        ),
                        child: Text(AppLocalizations.of(context)!.closeButton, style: GoogleFonts.poppins(fontSize: 20)),
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
    );
  }
}
