import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_button.dart';
import 'package:morostick/core/widgets/app_custom_icon_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/features/auth/forget_password/verify_code/logic/verify_code_cubit.dart';
import 'package:morostick/features/auth/forget_password/verify_code/ui/widgets/code_input.dart';
import 'package:morostick/features/auth/forget_password/verify_code/ui/widgets/send_code_again.dart';
import 'package:morostick/features/auth/forget_password/verify_code/ui/widgets/verify_code_bloc_listener.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  late VerifyCodeCubit verifyCubit;

  @override
  void initState() {
    super.initState();
    verifyCubit = context.read<VerifyCodeCubit>();
    verifyCubit.startTimer();
  }

  @override
  void dispose() {
    verifyCubit.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: VerifyCodeBlocListener(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppCustomIconButton(),
                  verticalSpace(30),
                  Text(
                    'Check Your Email 🧐',
                    style: TextStyles.font24PurpleBold,
                  ),
                  verticalSpace(8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'We\'ve sent a code to ',
                          style: TextStyles.font14RegularGray,
                        ),
                        TextSpan(
                          text: context.watch<VerifyCodeCubit>().email,
                          style: TextStyles.font14DarkPurpleMedium,
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(36),
                  const CodeInput(),
                  verticalSpace(30),
                  AppButton(
                    buttonText: "Verify",
                    textStyle: TextStyles.font16WhiteSemiBold,
                    onPressed: () => validateThenVerifyCode(context),
                  ),
                  verticalSpace(30),
                  SendCodeAgain(email: context.watch<VerifyCodeCubit>().email),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateThenVerifyCode(BuildContext context) {
    context.read<VerifyCodeCubit>().pinPutFocusNode.unfocus();
    if (context.read<VerifyCodeCubit>().validateCode()) {
      context.read<VerifyCodeCubit>().emitVerifyCodeStates();
    }
  }
}
