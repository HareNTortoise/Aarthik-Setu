import 'package:aarthik_setu/constants/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import '../../constants/app_constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PhoneAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final logger = Logger();
  String? phoneNumber;
  late String _verificationId;
  ConfirmationResult? _confirmationResult;  // For web

  Future signInOTP(String countryCode, String phoneNumber) async {
    this.phoneNumber = phoneNumber;

    try {
      // Check if the platform is web or mobile (Android/iOS)
      if (!kIsWeb) {
        // Native platforms: Android, iOS
        await _auth.verifyPhoneNumber(
          phoneNumber: countryCode + phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException exception) =>
              logger.w('${Messages.signInFailedPhoneVerification} ${exception.message}'),
          codeSent: (String verificationId, int? resendToken) {
            logger.i('${Messages.signInPhoneOTPSent} ${countryCode + phoneNumber}');
            _verificationId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            logger.w('${Messages.signInPhoneOTPTimeout} ${countryCode + phoneNumber}');
          },
          timeout: AppConstants.otpTimeOutDuration,
        );
      } else {
        _confirmationResult = await _auth.signInWithPhoneNumber(countryCode + phoneNumber);
        logger.i('${Messages.signInPhoneOTPSent} ${countryCode + phoneNumber}');
      }
    } catch (e) {
      logger.e(Messages.signInFailedPhoneVerification);
    }
  }

  Future<Map<String, dynamic>?> verifyOTP(String otp) async {
    try {
      if (!kIsWeb) {
        // Native platforms
        final PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: otp,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(credential);

        if (userCredential.user != null) {
          logger.i('${Messages.signInSuccessPhone} $phoneNumber');
          return {'phoneNumber': phoneNumber ?? ''};
        }
      } else {
        // Web platform
        if (_confirmationResult != null) {
          UserCredential userCredential = await _confirmationResult!.confirm(otp);
          if (userCredential.user != null) {
            logger.i('${Messages.signInSuccessPhone} $phoneNumber');
            return {'phoneNumber': phoneNumber ?? ''};
          }
        }
      }

      logger.w('${Messages.signInFailedPhoneVerification} $phoneNumber');
      return null;
    } catch (e) {
      logger.w('${Messages.signInFailedPhoneVerification} $phoneNumber');
      return null;
    }
  }
}
