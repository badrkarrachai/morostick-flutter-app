import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/helpers/app_regex.dart';
import 'package:morostick/core/widgets/app_text_form_field.dart';
import 'package:morostick/features/auth/forget_password/send_code/logic/send_code_cubit.dart';

class EmailInput extends StatefulWidget {
  const EmailInput({super.key});

  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SendCodeCubit>().formKey,
      child: Column(
        children: [
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
            controller: context.read<SendCodeCubit>().emailController,
          ),
        ],
      ),
    );
  }
}
