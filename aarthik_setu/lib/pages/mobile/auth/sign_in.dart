import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../constants/app_constants.dart';

class SignInMobile extends StatelessWidget {
  const SignInMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.mobileScaleWidth,
      child: Scaffold(
        body: SizedBox.expand(
          child: Column(
            children: [
              const SizedBox(height: 200),
              Text(
                'Aarthik Setu',
                style: GoogleFonts.poppins(fontSize: 55),
              ),
              const SizedBox(height: 80),
              Container(
                width: 350,
                height: 290,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text('Sign In', style: GoogleFonts.poppins(fontSize: 40, fontWeight: FontWeight.w400)),
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
                              "Google",
                              style: GoogleFonts.jost(fontSize: 26, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton(
                        onPressed: () {},
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
                              "Phone",
                              style: GoogleFonts.jost(fontSize: 26, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
