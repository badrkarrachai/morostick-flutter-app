import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_custom_icon_button.dart';

class TopMenuHeader extends StatelessWidget {
  const TopMenuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          const AppCustomIconButton(),
          horizontalSpace(10),
          Text('Settings', style: TextStyles.font18BlackSemiBold),
        ],
      ),
    );
  }
}
