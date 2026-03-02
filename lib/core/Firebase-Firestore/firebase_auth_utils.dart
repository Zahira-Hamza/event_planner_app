import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthUtils {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Handles Login logic
  static Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Handles Registration logic
  static Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Signs out the user
  static Future<void> logout() async {
    await _auth.signOut();
  }

  /// Get current user UID or data
  static User? getCurrentUser() => _auth.currentUser;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      // 1. Initialize the Google Sign-In process
      await _googleSignIn.initialize(
        serverClientId: dotenv.env['SERVER_CLIENT_ID'] ?? '',
      );

      // 2. Trigger the authentication flow
      final GoogleSignInAccount? result = await _googleSignIn.authenticate();
      if (result == null) return null; // User cancelled the sign-in

      // 3. Obtain auth details from the request
      final GoogleSignInAuthentication googleAuth = await result.authentication;

      // 4. Create a new credential for Firebase
      final OAuthCredential credentials = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // 5. Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credentials);
    } catch (e) {
      print('Google sign-in error $e');
      return null;
    }
  }
}
