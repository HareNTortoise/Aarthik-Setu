import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:aarthik_setu/global_components/language_dropdown.dart';
import 'package:aarthik_setu/pages/desktop/home/components/pending_applications.dart';
import 'package:aarthik_setu/pages/desktop/home/components/personal_loan_options.dart';
import 'package:aarthik_setu/pages/desktop/home/components/select_profile.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../constants/app_constants.dart';
import 'components/business_loan_options.dart';
import 'components/government_schemes.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardDesktop extends StatefulWidget {
  const DashboardDesktop({super.key});

  @override
  State<DashboardDesktop> createState() => _DashboardDesktopState();
}

class _DashboardDesktopState extends State<DashboardDesktop> {
  int _dashboardIndex = 2;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthPending) {
          context.go('/sign-in');
        }
      },
      child: ResponsiveScaledBox(
        width: AppConstants.desktopScaleWidth,
        child: Localizations.override(
          context: context,
          locale: (context.watch<L10nBloc>().state as L10n).locale,
          child: BlocBuilder<L10nBloc, L10nState>(
            builder: (context, state) {
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(AppLocalizations.of(context)!.dashboard,
                              style: GoogleFonts.poppins(fontSize: 85)),
                          const Spacer(),
                          const LanguageDropdown(),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: 220,
                            height: 55,
                            child: FilledButton.tonal(
                              onPressed: () {
                                context.read<AuthBloc>().add(SignOut());
                              },
                              style: ButtonStyle(
                                  padding: WidgetStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10)),
                                  backgroundColor: WidgetStateProperty.all(
                                      Colors.redAccent[100]),
                                  textStyle: WidgetStateProperty.all(
                                      const TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                  shape: WidgetStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))))),
                              child: Text(AppLocalizations.of(context)!.logOut,
                                  style: GoogleFonts.poppins(fontSize: 22)),
                            ),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            onPressed: () {},
                            icon: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[400],
                              child: const Icon(Icons.person),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 850,
                            height: 100,
                            color: Colors.white,
                            child: AnimatedToggleSwitch<int>.size(
                              textDirection: TextDirection.rtl,
                              current: _dashboardIndex,
                              values: const [0, 1, 2],
                              indicatorSize: const Size.fromWidth(330),
                              iconBuilder: (i) {
                                switch (i) {
                                  case 2:
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: AutoSizeText(AppLocalizations.of(context)!.personalLoans,
                                          style:
                                              GoogleFonts.poppins(fontSize: 22),
                                          minFontSize: 16,
                                          maxFontSize: 24,
                                          maxLines: 1),
                                    );
                                  case 1:
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: AutoSizeText(AppLocalizations.of(context)!.businessLoans,
                                          style:
                                              GoogleFonts.poppins(fontSize: 22),
                                          minFontSize: 16,
                                          maxFontSize: 24,
                                          maxLines: 1),
                                    );
                                  case 0:
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: AutoSizeText(AppLocalizations.of(context)!.governmentSchemes,
                                          style:
                                              GoogleFonts.poppins(fontSize: 22),
                                          minFontSize: 16,
                                          maxFontSize: 24,
                                          maxLines: 1),
                                    );
                                  default:
                                    return const Icon(Icons.person);
                                }
                              },
                              borderWidth: 4.0,
                              iconAnimationType: AnimationType.onHover,
                              style: ToggleStyle(
                                borderColor: Colors.transparent,
                                borderRadius: BorderRadius.circular(35.0),
                                boxShadow: [
                                  const BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 1.5),
                                  ),
                                ],
                              ),
                              styleBuilder: (i) =>
                                  ToggleStyle(indicatorColor: Colors.grey[300]),
                              selectedIconScale: 1,
                              onChanged: (i) async {
                                await Future.delayed(
                                    const Duration(milliseconds: 500));
                                setState(() {
                                  _dashboardIndex = i;
                                });
                              },
                              loadingIconBuilder: (i, _) =>
                                  const LoadingIndicator(
                                      indicatorType: Indicator.orbit),
                            ),
                          ),
                          const SizedBox(width: 50),
                          if (_dashboardIndex != 0)
                            SizedBox(
                              height: 100,
                              width: 250,
                              child: FilledButton.tonal(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => const SelectProfile());
                                },
                                style: ButtonStyle(
                                  padding: WidgetStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10)),
                                  backgroundColor: WidgetStateProperty.all(
                                      Colors.greenAccent[100]),
                                  textStyle: WidgetStateProperty.all(
                                      const TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                  shape: WidgetStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(35)))),
                                ),
                                child: AutoSizeText(
                                  AppLocalizations.of(context)!.profile,
                                  style: GoogleFonts.poppins(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          const SizedBox(width: 50),
                          if (_dashboardIndex != 0)
                            SizedBox(
                              height: 100,
                              width: 350,
                              child: FilledButton.tonal(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const PendingApplications());
                                },
                                style: ButtonStyle(
                                  padding: WidgetStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10)),
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.blue[100]),
                                  textStyle: WidgetStateProperty.all(
                                      const TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                  shape: WidgetStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(35)))),
                                ),
                                child: AutoSizeText(
                                  AppLocalizations.of(context)!.pendingApplications,
                                  style: GoogleFonts.poppins(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 100),
                      if (_dashboardIndex == 2) const PersonalLoanOptions(),
                      if (_dashboardIndex == 1) const BusinessLoanOptions(),
                      if (_dashboardIndex == 0) const GovernmentSchemesFinder(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
