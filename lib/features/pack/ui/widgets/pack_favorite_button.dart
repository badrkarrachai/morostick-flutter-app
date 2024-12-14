import 'package:flutter/material.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackFavoriteButton extends StatelessWidget {
  final ValueNotifier<bool> isFavorite;
  final VoidCallback onToggle;

  const PackFavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isFavorite,
      builder: (context, isFavorited, child) {
        return IconButton(
          onPressed: onToggle,
          icon: Icon(
            isFavorited
                ? Icons.favorite_rounded
                : Icons.favorite_outline_rounded,
            color: isFavorited
                ? ColorsManager.mainPurple
                : ColorsManager.darkPurple,
            size: 24.sp,
          ),
        );
      },
    );
  }
}
