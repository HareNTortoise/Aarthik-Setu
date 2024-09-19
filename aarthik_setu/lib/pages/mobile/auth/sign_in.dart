import 'package:aarthik_setu/pages/mobile/auth/components/phone_number_form.dart';
import 'package:aarthik_setu/pages/mobile/auth/components/sign_in_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../bloc/l10n/l10n_bloc.dart';
import '../../../constants/app_constants.dart';
import '../../../cubit/phone_form_cubit.dart';
import '../../../global_components/language_dropdown.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInMobile extends StatelessWidget {
  const SignInMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return ResponsiveScaledBox(
      width: AppConstants.mobileScaleWidth,
      child: Localizations.override(
        context: context,
        locale: (context.watch<L10nBloc>().state as L10n).locale,
        child: BlocBuilder<L10nBloc, L10nState>(
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        alignment: Alignment.centerLeft,
                        child: const LanguageDropdown(),
                      ),
                      const SizedBox(height: 120),
                      Text(
                        AppLocalizations.of(context)!.appTitle,
                        style: GoogleFonts.poppins(fontSize: 55),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 80),
                      BlocBuilder<PhoneFormCubit, PhoneFormState>(
                        builder: (context, state) {
                          return Container(
                              width: 350,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: IntrinsicHeight(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20, bottom: 40),
                                  child: (state as PhoneForm).isPhoneInputOpen
                                      ? const PhoneNumberFormMobile()
                                      : const SignInOptionsMobile(),
                                ),
                              ));
                        },
                      ),
                    ],
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
