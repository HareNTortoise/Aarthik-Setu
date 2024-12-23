import 'dart:async';
import 'package:aarthik_setu/global_components/country_code_dropdown.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../../../cubit/phone_form_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneNumberFormMobile extends StatefulWidget {
  const PhoneNumberFormMobile({super.key});

  @override
  State<PhoneNumberFormMobile> createState() => _PhoneNumberFormMobileState();
}

class _PhoneNumberFormMobileState extends State<PhoneNumberFormMobile> {
  String _selectedCountryCode = '+91';
  final TextEditingController _phoneController = TextEditingController();
  bool _isVerifyButtonEnabled = true;
  Timer? _timer;
  int _start = 120;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void startOtpTimer() {
    setState(() {
      _start = 120;
      _isVerifyButtonEnabled = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        setState(() {
          _isVerifyButtonEnabled = false;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.read<PhoneFormCubit>().togglePhoneInput();
                    if ((context.read<PhoneFormCubit>().state as PhoneForm).isOTPSent) {
                      context.read<PhoneFormCubit>().toggleOTPSent();
                    }
                  },
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 230,
                height: 50,
                child: Center(
                  child: AutoSizeText(
                    localizations!.phoneSignInFormTitle,
                    style: GoogleFonts.poppins(fontSize: 21, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Form(
            key: _formKey,
            child: Column(
              children: [
                BlocBuilder<PhoneFormCubit, PhoneFormState>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: _phoneController,
                      enabled: !(state as PhoneForm).isOTPSent,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localizations.enterPhoneNumber;
                        }
                        if (value.length < 10) {
                          return localizations.enterValidPhoneNumber;
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        labelText: localizations.phoneNumber,
                        labelStyle: GoogleFonts.poppins(fontSize: 20),
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        constraints: const BoxConstraints(maxWidth: 400),
                        contentPadding: const EdgeInsets.symmetric(vertical: 20),
                        prefixIcon: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: CountryCodeDropdown(
                              enabled: false,
                              selectedCountryCode: _selectedCountryCode,
                              onChanged: (value) {
                                setState(() {
                                  _selectedCountryCode = value!;
                                });
                              }),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                BlocBuilder<PhoneFormCubit, PhoneFormState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        if (!(state as PhoneForm).isOTPSent)
                          FilledButton.tonal(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<PhoneFormCubit>().toggleOTPSent();
                                _timer?.cancel();
                                startOtpTimer();
                              }
                            },
                            style: ButtonStyle(
                              minimumSize: WidgetStateProperty.all(const Size(100, 50)),
                            ),
                            child: Text(localizations.sendOtp),
                          ),
                        if (state.isOTPSent) ...[
                          Text(localizations.enterOtp, style: const TextStyle(fontSize: 22)),
                          const SizedBox(height: 10),
                          Text(localizations.otpExpireIn(_start), style: GoogleFonts.poppins(fontSize: 16)),
                          const SizedBox(height: 40),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            child: OTPTextField(
                              length: 5,
                              width: MediaQuery.of(context).size.width,
                              fieldWidth: 50,
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              ],
                              style: const TextStyle(fontSize: 17),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.box,
                              onCompleted: (otp) {
                                Logger().i(localizations.otpReceived);
                              },
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: 130,
                                child: FilledButton.tonal(
                                  onPressed: () {
                                    _timer?.cancel();
                                    startOtpTimer();
                                    // // context.read<PhoneFormCubit>().sendOtp(_phoneController.text);
                                    //context.read<PhoneFormCubit>().toggleOTPSent();
                                  },
                                  style: ButtonStyle(
                                    minimumSize: WidgetStateProperty.all(const Size(100, 50)),
                                  ),
                                  child: Text(localizations.resendOtp),
                                ),
                              ),
                              SizedBox(
                                width: 130,
                                child: FilledButton.tonal(
                                  onPressed: _isVerifyButtonEnabled ? () {} : null,
                                  style: ButtonStyle(
                                    minimumSize: WidgetStateProperty.all(const Size(100, 50)),
                                  ),
                                  child: Text(localizations.verifyOtp),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
