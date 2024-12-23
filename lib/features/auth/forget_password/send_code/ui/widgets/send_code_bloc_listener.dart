import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/networking/api_error_handler.dart';
import 'package:morostick/core/routing/routes.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/features/auth/forget_password/send_code/logic/send_code_cubit.dart';
import 'package:morostick/features/auth/forget_password/send_code/logic/send_code_state.dart';

class SendCodeBlocListener extends StatelessWidget {
  const SendCodeBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendCodeCubit, SendCodeState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.mainPurple,
                ),
              ),
            );
          },
          success: (forgetPasswordSendCodeResponse) {
            context.pop();
            context.pushReplacementNamed(Routes.verifyCodeScreen,
                arguments: context.read<SendCodeCubit>().emailController.text);
          },
          error: (error) {
            ErrorHandler.setupErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
