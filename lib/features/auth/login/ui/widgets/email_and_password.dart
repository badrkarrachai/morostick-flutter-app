import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/helpers/app_regex.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_text_form_field.dart';
import 'package:morostick/features/auth/login/logic/login_cubit.dart';
import 'package:morostick/features/auth/login/logic/login_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool isObscureText = true;
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  late TextEditingController emailController;

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = context.read<LoginCubit>().passwordController;
    emailController = context.read<LoginCubit>().emailController;
  }

  void _handleLogin() {
    final loginCubit = context.read<LoginCubit>();
    if (loginCubit.formKey.currentState!.validate()) {
      loginCubit.emitLoginStates();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        bool hasError = state is Error;
        String? emailErrorMessage;
        if (hasError &&
            state.error.error?.errorFields?.contains("email") == true) {
          emailErrorMessage = state.error.message;
        }
        String? passwordErrorMessage;
        if (hasError &&
            state.error.error?.errorFields?.contains("password") == true) {
          passwordErrorMessage = state.error.message;
        }

        return Form(
          key: context.read<LoginCubit>().formKey,
          child: Column(
            children: [
              AppTextFormField(
                hintText: 'Email',
                prefixIcon: const Icon(HugeIcons.strokeRoundedMail02),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!AppRegex.isEmailValid(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                controller: context.read<LoginCubit>().emailController,
                // Override background color when there's an error
                backgroundColor: hasError && emailErrorMessage != null
                    ? Colors.red.withOpacity(0.1)
                    : ColorsManager.grayInputBackground,
                // Override border colors when there's an error
                enabledBorder: hasError && emailErrorMessage != null
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      )
                    : null,
                focusedBorder: hasError && emailErrorMessage != null
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      )
                    : null,
              ),
              if (emailErrorMessage != null) ...[
                verticalSpace(8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Text(
                      emailErrorMessage,
                      style: TextStyles.font14DarkPurpleMedium.copyWith(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
              verticalSpace(18),
              AppTextFormField(
                controller: context.read<LoginCubit>().passwordController,
                hintText: 'Password',
                prefixIcon: const Icon(HugeIcons.strokeRoundedSquareLock02),
                isObscureText: isObscureText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureText = !isObscureText;
                    });
                  },
                  child: Icon(
                    isObscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                // Override background color when there's an error
                backgroundColor: hasError && passwordErrorMessage != null
                    ? Colors.red.withOpacity(0.1)
                    : ColorsManager.grayInputBackground,
                // Override border colors when there's an error
                enabledBorder: hasError && passwordErrorMessage != null
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      )
                    : null,
                focusedBorder: hasError && passwordErrorMessage != null
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      )
                    : null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
              ),
              if (passwordErrorMessage != null) ...[
                verticalSpace(8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Text(
                      passwordErrorMessage,
                      style: TextStyles.font14DarkPurpleMedium.copyWith(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
