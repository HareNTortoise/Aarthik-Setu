import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:aarthik_setu/cubit/phone_form_cubit.dart';
import 'package:aarthik_setu/pages/desktop/auth/components/phone_number_form.dart';
import 'package:aarthik_setu/pages/desktop/auth/components/sign_in_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
                child: BlocBuilder<PhoneFormCubit, PhoneFormState>(
                  builder: (context, state) {
                    return Container(
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
                      child:  (state as PhoneForm).isPhoneInputOpen
                          ? const PhoneNumberFormDesktop(
                      )
                          : SignInOptionsDesktop(
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
