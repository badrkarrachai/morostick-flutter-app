import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/routing/routes.dart';
import 'package:morostick/core/theming/text_styles.dart';

class HaveAccountLoginText extends StatelessWidget {
  const HaveAccountLoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account?',
              style: TextStyles.font13GrayPurpleRegular,
            ),
            TextSpan(
              text: ' Login',
              style: TextStyles.font13PurpleSemiBold,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.pushNamedAndRemoveAll(Routes.loginScreen);
                },
            ),
          ],
        ),
      ),
    );
  }
}
