import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/features/onboarding/widgets/background.dart';
import 'package:morostick/features/onboarding/widgets/get_started_button.dart';
import 'package:morostick/features/onboarding/widgets/messaging_dud_image.dart';
import 'package:morostick/features/onboarding/widgets/title_and_description.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
          child: SafeArea(
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenH,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MessagingDudImage(),
                verticalSpace(30),
                const TitleAndDescription(),
                verticalSpace(40),
                const GetStartedButton(),
              ],
            ),
          ),
        ),
      ))),
    );
  }
}
