import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class GoogleAuth{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Logger _logger = Logger();

  Future<Map<String, dynamic>?> signInGoogle() async {
    GoogleSignIn account = GoogleSignIn(
    );
    final GoogleSignInAccount? user = await account.signIn();

    _logger.i("Signed in with Google: $user");

    // Get the authentication details from the user
    final GoogleSignInAuthentication details = await user!.authentication;
    try {
      // Create a credential object using the Google authentication details
      final credential = GoogleAuthProvider.credential(accessToken: details.accessToken, idToken: details.idToken);

      // Sign-in the user with the credential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      final Map<String, dynamic> userCredentials = {};

      userCredentials['email'] = user.email;
      userCredentials['name'] = user.displayName ?? '';
      // userCredentials['profileImage'] = '';

      // if (user.photoUrl != null) {
      //   String localPath =  await UserProfileManager.storeImage(user.photoUrl!);
      //   userCredentials['profileImage'] = XFile(localPath);
      // }

      // If the user is successfully signed in, log the event and return true
      if (userCredential.user != null) {
        _logger.i(" ${userCredential.user!.email} signed in successfully.");

        return userCredentials;
      } else {
        // If the user sign-in fails, log the event and return false
        _logger.e("Failed to sign in with Google.");
        return null;
      }
    } catch (e) {
      // If an unknown error occurs during sign-in, log the event and return false
      _logger.e("An error occurred during Google sign-in: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    _logger.i("User signed out successfully.");
  }
}