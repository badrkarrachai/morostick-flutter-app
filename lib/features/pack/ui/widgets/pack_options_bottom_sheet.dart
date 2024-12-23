import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/features/pack/ui/widgets/pack_option_tile.dart';

class PackOptionsBottomSheet extends StatelessWidget {
  final VoidCallback onHide;
  final VoidCallback onReport;

  const PackOptionsBottomSheet({
    super.key,
    required this.onHide,
    required this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpace(8),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ColorsManager.lightGray,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          verticalSpace(16),
          PackOptionTile(
            icon: Icons.visibility_off_outlined,
            title: 'Hide Pack',
            onTap: onHide,
          ),
          PackOptionTile(
            icon: Icons.flag_outlined,
            title: 'Report Pack',
            isDestructive: true,
            onTap: onReport,
          ),
          verticalSpace(16),
        ],
      ),
    );
  }
}
