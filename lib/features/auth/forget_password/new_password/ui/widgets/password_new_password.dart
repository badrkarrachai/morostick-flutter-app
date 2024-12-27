import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/helpers/app_regex.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/widgets/app_text_form_field.dart';
import 'package:morostick/features/auth/forget_password/new_password/logic/new_password_cubit.dart';
import 'package:morostick/features/auth/forget_password/new_password/logic/new_password_state.dart';
import 'package:morostick/features/auth/login/logic/login_state.dart';

class PasswordNewPassword extends StatefulWidget {
  const PasswordNewPassword({super.key});

  @override
  State<PasswordNewPassword> createState() => _PasswordNewPasswordState();
}

class _PasswordNewPasswordState extends State<PasswordNewPassword> {
  bool isObscureTextNewPassword = true;
  bool isObscureTextConfirmPassword = true;
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    newPasswordController =
        context.read<NewPasswordCubit>().newPasswordController;
    confirmPasswordController =
        context.read<NewPasswordCubit>().confirmPasswordController;
  }

  void _handleLogin() {
    final loginCubit = context.read<NewPasswordCubit>();
    if (loginCubit.formKey.currentState!.validate()) {
      loginCubit.emitNewPasswordStates();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPasswordCubit, NewPasswordState>(
      builder: (context, state) {
        bool hasError = state is Error;

        return Form(
          key: context.read<NewPasswordCubit>().formKey,
          child: Column(
            children: [
              AppTextFormField(
                hintText: 'New Password',
                prefixIcon: const Icon(
                  HugeIcons.strokeRoundedSquareLock02,
                  color: ColorsManager.darkGray,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  if (!AppRegex.hasLowerCase(value)) {
                    return 'Password must contain at least one lowercase letter';
                  }
                  if (!AppRegex.hasNumber(value)) {
                    return 'Password must contain at least one number';
                  }

                  return null;
                },
                controller:
                    context.read<NewPasswordCubit>().confirmPasswordController,
                // Override background color when there's an error
                backgroundColor: hasError
                    ? Colors.red.withValues(alpha: 0.1)
                    : ColorsManager.grayInputBackground,
                // Override border colors when there's an error
                enabledBorder: hasError
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      )
                    : null,
                isObscureText: isObscureTextNewPassword,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureTextNewPassword = !isObscureTextNewPassword;
                    });
                  },
                  child: Icon(
                    isObscureTextNewPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                focusedBorder: hasError
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      )
                    : null,
              ),
              verticalSpace(18),
              AppTextFormField(
                controller:
                    context.read<NewPasswordCubit>().newPasswordController,
                hintText: 'Confirm Password',
                prefixIcon: const Icon(
                  HugeIcons.strokeRoundedSquareLock02,
                  color: ColorsManager.darkGray,
                ),
                isObscureText: isObscureTextConfirmPassword,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureTextConfirmPassword =
                          !isObscureTextConfirmPassword;
                    });
                  },
                  child: Icon(
                    isObscureTextConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                // Override background color when there's an error
                backgroundColor: hasError
                    ? Colors.red.withValues(alpha: 0.1)
                    : ColorsManager.grayInputBackground,
                // Override border colors when there's an error
                enabledBorder: hasError
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      )
                    : null,
                focusedBorder: hasError
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      )
                    : null,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value != confirmPasswordController.text) {
                    return 'The passwords do not match';
                  }
                  return null;
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
