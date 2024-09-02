import 'package:aarthik_setu/bloc/auth/auth_bloc.dart';
import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SignInDesktop extends StatelessWidget {
  const SignInDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'Aarthik Setu',
                  style: GoogleFonts.jost(fontSize: 120, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  width: 750,
                  height: 550,
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
                          onPressed: () {},
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
