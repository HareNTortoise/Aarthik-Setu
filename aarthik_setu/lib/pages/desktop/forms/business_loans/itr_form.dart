import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:aarthik_setu/pages/desktop/forms/personal_loans/components/itr_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../global_components/language_dropdown.dart';

class ITRFormBusiness extends StatefulWidget {
  const ITRFormBusiness({super.key});

  @override
  State<ITRFormBusiness> createState() => _ITRFormBusinessState();
}

class _ITRFormBusinessState extends State<ITRFormBusiness> {
  int currentYear = DateTime
      .now()
      .year;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Localizations.override(
        context: context,
        locale: (context.watch<L10nBloc>().state as L10n).locale,
        child: BlocBuilder<L10nBloc, L10nState>(
          builder: (context, state) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: SizedBox.expand(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        const LanguageDropdown(),
                        Text(
                          AppLocalizations.of(context)!.itrDetailsTitle,
                          style: GoogleFonts.poppins(fontSize: 80),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context)!.declareFinancialDetails,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 60),
                        const ItrFilePersonal(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
