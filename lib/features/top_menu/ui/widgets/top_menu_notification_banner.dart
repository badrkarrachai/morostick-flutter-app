import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';

class TopMenuNotificationBanner extends StatelessWidget {
  const TopMenuNotificationBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.lighterPurple,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            HugeIcons.strokeRoundedNotification01,
            color: ColorsManager.mainPurple,
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Push notifications are disabled for MoroStick.',
                  style: TextStyles.font14PurpleSemiBold,
                ),
                SizedBox(height: 4.h),
                Text(
                  'Tap to enable notifications',
                  style: TextStyles.font13DarkGrayRegular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
