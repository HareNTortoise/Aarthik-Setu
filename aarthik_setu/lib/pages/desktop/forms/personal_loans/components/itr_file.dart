import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:aarthik_setu/global_components/back_button.dart';
import 'package:aarthik_setu/global_components/procees_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../../constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItrFilePersonal extends StatelessWidget {
  const ItrFilePersonal({super.key});

  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;

    return Localizations.override(
      context: context,
      locale: (context.watch<L10nBloc>().state as L10n).locale,
      child: BlocBuilder<L10nBloc, L10nState>(
        builder: (context, state) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        width: double.infinity,
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 7,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.uploadITRTitle,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.fyLabel} ${currentYear - 2}-${currentYear - 1}*",
                      style: GoogleFonts.poppins(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: FilledButton.tonal(
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.5)),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.upload_file, size: 30),
                            const SizedBox(width: 10),
                            Text(AppLocalizations.of(context)!.uploadButton, style: GoogleFonts.poppins(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.fyLabel} ${currentYear - 3}-${currentYear - 2}",
                      style: GoogleFonts.poppins(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: FilledButton.tonal(
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.5)),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.upload_file, size: 30),
                            const SizedBox(width: 10),
                            Text(AppLocalizations.of(context)!.uploadButton, style: GoogleFonts.poppins(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.fyLabel} ${currentYear - 4}-${currentYear - 3}",
                      style: GoogleFonts.poppins(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: FilledButton.tonal(
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all(AppColors.primaryColorTwo.withOpacity(0.5)),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.upload_file, size: 30),
                            const SizedBox(width: 10),
                            Text(AppLocalizations.of(context)!.uploadButton, style: GoogleFonts.poppins(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 65),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.instructionsTitle,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 40),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ResponsiveScaledBox(
                          width: AppConstants.desktopScaleWidth,
                          child: Dialog(
                            child: Container(
                              width: 800,
                              padding: const EdgeInsets.all(40),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.instructionsTitle,
                                    style: GoogleFonts.poppins(fontSize: 30),
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(color: Colors.grey, thickness: 0.5),
                                  const SizedBox(height: 20),
                                  Text(
                                    AppLocalizations.of(context)!.instructionsContent,
                                    style: GoogleFonts.poppins(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(AppColors.primaryColorOne),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(LineIcons.infoCircle, size: 30),
                        const SizedBox(width: 10),
                        Text(AppLocalizations.of(context)!.instructionsButton, style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                BackButtonCustom(onPressed: () => context.pop()),
                const SizedBox(width: 40),
                ProceedButtonCustom(onPressed: () {})
              ],
            ),
          ],
        ),
      );
        },
      ),
    );
  }
}
