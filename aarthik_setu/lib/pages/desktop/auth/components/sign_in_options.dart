import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../bloc/auth/auth_bloc.dart';
import '../../../../cubit/phone_form_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInOptionsDesktop extends StatelessWidget {
  const SignInOptionsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            localizations!.signIn, // Use localized string
            style: GoogleFonts.poppins(fontSize: 70, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 80),
          OutlinedButton(
            onPressed: () {
              context.read<AuthBloc>().add(GoogleSignIn());
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minimumSize: const Size(double.infinity, 80),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "lib/assets/google.svg",
                  width: 35,
                ),
                const SizedBox(width: 10),
                Text(
                  localizations.googleSignIn, // Use localized string
                  style: GoogleFonts.jost(fontSize: 30, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          OutlinedButton(
            onPressed: () => context.read<PhoneFormCubit>().togglePhoneInput(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minimumSize: const Size(double.infinity, 80),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "lib/assets/phone_sms.svg",
                  width: 35,
                ),
                const SizedBox(width: 10),
                Text(
                  localizations.phoneSignIn, // Use localized string
                  style: GoogleFonts.jost(fontSize: 30, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
