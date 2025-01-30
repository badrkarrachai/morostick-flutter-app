// google_auth_service.dart
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/userinfo.email',
    ],
  );
  final Logger _logger = Logger();

  Future<String?> getAccessToken() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        _logger.d('Google Sign In successful');
        _logger.d('Access Token: ${googleAuth.accessToken}');
        _logger.d('Access Token: ${googleUser.photoUrl}');

        return googleAuth.accessToken;
      }
      _logger.w('User cancelled the sign-in process');
      return null;
    } on PlatformException catch (e) {
      if (e.code == 'sign_in_failed') {
        _logger.e('Google Sign In Failed: OAuth configuration error', error: e);
      }
      rethrow;
    } catch (e, stackTrace) {
      _logger.e(
        'Unexpected error during Google sign in',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      _logger.i('Google Sign Out successful');
    } catch (e, stackTrace) {
      _logger.e('Google sign out failed', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
