import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/routing/routes.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/theming/colors.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  Future<void> _handleMenuTap(BuildContext context) async {
    Navigator.of(context, rootNavigator: true)
        .context
        .pushNamed(Routes.topMenuScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Morostick',
          style: TextStyles.font24BoldBlack,
        ),
        IconButton(
          icon: Icon(
            HugeIcons.strokeRoundedMenu01,
            size: 24.sp,
            color: ColorsManager.darkPurple,
          ),
          onPressed: () => _handleMenuTap(context),
        ),
      ],
    );
  }
}
