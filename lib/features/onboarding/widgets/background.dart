import 'package:flutter/material.dart';
import 'package:morostick/core/theming/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Background extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final double patternOpacity;

  const Background({
    super.key,
    required this.child,
    this.backgroundColor,
    this.patternOpacity = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Bottom layer - base background
        Container(
          width: double.infinity,
          height: double.infinity,
          color: backgroundColor ?? Colors.white,
        ),
        // Middle layer - pattern or overlay
        Transform.translate(
          offset: Offset(-63.w, 126.h),
          child: Image.asset(
            Images.backgroundGreenLeft,
          ),
        ),
        Transform.translate(
          offset: Offset(263.w, 0.h),
          child: Image.asset(
            Images.backgroundYellowTopRight,
          ),
        ),
        Transform.translate(
          offset: Offset(260.w, 232.h),
          child: Image.asset(
            Images.backgroundBlueRight,
          ),
        ),
        Transform.translate(
          offset: Offset(70.w, 424.h),
          child: Image.asset(
            Images.backgroundCaynMiddle,
          ),
        ),
        Transform.translate(
          offset: Offset(200.w, 670.h),
          child: Image.asset(
            Images.backgroundYellowMiddel,
          ),
        ),
        // Top layer - content
        child,
      ],
    );
  }
}
