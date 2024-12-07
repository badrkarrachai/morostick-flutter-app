import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/widgets/app_snackbar.dart';

class FacebookAuthService {
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  Future<String?> getIdToken() async {
    try {
      // Trigger the sign-in flow
      final LoginResult result = await _facebookAuth.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        // Get the access token
        final AccessToken accessToken = result.accessToken!;
        return accessToken.tokenString; // Changed from token to tokenString
      }
      return null;
    } catch (e) {
      showAppSnackbar(
        title: "Error",
        icon: HugeIcons.strokeRoundedCancelCircle,
        color: Colors.red,
        duration: 3,
        description: "Error in the facebook service, please try again later.",
      );
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _facebookAuth.logOut();
    } catch (e) {
      showAppSnackbar(
        title: "Error",
        icon: HugeIcons.strokeRoundedCancelCircle,
        color: Colors.red,
        duration: 3,
        description: "Error in the facebook service, please try again later.",
      );
      rethrow;
    }
  }
}
