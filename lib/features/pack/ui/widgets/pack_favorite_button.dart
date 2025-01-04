import 'package:flutter/material.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackFavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final void Function(String, bool) onToggle;
  final String packId;

  const PackFavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onToggle,
    required this.packId,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onToggle(packId, !isFavorite);
      },
      icon: Icon(
        isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
        color: isFavorite ? ColorsManager.mainPurple : ColorsManager.darkPurple,
        size: 24.sp,
      ),
    );
  }
}
