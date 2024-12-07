import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/images.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/features/auth/login/logic/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GooglFacebookButtons extends StatelessWidget {
  const GooglFacebookButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                color: ColorsManager.grayButtonBorder,
                height: 1.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Text(
                'Or with',
                style: TextStyles.font13GrayPurpleRegular,
              ),
            ),
            Flexible(
              child: Container(
                color: ColorsManager.grayButtonBorder,
                height: 1.h,
              ),
            )
          ],
        ),
        verticalSpace(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: AppButton(
                  buttonText: 'Google',
                  backgroundColor: Colors.transparent,
                  borderWidth: 1.0,
                  borderColor: ColorsManager.grayButtonBorder,
                  textStyle: TextStyles.font14DarkPurpleMedium,
                  leftIcon: SvgPicture.asset(Images.googleLogo),
                  onPressed: () {
                    context.read<LoginCubit>().signInWithGoogle();
                  }),
            ),
            horizontalSpace(13),
            Flexible(
              child: AppButton(
                  buttonText: 'Facebook',
                  backgroundColor: Colors.transparent,
                  borderWidth: 1.0,
                  borderColor: ColorsManager.grayButtonBorder,
                  textStyle: TextStyles.font14DarkPurpleMedium,
                  leftIcon: SvgPicture.asset(Images.facebookLogo),
                  onPressed: () {
                    context.read<LoginCubit>().signInWithFacebook();
                  }),
            ),
          ],
        )
      ],
    );
  }
}
