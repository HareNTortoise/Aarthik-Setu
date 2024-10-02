import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:aarthik_setu/global_components/large_tile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:line_icons/line_icons.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../../../constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../global_components/language_dropdown.dart';

class PersonalLoanJourney extends StatelessWidget {
  const PersonalLoanJourney({super.key});

  @override
  Widget build(BuildContext context) {
    final params = GoRouterState.of(context).pathParameters;
    final loanType = params['loanType'];
    return Localizations.override(
      context: context,
      locale: (context.watch<L10nBloc>().state as L10n).locale,
      child: BlocBuilder<L10nBloc, L10nState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const LanguageDropdown(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    alignment: Alignment.topRight,
                  ),
                  SizedBox(
                    height: 400,
                    child: TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.4,
                      isFirst: true,
                      isLast: false,
                      startChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        height: 150,
                        child: FilledButton.tonal(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.6)),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.choosePersonalProfile,
                                style: GoogleFonts.poppins(fontSize: 26),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                AppLocalizations.of(context)!.selectedProfile,
                                style: GoogleFonts.poppins(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      endChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          AppLocalizations.of(context)!.selectProfileMessage,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 26),
                        ),
                      ),
                      indicatorStyle: IndicatorStyle(
                        width: 50,
                        color: Colors.blueAccent,
                        iconStyle: IconStyle(
                          iconData: Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      beforeLineStyle: const LineStyle(
                        color: Colors.blueAccent,
                        thickness: 8,
                      ),
                    ),
                  ),
                  const TimelineDivider(
                    color: Colors.blueAccent,
                    thickness: 8,
                    begin: 0.4,
                    end: 0.6,
                  ),
                  SizedBox(
                    height: 700,
                    child: TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.6,
                      isFirst: false,
                      isLast: false,
                      startChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          AppLocalizations.of(context)!.itrImportance,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 26),
                        ),
                      ),
                      endChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: LargeTileButton(
                            title: AppLocalizations.of(context)!.itrButtonTitle,
                            icon: const Icon(LineAwesome.money_bill_alt, size: 150),
                            onPressed: () => context.go('/personal-loan-journey/$loanType/itr'),
                            description: AppLocalizations.of(context)!.itrButtonDescription,
                          ),
                        ),
                      ),
                      indicatorStyle: IndicatorStyle(
                        width: 50,
                        color: Colors.blueAccent,
                        iconStyle: IconStyle(
                          iconData: Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      beforeLineStyle: const LineStyle(
                        color: Colors.blueAccent,
                        thickness: 8,
                      ),
                    ),
                  ),
                  const TimelineDivider(
                    color: Colors.blueAccent,
                    thickness: 8,
                    begin: 0.4,
                    end: 0.6,
                  ),
                  SizedBox(
                    height: 800,
                    child: TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.4,
                      isFirst: false,
                      isLast: false,
                      startChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: LargeTileButton(
                              title: AppLocalizations.of(context)!.bankDetailsButtonTitle,
                              icon: const Icon(LineAwesome.university_solid, size: 150),
                              onPressed: () => context.go('/personal-loan-journey/$loanType/bank-details'),
                              description: AppLocalizations.of(context)!.bankDetailsButtonDescription),
                        ),
                      ),
                      endChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          AppLocalizations.of(context)!.bankDetailsImportance,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 26),
                        ),
                      ),
                      indicatorStyle: IndicatorStyle(
                        width: 50,
                        color: Colors.blueAccent,
                        iconStyle: IconStyle(
                          iconData: Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      beforeLineStyle: const LineStyle(
                        color: Colors.blueAccent,
                        thickness: 8,
                      ),
                    ),
                  ),
                  const TimelineDivider(
                    color: Colors.blueAccent,
                    thickness: 8,
                    begin: 0.4,
                    end: 0.6,
                  ),
                  SizedBox(
                    height: 800,
                    child: TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.6,
                      isFirst: false,
                      isLast: false,
                      startChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          AppLocalizations.of(context)!.personalDetailsImportance,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 26),
                        ),
                      ),
                      endChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: LargeTileButton(
                            title: AppLocalizations.of(context)!.basicDetailsButtonTitle,
                            icon: const Icon(LineAwesome.user, size: 150),
                            onPressed: () => context.go('/personal-loan-journey/$loanType/basic-details'),
                            description: AppLocalizations.of(context)!.basicDetailsButtonDescription,
                          ),
                        ),
                      ),
                      indicatorStyle: IndicatorStyle(
                        width: 50,
                        color: Colors.blueAccent,
                        iconStyle: IconStyle(
                          iconData: Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      beforeLineStyle: const LineStyle(
                        color: Colors.blueAccent,
                        thickness: 8,
                      ),
                    ),
                  ),
                  const TimelineDivider(
                    color: Colors.blueAccent,
                    thickness: 8,
                    begin: 0.4,
                    end: 0.6,
                  ),
                  SizedBox(
                    height: 800,
                    child: TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.4,
                      isFirst: false,
                      isLast: false,
                      startChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: LargeTileButton(
                            title: AppLocalizations.of(context)!.employmentDetailsButtonTitle,
                            icon: const Icon(LineAwesome.briefcase_solid, size: 150),
                            onPressed: () => context.go('/personal-loan-journey/$loanType/employment-details'),
                            description: AppLocalizations.of(context)!.employmentDetailsButtonDescription,
                          ),
                        ),
                      ),
                      endChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          AppLocalizations.of(context)!.employmentDetailsImportance,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 26),
                        ),
                      ),
                      indicatorStyle: IndicatorStyle(
                        width: 50,
                        color: Colors.blueAccent,
                        iconStyle: IconStyle(
                          iconData: Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      beforeLineStyle: const LineStyle(
                        color: Colors.blueAccent,
                        thickness: 8,
                      ),
                    ),
                  ),
                  const TimelineDivider(
                    color: Colors.blueAccent,
                    thickness: 8,
                    begin: 0.4,
                    end: 0.6,
                  ),
                  SizedBox(
                    height: 800,
                    child: TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.6,
                      isFirst: false,
                      isLast: false,
                      startChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          AppLocalizations.of(context)!.creditInformationImportance,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 26),
                        ),
                      ),
                      endChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: LargeTileButton(
                            title: AppLocalizations.of(context)!.creditInformationButtonTitle,
                            icon: const Icon(LineAwesome.credit_card, size: 150),
                            onPressed: () => context.go('/personal-loan-journey/$loanType/credit-info'),
                            description: AppLocalizations.of(context)!.creditInformationButtonDescription,
                          ),
                        ),
                      ),
                      indicatorStyle: IndicatorStyle(
                        width: 50,
                        color: Colors.blueAccent,
                        iconStyle: IconStyle(
                          iconData: Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      beforeLineStyle: const LineStyle(
                        color: Colors.blueAccent,
                        thickness: 8,
                      ),
                    ),
                  ),
                  const TimelineDivider(
                    color: Colors.blueAccent,
                    thickness: 8,
                    begin: 0.4,
                    end: 0.6,
                  ),
                  SizedBox(
                    height: 800,
                    child: TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.4,
                      isFirst: false,
                      isLast: false,
                      startChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: LargeTileButton(
                            title: AppLocalizations.of(context)!.contactInformationButtonTitle,
                            icon: const Icon(LineIcons.phone, size: 150),
                            onPressed: () => context.go('/personal-loan-journey/$loanType/contact-details'),
                            description: AppLocalizations.of(context)!.contactInformationButtonDescription,
                          ),
                        ),
                      ),
                      endChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          AppLocalizations.of(context)!.contactInformationImportance,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 26),
                        ),
                      ),
                      indicatorStyle: IndicatorStyle(
                        width: 50,
                        color: Colors.blueAccent,
                        iconStyle: IconStyle(
                          iconData: Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      beforeLineStyle: const LineStyle(
                        color: Colors.blueAccent,
                        thickness: 8,
                      ),
                    ),
                  ),
                  const TimelineDivider(
                    color: Colors.blueAccent,
                    thickness: 8,
                    begin: 0.4,
                    end: 0.6,
                  ),
                  SizedBox(
                    height: 800,
                    child: TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.6,
                      isFirst: false,
                      isLast: false,
                      startChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          AppLocalizations.of(context)!.loanFormImportance,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 26),
                        ),
                      ),
                      endChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: LargeTileButton(
                            title: AppLocalizations.of(context)!.loanFormButtonTitle,
                            icon: const Icon(LineAwesome.money_bill_alt, size: 150),
                            onPressed: () => context.go('/personal-loan-journey/$loanType/loan-form'),
                            description: AppLocalizations.of(context)!.loanFormButtonDescription,
                          ),
                        ),
                      ),
                      indicatorStyle: IndicatorStyle(
                        width: 50,
                        color: Colors.blueAccent,
                        iconStyle: IconStyle(
                          iconData: Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      beforeLineStyle: const LineStyle(
                        color: Colors.blueAccent,
                        thickness: 8,
                      ),
                    ),
                  ),
                  const TimelineDivider(
                    color: Colors.blueAccent,
                    thickness: 8,
                    begin: 0.4,
                    end: 0.6,
                  ),
                  SizedBox(
                    height: 800,
                    child: TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.4,
                      isFirst: false,
                      isLast: true,
                      startChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        height: 150,
                        child: FilledButton.tonal(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.6)),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                      onPressed: () => context.go('/personal-loan-journey/personal/review-form'),
                      child: Text(
                        AppLocalizations.of(context)!.reviewFormButton,
                        style: GoogleFonts.poppins(fontSize: 26),
                          ),
                        ),
                      ),
                      endChild: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          AppLocalizations.of(context)!.reviewFormButtonDescription,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 26),
                        ),
                      ),
                      indicatorStyle: IndicatorStyle(
                        width: 50,
                        color: Colors.blueAccent,
                        iconStyle: IconStyle(
                          iconData: Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      beforeLineStyle: const LineStyle(
                        color: Colors.blueAccent,
                        thickness: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
