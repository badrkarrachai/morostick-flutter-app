import 'package:flutter/material.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_button.dart';

import '../../../core/routing/routes.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: () async {
        // Mark onboarding as completed
        await getIt<AuthNavigationService>().completeOnboarding();

        // Navigate to login
        if (context.mounted) {
          context.pushNamedAndRemoveAll(Routes.loginScreen);
        }
      },
      textStyle: TextStyles.font16WhiteMedium,
      buttonText: 'Get Started',
    );
  }
}
