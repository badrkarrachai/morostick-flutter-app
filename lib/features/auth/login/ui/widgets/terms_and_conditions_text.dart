import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:morostick/core/routing/routes.dart';
import 'package:morostick/core/theming/text_styles.dart';

class TermsAndConditionsText extends StatelessWidget {
  final String action;
  const TermsAndConditionsText({super.key, this.action = "logging"});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'By $action, you agree to our',
            style: TextStyles.font13GrayPurpleRegular,
          ),
          TextSpan(
            text: ' Terms & Conditions',
            style: TextStyles.font13DarkPurpleMedium,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, Routes.webviewScreen, arguments: {
                  'url': 'https://www.google.com',
                  'title': 'Terms & Conditions'
                });
              },
          ),
          TextSpan(
            text: ' and',
            style: TextStyles.font13GrayPurpleRegular.copyWith(height: 1.5),
          ),
          TextSpan(
            text: ' Privacy Policy',
            style: TextStyles.font13DarkPurpleMedium,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, Routes.webviewScreen, arguments: {
                  'url': 'https://www.facebook.com',
                  'title': 'Privacy Policy'
                });
              },
          ),
        ],
      ),
    );
  }
}
