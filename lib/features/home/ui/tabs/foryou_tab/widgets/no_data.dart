import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/helpers/number_and_text_formatter.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/theming/colors.dart';

class NoDataWidget extends StatelessWidget {
  final String? message;
  final String? title;
  final IconData? icon;
  final VoidCallback? onRefresh;

  const NoDataWidget({
    super.key,
    this.message,
    this.title,
    this.icon,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: GestureDetector(
          onTap: onRefresh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  color: ColorsManager.middleGray.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (icon == null)
                      Positioned(
                        top: 18,
                        right: 15,
                        child: Icon(
                          Icons.close_rounded,
                          size: 23.w,
                          color: ColorsManager.middleGray,
                        ),
                      ),
                    Icon(
                      icon ?? HugeIcons.strokeRoundedLayers01,
                      size: 40.w,
                      color: ColorsManager.middleGray,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              // Title
              Text(
                title ?? 'No Data Found',
                style: TextStyles.font16DarkGraySemiBold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              // Message
              if (message != null)
                Text(
                  message!.breakLines(100),
                  style: TextStyles.font12MiddleGrayRegular,
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
