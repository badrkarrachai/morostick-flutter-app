import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/widgets/app_snackbar.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  Future<String?> getIdToken() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        return googleAuth.idToken;
      }
      return null;
    } catch (e) {
      showAppSnackbar(
        title: "Error",
        icon: HugeIcons.strokeRoundedCancelCircle,
        color: Colors.red,
        duration: 3,
        description: "Error in the google service. Please try again later.",
      );
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      showAppSnackbar(
        title: "Error",
        icon: HugeIcons.strokeRoundedCancelCircle,
        color: Colors.red,
        duration: 3,
        description: "Error in the google service, please try again later.",
      );
      rethrow;
    }
  }
}
