import 'package:aarthik_setu/pages/mobile/auth/components/phone_number_form.dart';
import 'package:aarthik_setu/pages/mobile/auth/components/sign_in_options.dart';
import 'package:aarthik_setu/pages/mobile/auth/cubit/phone_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../constants/app_constants.dart';

class SignInMobile extends StatefulWidget {
  const SignInMobile({super.key});

  @override
  State<SignInMobile> createState() => _SignInMobileState();
}

class _SignInMobileState extends State<SignInMobile> {

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.mobileScaleWidth,
      child: Scaffold(
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 200),
                Text(
                  'Aarthik Setu',
                  style: GoogleFonts.poppins(fontSize: 55),
                ),
                const SizedBox(height: 80),
                BlocBuilder<PhoneFormCubit, PhoneFormState>(
                  builder: (context, state) {
                    return Container(
                      width: 350,
                      height: (state) {
                        if ((state as PhoneForm).isPhoneInputOpen && !(state).isOTPSent) {
                         return 320.0;
                        }
                        else if ((state).isOTPSent) {
                          return 500.0;
                        }
                        return 290.0;
                      }(state),
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
                      child: (state as PhoneForm).isPhoneInputOpen
                          ? PhoneNumberFormMobile(
                        goBack: () {
                          context.read<PhoneFormCubit>().togglePhoneInput();
                          if ((state).isOTPSent) {
                            context.read<PhoneFormCubit>().toggleOTPSent();
                          }
                        },
                      )
                          : SignInOptionsMobile(
                        onPhoneSignIn: () {
                          context.read<PhoneFormCubit>().togglePhoneInput();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
