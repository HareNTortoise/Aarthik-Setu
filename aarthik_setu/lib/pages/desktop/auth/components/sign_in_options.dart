import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../bloc/auth/auth_bloc.dart';

class SignInOptions extends StatelessWidget {
  const SignInOptions({super.key, required this.onPhoneSignIn});

  final VoidCallback? onPhoneSignIn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text('Sign In', style: GoogleFonts.poppins(fontSize: 70, fontWeight: FontWeight.w400)),
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
                  "Google",
                  style: GoogleFonts.jost(fontSize: 30, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          OutlinedButton(
            onPressed: onPhoneSignIn,
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
                  "Phone",
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
