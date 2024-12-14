import 'package:flutter/material.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const PackOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isDestructive ? Colors.red : ColorsManager.darkPurple;

    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: color,
        size: 24.sp,
      ),
      title: Text(
        title,
        style: TextStyles.font16DarkPurpleSemiBold.copyWith(
          color: color,
        ),
      ),
    );
  }
}
