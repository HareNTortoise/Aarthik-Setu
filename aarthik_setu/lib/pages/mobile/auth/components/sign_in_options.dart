import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../bloc/auth/auth_bloc.dart';
import '../../../../cubit/phone_form_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInOptionsMobile extends StatelessWidget {
  const SignInOptionsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Text(localizations!.signIn, style: GoogleFonts.poppins(fontSize: 40, fontWeight: FontWeight.w400)),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              context.read<AuthBloc>().add(GoogleSignIn());
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minimumSize: const Size(double.infinity, 40),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "lib/assets/google.svg",
                  width: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  localizations.googleSignIn,
                  style: GoogleFonts.jost(fontSize: 26, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () => context.read<PhoneFormCubit>().togglePhoneInput(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minimumSize: const Size(double.infinity, 40),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "lib/assets/phone_sms.svg",
                  width: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  localizations.phoneSignIn,
                  style: GoogleFonts.jost(fontSize: 26, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
