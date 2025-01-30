import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/helpers/extensions.dart';

import '../theming/colors.dart';

class AppCustomIconButton extends StatelessWidget {
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final IconData? icon;
  final double? iconSize;
  final VoidCallback? onPressed;

  const AppCustomIconButton({
    super.key,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.icon,
    this.iconSize,
    this.onPressed,
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
        onPressed: onPressed ??
            () {
              context.pop();
            },
        child: IconTheme(
          data: const IconThemeData(
            color: Colors.black, // Set color
            size: 25, // Set size
          ),
          child: Icon(
            icon ?? HugeIcons.strokeRoundedArrowLeft01,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
