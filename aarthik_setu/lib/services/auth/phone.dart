import 'package:aarthik_setu/constants/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import '../../constants/app_constants.dart';


class OTPAuthenticate {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final logger = Logger();
  String? phoneNumber;
  late String _verificationId;


  Future signInOTP(String countryCode, String phoneNumber) async {
    this.phoneNumber = phoneNumber;
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: countryCode + phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async => await _auth.signInWithCredential(credential),
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
    } catch (e) {
      logger.e(Messages.signInFailedPhoneVerification);
    }
  }

  Future<Map<String, dynamic>?> verifyOTP(String otp) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        logger.i('${Messages.signInSuccessPhone} $phoneNumber');
        final Map<String, dynamic> response = {};
        response['phoneNumber'] = phoneNumber ?? '';
        return response;
      } else {
        logger.w('${Messages.signInFailedPhoneVerification} $phoneNumber');
        return null;
      }
    } catch (e) {
      logger.w('${Messages.signInFailedPhoneVerification} $phoneNumber');
      return null;
    }
  }
}