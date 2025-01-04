import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/routing/routes.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_button.dart';
import 'package:morostick/core/widgets/app_custom_icon_button.dart';
import 'package:morostick/features/auth/login/logic/login_cubit.dart';
import 'package:morostick/features/auth/login/ui/widgets/dont_have_account_text.dart';
import 'package:morostick/features/auth/login/ui/widgets/google_facebook_buttons.dart';
import 'package:morostick/features/auth/login/ui/widgets/login_bloc_listener.dart';
import 'widgets/email_and_password.dart';
import 'widgets/terms_and_conditions_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                Align(
                    alignment: Alignment.topRight,
                    child: AppCustomIconButton(
                      icon: Icons.close_rounded,
                      iconSize: 21.sp,
                      onPressed: () {
                        context.read<AuthNavigationService>().enableGuestMode();
                        context.pushNamed(Routes.homeScreen);
                      },
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back 👋',
                      style: TextStyles.font24PurpleBold,
                    ),
                    verticalSpace(8),
                    Text(
                      'We\'re excited to have you back, To use your account, you should log in first.',
                      style: TextStyles.font14RegularGray,
                    ),
                    verticalSpace(36),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EmailAndPassword(),
                    verticalSpace(10),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: GestureDetector(
                        onTap: () {
                          context.pushNamed(Routes.forgetPasswordScreen);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyles.font13PurpleRegular,
                        ),
                      ),
                    ),
                    verticalSpace(30),
                    AppButton(
                      buttonText: "Login",
                      textStyle: TextStyles.font16WhiteSemiBold,
                      onPressed: () {
                        validateThenDoLogin(context);
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    verticalSpace(50),
                    const GooglFacebookButtons(),
                    verticalSpace(30),
                    const TermsAndConditionsText(),
                    verticalSpace(50),
                    const DontHaveAccountText(),
                  ],
                ),
                const LoginBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    if (context.read<LoginCubit>().formKey.currentState!.validate()) {
      context.read<LoginCubit>().emitLoginStates();
    }
  }
}
