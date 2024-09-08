import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'phone_form_state.dart';

class PhoneFormCubit extends Cubit<PhoneFormState> {
  PhoneFormCubit() : super(PhoneForm());

  void togglePhoneInput() {
    emit(
        PhoneForm(isPhoneInputOpen: !(state as PhoneForm).isPhoneInputOpen, isOTPSent: (state as PhoneForm).isOTPSent));
  }

  void toggleOTPSent() {
    emit(
        PhoneForm(isPhoneInputOpen: (state as PhoneForm).isPhoneInputOpen, isOTPSent: !(state as PhoneForm).isOTPSent));
  }
}
