import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/networking/api_error_handler.dart';
import 'package:morostick/core/routing/routes.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/features/auth/forget_password/new_password/logic/new_password_cubit.dart';
import 'package:morostick/features/auth/forget_password/new_password/logic/new_password_state.dart';

class NewPasswordBlocListener extends StatelessWidget {
  const NewPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewPasswordCubit, NewPasswordState>(
      listenWhen: (previous, current) =>
          current is NewPasswordLoading ||
          current is NewPasswordSuccess ||
          current is NewPasswordError,
      listener: (context, state) {
        state.whenOrNull(
          newPasswordLoading: () {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.mainPurple,
                ),
              ),
            );
          },
          newPasswordSuccess: (newPasswordResponse) {
            context.pushNamedAndRemoveAll(Routes.homeScreen);
          },
          newPasswordError: (error) {
            ErrorHandler.setupErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
