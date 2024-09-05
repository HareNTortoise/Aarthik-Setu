import 'package:aarthik_setu/services/auth/google.dart';
import 'package:aarthik_setu/services/auth/phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleAuth googleAuthServices;
  final PhoneAuth phoneAuthServices;
  final _logger = Logger();

  AuthBloc({required this.googleAuthServices, required this.phoneAuthServices}) : super(AuthInitial()) {
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

    on<OTPSignIn>((event, emit) {
      emit(AuthLoading());
      try {
        final response = phoneAuthServices.signInOTP(event.countryCode, event.phoneNumber);
        _logger.i(response);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<OTPVerify>((event, emit) {
      emit(AuthLoading());
      try {
        final response = phoneAuthServices.verifyOTP(event.otp);
        _logger.i(response);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
