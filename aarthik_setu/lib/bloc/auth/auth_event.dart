part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class GoogleSignIn extends AuthEvent {}

class OTPSignIn extends AuthEvent {
  final String countryCode;
  final String phoneNumber;

  OTPSignIn({required this.countryCode, required this.phoneNumber});
}

class OTPVerify extends AuthEvent {
  final String otp;

  OTPVerify({required this.otp});
}