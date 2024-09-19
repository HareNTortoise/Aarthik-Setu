import 'dart:async';

import 'package:aarthik_setu/services/auth/google.dart';
import 'package:aarthik_setu/services/auth/phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    on<GoogleSignIn>((event, emit) async {
      emit(Loading());
      try {
        Map<String, dynamic>? response  = await googleAuthServices.signInGoogle();
        if (response == null) {
          emit(AuthPending());
          return;
        }
        emit(AuthSuccess('User is logged in. ${response['name']}'));
      } catch (e) {
        Logger().e(e);
        emit(AuthPending());
        return;
      }
    });

    on<AuthCheck>(
      (event, emit) async {
        final userCompleter = Completer<User?>();

        googleAuthServices.getCurrentUser().listen((user) {
          if (user != null) {
            userCompleter.complete(user);
          }
        });

        final user = await userCompleter.future.timeout(const Duration(seconds: 2), onTimeout: () => null);


        if (user != null) {
          emit(AuthSuccess('User is logged in. ${user.displayName}'));
        } else {
          emit(AuthPending());
        }
      },
    );

    on<OTPSignIn>((event, emit) {
      emit(Loading());
      try {
        final response = phoneAuthServices.signInOTP(event.countryCode, event.phoneNumber);
        _logger.i(response);
        emit(AuthSuccess(
            'OTP sent to ${event.countryCode} ${event.phoneNumber}. ${FirebaseAuth.instance.currentUser!.phoneNumber}'));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<OTPVerify>((event, emit) {
      emit(Loading());
      try {
        final response = phoneAuthServices.verifyOTP(event.otp);
        _logger.i(response);
        emit(AuthSuccess('User is logged in. ${FirebaseAuth.instance.currentUser!.phoneNumber}'));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<SignOut>((event, emit) async {
      await googleAuthServices.signOut();
      emit(AuthPending());
    });
  }
}
