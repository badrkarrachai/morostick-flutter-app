import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_button.dart';
import 'package:morostick/core/widgets/app_custom_icon_button.dart';
import 'package:morostick/features/auth/forget_password/send_code/logic/send_code_cubit.dart';
import 'package:morostick/features/auth/forget_password/send_code/ui/widgets/email_input.dart';
import 'package:morostick/features/auth/forget_password/send_code/ui/widgets/send_code_bloc_listener.dart';
import 'package:morostick/features/auth/forget_password/send_code/ui/widgets/remember_your_password.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendCodeScreen extends StatelessWidget {
  const SendCodeScreen({super.key});

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
                      'Forgot Password 🫢',
                      style: TextStyles.font24PurpleBold,
                    ),
                    verticalSpace(8),
                    Text(
                      'Don’t worry! It happens. Please enter the email associated with your account.',
                      style: TextStyles.font14RegularGray,
                    ),
                    verticalSpace(36),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EmailInput(),
                    verticalSpace(30),
                    AppButton(
                      buttonText: "Send Code",
                      textStyle: TextStyles.font16WhiteSemiBold,
                      onPressed: () {
                        validateThenSendCode(context);
                      },
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    verticalSpace(30),
                    const Center(child: RememberYourPassword()),
                  ],
                ),
                const SendCodeBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateThenSendCode(BuildContext context) {
    if (context.read<SendCodeCubit>().formKey.currentState!.validate()) {
      context.read<SendCodeCubit>().emitSendCodeStates();
    }
  }
}
