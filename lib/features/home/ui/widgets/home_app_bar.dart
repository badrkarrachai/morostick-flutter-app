import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    final authService = context.read<AuthNavigationService>();
    final success = await authService.logout();

    if (success) {
      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Morostick',
            style: TextStyles.font24BoldBlack,
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
              size: 24.sp,
              color: ColorsManager.darkPurple,
            ),
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
    );
  }
}
