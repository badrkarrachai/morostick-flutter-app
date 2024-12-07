import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/routing/routes.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/widgets/app_snackbar.dart';
import 'package:morostick/features/auth/login/logic/login_cubit.dart';
import 'package:morostick/features/auth/login/logic/login_state.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
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
          success: (loginResponse) {
            context.pushNamedAndRemoveAll(Routes.homeScreen);
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
