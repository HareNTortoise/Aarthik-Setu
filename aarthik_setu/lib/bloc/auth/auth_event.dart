part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class GoogleSignIn extends AuthEvent {}

class OTPSignIn extends AuthEvent {}