import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_button.dart';
import 'package:morostick/core/widgets/app_custom_icon_button.dart';
import 'package:morostick/features/auth/forget_password/new_password/logic/new_password_cubit.dart';
import 'package:morostick/features/auth/forget_password/new_password/ui/widgets/have_account_login_text.dart';
import 'package:morostick/features/auth/forget_password/new_password/ui/widgets/new_password_listener.dart';
import 'package:morostick/features/auth/forget_password/new_password/ui/widgets/password_new_password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

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
                    const AppCustomIconButton(),
                    verticalSpace(30),
                    Text(
                      'Reset Password 🔐',
                      style: TextStyles.font24PurpleBold,
                    ),
                    verticalSpace(8),
                    Text(
                      'Please type something you’ll remember',
                      style: TextStyles.font14RegularGray,
                    ),
                    verticalSpace(36),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PasswordNewPassword(),
                    verticalSpace(30),
                    AppButton(
                      buttonText: "Reset Password",
                      textStyle: TextStyles.font16WhiteSemiBold,
                      onPressed: () {
                        validateThenDoResetPassword(context);
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    verticalSpace(40),
                    const HaveAccountLoginText(),
                    const NewPasswordBlocListener(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateThenDoResetPassword(BuildContext context) {
    if (context.read<NewPasswordCubit>().formKey.currentState!.validate()) {
      context.read<NewPasswordCubit>().emitNewPasswordStates();
    }
  }
}
