import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:aarthik_setu/global_components/chatbot.dart';
import 'package:aarthik_setu/global_components/language_dropdown.dart';
import 'package:aarthik_setu/pages/mobile/home/components/pending_applications.dart';
import 'package:aarthik_setu/pages/mobile/home/components/personal_loan_options.dart';
import 'package:aarthik_setu/pages/mobile/home/components/select_profile.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/home/home_bloc.dart';
import '../../../constants/app_constants.dart';
import 'components/business_loan_options.dart';
import 'components/government_schemes.dart';

class DashboardMobile extends StatefulWidget {
  const DashboardMobile({super.key});

  @override
  State<DashboardMobile> createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile> {
  int _dashboardIndex = 2;

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AuthCheck(
      onSuccess: () {
        final String userId =
            (context.read<AuthBloc>().state as AuthSuccess).id;
        context.read<HomeBloc>().add(FetchProfiles(userId));
      },
    ));

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthPending) {
          context.go('/sign-in');
        }
      },
      child: Localizations.override(
        context: context,
        locale: (context.watch<L10nBloc>().state as L10n).locale,
        child: BlocBuilder<L10nBloc, L10nState>(
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  showDialog(
                      context: context, builder: (_) => const CommonChatbot());
                },
                label: Row(
                  children: [
                    Text('ChatBot', style: GoogleFonts.poppins(fontSize: 16)),
                    const SizedBox(width: 5),
                    const Icon(Icons.chat, size: 24),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(AppLocalizations.of(context)!.dashboard,
                            style: GoogleFonts.poppins(fontSize: 40)),
                        const Spacer(),
                        SizedBox(
                          width: 110,
                          height: 40,
                          child: FilledButton.tonal(
                            onPressed: () {
                              context.read<AuthBloc>().add(SignOut());
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  Colors.redAccent[100]),
                              shape: WidgetStateProperty.all(
                                const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            ),

                            child: Text(
                              AppLocalizations.of(context)!.logOut,
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                        height: 40,
                        width: 200,
                        child: LanguageDropdown()),

                    const SizedBox(height: 10),
                    AnimatedToggleSwitch<int>.size(
                      current: _dashboardIndex,
                      values: const [2, 1, 0],
                      indicatorSize: const Size.fromWidth(200),
                      iconBuilder: (i) {
                        switch (i) {
                          case 2:
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: AutoSizeText(
                                  AppLocalizations.of(context)!.personalLoans,
                                  style: GoogleFonts.poppins(fontSize: 16),
                                  minFontSize: 12,
                                  maxFontSize: 18,
                                  maxLines: 1),
                            );
                          case 1:
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: AutoSizeText(
                                  AppLocalizations.of(context)!.businessLoans,
                                  style: GoogleFonts.poppins(fontSize: 16),
                                  minFontSize: 12,
                                  maxFontSize: 18,
                                  maxLines: 1),
                            );
                          case 0:
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: AutoSizeText(
                                  AppLocalizations.of(context)!
                                      .governmentSchemes,
                                  style: GoogleFonts.poppins(fontSize: 16),
                                  minFontSize: 12,
                                  maxFontSize: 18,
                                  maxLines: 1),
                            );
                          default:
                            return const Icon(Icons.person);
                        }
                      },
                      onChanged: (i) async {
                        await Future.delayed(const Duration(milliseconds: 300));
                        setState(() {
                          _dashboardIndex = i;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    if (_dashboardIndex != 0)
                      SizedBox(
                        height: 80,
                        width: 200,
                        child: FilledButton.tonal(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => SelectProfile(
                                    isPersonal: _dashboardIndex == 2));
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                Colors.greenAccent[100]),
                            shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                            ),
                          ),
                          child: AutoSizeText(
                            AppLocalizations.of(context)!.profile,
                            style: GoogleFonts.poppins(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    if (_dashboardIndex != 0)
                      SizedBox(
                        height: 80,
                        width: 200,
                        child: FilledButton.tonal(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    const PendingApplications());
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.blue[100]),
                            shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                            ),
                          ),
                          child: AutoSizeText(
                            AppLocalizations.of(context)!.pendingApplications,
                            style: GoogleFonts.poppins(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    const SizedBox(height: 40),
                    if (_dashboardIndex == 2) const PersonalLoanOptions(),
                    if (_dashboardIndex == 1) const BusinessLoanOptions(),
                    if (_dashboardIndex == 0)
                      SizedBox(
                        height: 400,
                        child: const GovernmentSchemesFinderMobile(),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
