import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/helpers/spacing.dart';

import '../theming/colors.dart';

class AppButton extends StatelessWidget {
  final double? borderRadius;
  final Color? backgroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final String buttonText;
  final TextStyle textStyle;
  final VoidCallback onPressed;
  final Color? borderColor;
  final double? borderWidth;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool enabled;

  const AppButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonHeight,
    this.buttonWidth,
    required this.buttonText,
    required this.textStyle,
    required this.onPressed,
    this.borderColor,
    this.borderWidth,
    this.leftIcon,
    this.rightIcon,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
            side: BorderSide(
              color: borderColor ??
                  (enabled
                      ? ColorsManager.mainPurple
                      : ColorsManager.darkPurple),
              width: borderWidth ?? 0,
            ),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(
          backgroundColor ??
              (enabled
                  ? ColorsManager.mainPurple
                  : ColorsManager.disbleadPurple),
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding?.w ?? 12.w,
            vertical: verticalPadding?.h ?? 10.h,
          ),
        ),
        fixedSize: WidgetStateProperty.all(
          Size(buttonWidth?.w ?? double.maxFinite, buttonHeight ?? 50.h),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leftIcon != null) leftIcon!,
          if (leftIcon != null) horizontalSpace(8),
          Text(
            buttonText,
            style: textStyle,
          ),
          if (leftIcon != null) horizontalSpace(8),
          if (rightIcon != null) rightIcon!,
        ],
      ),
    );
  }
}
