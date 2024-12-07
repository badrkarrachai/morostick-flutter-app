import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/helpers/extensions.dart';

import '../theming/colors.dart';

class AppBackButton extends StatelessWidget {
  final double? borderRadius;
  final Color? backgroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final Color? borderColor;
  final double? borderWidth;
  final Widget? leftIcon;
  final Widget? rightIcon;

  const AppBackButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonHeight,
    this.buttonWidth,
    this.borderColor,
    this.borderWidth,
    this.leftIcon,
    this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      child: TextButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
              side: BorderSide(
                color: borderColor ?? ColorsManager.grayButtonBorder,
                width: borderWidth ?? 1.3,
              ),
            ),
          ),
          padding: WidgetStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(
              horizontal: 0.w,
              vertical: 8.h,
            ),
          ),
        ),
        onPressed: () {
          context.pop();
        },
        child: const IconTheme(
          data: IconThemeData(
            color: Colors.black, // Set color
            size: 25, // Set size
          ),
          child: Icon(
            HugeIcons.strokeRoundedArrowLeft01,
          ),
        ),
      ),
    );
  }
}
