import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/routing/routes.dart';
import 'package:morostick/core/theming/text_styles.dart';

class RememberYourPassword extends StatelessWidget {
  const RememberYourPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Remember your password?',
            style: TextStyles.font13GrayPurpleRegular,
          ),
          TextSpan(
            text: ' Log in',
            style: TextStyles.font13PurpleSemiBold,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushReplacementNamed(Routes.loginScreen);
              },
          ),
        ],
      ),
    );
  }
}
