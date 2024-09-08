part of 'phone_form_cubit.dart';

@immutable
sealed class PhoneFormState {}

final class PhoneForm extends PhoneFormState {
  final bool isPhoneInputOpen;
  final bool isOTPSent;

  PhoneForm({this.isPhoneInputOpen = false, this.isOTPSent = false});
}
