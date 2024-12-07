import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/routing/routes.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/widgets/app_snackbar.dart';
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
            context.pushNamed(Routes.verifyCodeScreen,
                arguments: context.read<SendCodeCubit>().emailController.text);
          },
          error: (error) {
            setupErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, GeneralResponse error) {
    context.pop();
    showAppSnackbar(
      title: error.message,
      duration: 3,
      description: error.error?.details ??
          "Something went wrong. Please try again later.",
    );
  }
}
