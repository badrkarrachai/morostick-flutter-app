import 'package:flutter/material.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageEditButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final double? size;

  const ImageEditButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorsManager.mainPurple,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: size ?? 40.w,
          height: size ?? 40.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: ColorsManager.white,
            size: (size ?? 40.w) * 0.5,
          ),
        ),
      ),
    );
  }
}
