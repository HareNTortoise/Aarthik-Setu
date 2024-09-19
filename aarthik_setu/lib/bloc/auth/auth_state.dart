part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class Loading extends AuthState {}

class AuthPending extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;

  AuthSuccess(this.message);
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}
