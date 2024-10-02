import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:line_icons/line_icons.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../../../constants/colors.dart';
import '../../../../global_components/language_dropdown.dart';
import '../../../../global_components/large_tile_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BusinessLoanJourney extends StatelessWidget {
  const BusinessLoanJourney({super.key});

  @override
  Widget build(BuildContext context) {
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
                        backgroundColor: WidgetStateProperty.all(
                          AppColors.primaryColorTwo.withOpacity(0.6),
                        ),
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
                            AppLocalizations.of(context)!.chooseBusinessProfile,
                            style: GoogleFonts.poppins(fontSize: 26),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AppLocalizations.of(context)!.selectedProfileBusiness,
                            style: GoogleFonts.poppins(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  endChild: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      AppLocalizations.of(context)!.selectProfileDescription,
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
              // ITR Form Step
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
                      AppLocalizations.of(context)!.itrFormDescription,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 26),
                    ),
                  ),
                  endChild: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: LargeTileButton(
                        title: AppLocalizations.of(context)!.itrButtonTitleBusiness,
                        icon: const Icon(LineIcons.piggyBank, size: 150),
                        onPressed: () => context.go('/business-loan-journey/business/itr'),
                        description: AppLocalizations.of(context)!.itrButtonDescriptionBusiness,
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
              // GST Form Step
              SizedBox(
                height: 700,
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
                        title: AppLocalizations.of(context)!.gstButtonTitle,
                        icon: const Icon(LineAwesome.file_invoice_solid, size: 150),
                        onPressed: () => context.go('/business-loan-journey/business/gst-details'),
                        description: AppLocalizations.of(context)!.gstButtonDescription,
                      ),
                    ),
                  ),
                  endChild: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      AppLocalizations.of(context)!.gstFormDescription,
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
              // Bank Details Step
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
                      AppLocalizations.of(context)!.bankDetailsDescription,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 26),
                    ),
                  ),
                  endChild: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: LargeTileButton(
                        title: AppLocalizations.of(context)!.bankButtonTitle,
                        icon: const Icon(LineIcons.university, size: 150),
                        onPressed: () => context.go('/business-loan-journey/business/bank-details'),
                        description: AppLocalizations.of(context)!.bankButtonDescription,
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
              // Stakeholders Step
              SizedBox(
                height: 700,
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
                        title: AppLocalizations.of(context)!.stakeholdersButtonTitle,
                        icon: const Icon(LineIcons.users, size: 150),
                        onPressed: () => context.go('/business-loan-journey/business/stakeholders'),
                        description: AppLocalizations.of(context)!.stakeholdersButtonDescription,
                      ),
                    ),
                  ),
                  endChild: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      AppLocalizations.of(context)!.stakeholdersDescription,
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
              // Loan Form Step
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
                      AppLocalizations.of(context)!.loanFormDescription,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 26),
                    ),
                  ),
                  endChild: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: LargeTileButton(
                        title: AppLocalizations.of(context)!.loanButtonTitle,
                        icon: const Icon(LineIcons.fileContract, size: 150),
                        onPressed: () => context.go('/business-loan-journey/business/loan-form'),
                        description: AppLocalizations.of(context)!.loanButtonDescription,
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
                      onPressed: () => context.go('/business-loan-journey/business/review-form'),
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
