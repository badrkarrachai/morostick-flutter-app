import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/routing/routes.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/widgets/app_snackbar.dart';
import 'package:morostick/features/auth/forget_password/verify_code/logic/verify_code_cubit.dart';
import 'package:morostick/features/auth/forget_password/verify_code/logic/verify_code_state.dart';

class VerifyCodeBlocListener extends StatelessWidget {
  final Widget child;

  const VerifyCodeBlocListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyCodeCubit, VerifyCodeState>(
      listenWhen: (previous, current) =>
          true, // Listen to all state changes since we handle all cases
      listener: (context, state) {
        state.when(
          initial: (_) {
            // Force rebuild of CodeInput for validation updates
            (context as Element).markNeedsBuild();
          },
          loading: (_) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.mainPurple,
                ),
              ),
            );
          },
          success: (data, _) {
            context.pop();
            final cubit = context.read<VerifyCodeCubit>();
            context.pushReplacementNamed(
              Routes.newPasswordScreen,
              arguments: {
                'email': cubit.email,
                'code': cubit.codeController.text,
              },
            );
          },
          error: (error, _) {
            setupErrorState(context, error);
          },
        );
      },
      child: child,
    );
  }

  void setupErrorState(BuildContext context, GeneralResponse error) {
    context.pop();
    context.read<VerifyCodeCubit>().updateCodeInputError(true, error.message);
    showAppSnackbar(
      title: error.message,
      duration: 3,
      description: error.error?.details ??
          "Something went wrong. Please try again later.",
    );
  }
}
