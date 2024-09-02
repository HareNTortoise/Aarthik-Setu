import 'package:aarthik_setu/services/auth/google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleAuth googleAuthServices;
  final _logger = Logger();

  AuthBloc({required this.googleAuthServices}) : super(AuthInitial()) {
    on<GoogleSignIn>((event, emit) {
      emit(AuthLoading());
      try {
        final response = googleAuthServices.signInGoogle();
        _logger.i(response);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
