import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:morostick/core/helpers/app_regex.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/widgets/app_text_form_field.dart';
import 'package:morostick/features/auth/sign_up/logic/sign_up_cubit.dart';

class NameEmailAndPassword extends StatefulWidget {
  const NameEmailAndPassword({super.key});

  @override
  State<NameEmailAndPassword> createState() => _NameEmailAndPasswordState();
}

class _NameEmailAndPasswordState extends State<NameEmailAndPassword> {
  bool isObscureText = true;

  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = context.read<SignupCubit>().passwordController;
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(passwordController.text);
        hasUppercase = AppRegex.hasUpperCase(passwordController.text);
        hasSpecialCharacters =
            AppRegex.hasSpecialCharacter(passwordController.text);
        hasNumber = AppRegex.hasNumber(passwordController.text);
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignupCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'Full Name',
            prefixIcon: const Icon(HugeIcons.strokeRoundedUser),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isFullNameValid(value)) {
                return 'Please enter a valid full name';
              }
            },
            controller: context.read<SignupCubit>().nameController,
          ),
          verticalSpace(18),
          AppTextFormField(
            hintText: 'Email',
            prefixIcon: const Icon(HugeIcons.strokeRoundedMail02),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
            },
            controller: context.read<SignupCubit>().emailController,
          ),
          verticalSpace(18),
          AppTextFormField(
            controller: context.read<SignupCubit>().passwordController,
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
              if (!AppRegex.hasLowerCase(value)) {
                return 'Password must contain at least one lowercase letter';
              }
              if (!AppRegex.hasNumber(value)) {
                return 'Password must contain at least one number';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
