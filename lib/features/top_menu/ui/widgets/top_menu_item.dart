import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morostick/core/theming/colors.dart';

class TopMenuItem {
  final String icon;
  final String title;
  final TextStyle textStyle;
  final Color? iconColor;
  final bool showArrow;
  final bool showToggle;
  final VoidCallback? onTap;
  final bool switchValue;
  final void Function(bool)? onToggle;
  final EdgeInsetsGeometry? contentPadding;

  const TopMenuItem({
    required this.icon,
    required this.title,
    required this.textStyle,
    this.iconColor,
    this.showArrow = false,
    this.showToggle = false,
    this.onTap,
    this.switchValue = false,
    this.onToggle,
    this.contentPadding,
  });
}

class TopMenuItemWidget extends StatelessWidget {
  final TopMenuItem item;

  const TopMenuItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (item.onTap != null) {
          item.onTap!();
        }
        if (item.onToggle != null) {
          item.onToggle!(!item.switchValue);
        }
      },
      child: Padding(
        padding: item.contentPadding ??
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            SvgPicture.asset(
              item.icon,
              colorFilter: item.iconColor != null
                  ? ColorFilter.mode(item.iconColor ?? ColorsManager.darkPurple,
                      BlendMode.srcIn)
                  : null,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                item.title,
                style: item.textStyle,
              ),
            ),
            if (item.showArrow)
              Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: ColorsManager.grayPurple,
              )
            else if (item.showToggle)
              Transform.scale(
                scale:
                    0.8, // Adjust this value between 0.7-0.9 for desired size
                child: CupertinoSwitch(
                  value: item.switchValue,
                  onChanged: item.onToggle,
                  activeTrackColor: ColorsManager.mainPurple,
                ),
              )
          ],
        ),
      ),
    );
  }
}
