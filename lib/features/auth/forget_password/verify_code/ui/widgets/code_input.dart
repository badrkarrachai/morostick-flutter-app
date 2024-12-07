import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/auth/forget_password/verify_code/logic/verify_code_cubit.dart';
import 'package:morostick/features/auth/forget_password/verify_code/logic/verify_code_state.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _defaultPinTheme = PinTheme(
  width: 60,
  height: 60,
  textStyle: const TextStyle(
    fontSize: 24,
    color: ColorsManager.darkPurple,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16.0),
    color: ColorsManager.grayInputBackground,
  ),
);

final _focusedPinTheme = _defaultPinTheme.copyWith(
  decoration: _defaultPinTheme.decoration?.copyWith(
    border: Border.all(color: ColorsManager.mainPurple, width: 1.3),
  ),
);

final _errorPinTheme = PinTheme(
  width: 60,
  height: 60,
  textStyle: const TextStyle(
    fontSize: 24,
    color: Colors.red,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16.0),
    border: Border.all(width: 1, color: Colors.red),
    color: ColorsManager.grayInputBackground,
  ),
);

class CodeInput extends StatefulWidget {
  const CodeInput({super.key});

  @override
  State<CodeInput> createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {
  late FocusNode pinPutFocusNode;

  @override
  void initState() {
    super.initState();
    pinPutFocusNode = context.read<VerifyCodeCubit>().pinPutFocusNode;
    Future.microtask(() => pinPutFocusNode.requestFocus());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyCodeCubit, VerifyCodeState>(
      builder: (context, state) {
        final cubit = context.read<VerifyCodeCubit>();
        final hasError = state.statesData.hasCodeInputError;
        final errorText = state.statesData.errorText;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Pinput(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                length: 5,
                onCompleted: (pin) => cubit.codeController.text = pin,
                onTap: () {
                  cubit.updateCodeInputError(false, null);
                },
                defaultPinTheme: hasError ? _errorPinTheme : _defaultPinTheme,
                focusedPinTheme: _focusedPinTheme,
                focusNode: cubit.pinPutFocusNode,
                controller: cubit.codeController,
                errorPinTheme: _errorPinTheme,
                showCursor: true,
              ),
            ),
            if (hasError) ...[
              verticalSpace(8),
              Center(
                child: Text(
                  errorText,
                  style: TextStyles.font13RedRegular,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
