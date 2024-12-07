import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/auth/forget_password/send_code/logic/send_code_cubit.dart';
import 'package:morostick/features/auth/forget_password/verify_code/logic/verify_code_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/features/auth/forget_password/verify_code/logic/verify_code_state.dart';

class SendCodeAgain extends StatelessWidget {
  final String email;
  const SendCodeAgain({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyCodeCubit, VerifyCodeState>(
      builder: (context, state) {
        final timerCount = state.statesData.timerCount;
        return _buildCenterText(timerCount, context);
      },
    );
  }

  Widget _buildCenterText(int timerCount, BuildContext context) {
    final isTimerZero = timerCount == 0;

    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Send code again ',
              style: isTimerZero
                  ? TextStyles.font13PurpleSemiBold
                  : TextStyles.font13GrayPurpleRegular,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  if (isTimerZero) {
                    context
                        .read<SendCodeCubit>()
                        .emitSendCodeStates(email: email);
                    context.read<VerifyCodeCubit>().startTimer();
                  }
                },
            ),
            if (!isTimerZero)
              TextSpan(
                text: '${timerCount.toString().padLeft(2, '0')} second(s)',
                style: TextStyles.font13DarkPurpleMedium,
              ),
          ],
        ),
      ),
    );
  }
}
