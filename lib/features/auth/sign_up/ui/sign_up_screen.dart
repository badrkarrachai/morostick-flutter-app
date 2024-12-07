import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_button.dart';
import 'package:morostick/features/auth/login/ui/widgets/terms_and_conditions_text.dart';
import 'package:morostick/features/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:morostick/features/auth/sign_up/ui/widgets/google_facebook_buttons.dart';
import 'package:morostick/features/auth/sign_up/ui/widgets/have_account_login_text.dart';
import 'package:morostick/features/auth/sign_up/ui/widgets/name_email_and_password.dart';
import 'package:morostick/features/auth/sign_up/ui/widgets/sign_up_bloc_listener.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create New Account 🔥',
                      style: TextStyles.font24PurpleBold,
                    ),
                    verticalSpace(8),
                    Text(
                      'We’re thrilled to have you join us. Create your account to get started.',
                      style: TextStyles.font14RegularGray,
                    ),
                    verticalSpace(36),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const NameEmailAndPassword(),
                    verticalSpace(30),
                    AppButton(
                      buttonText: "Create Account",
                      textStyle: TextStyles.font16WhiteSemiBold,
                      onPressed: () {
                        validateThenDoSignup(context);
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    verticalSpace(30),
                    const GooglFacebookButtonsSignUp(),
                    verticalSpace(30),
                    const TermsAndConditionsText(
                      action: "signing up",
                    ),
                    verticalSpace(20),
                    const HaveAccountLoginText(),
                  ],
                ),
                const SignupBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateThenDoSignup(BuildContext context) {
    if (context.read<SignupCubit>().formKey.currentState!.validate()) {
      context.read<SignupCubit>().emitSignupStates();
    }
  }
}
