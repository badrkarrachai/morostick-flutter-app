import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';

class TopMenuNotificationBanner extends StatefulWidget {
  const TopMenuNotificationBanner({super.key});

  @override
  State<TopMenuNotificationBanner> createState() =>
      _TopMenuNotificationBannerState();
}

class _TopMenuNotificationBannerState extends State<TopMenuNotificationBanner>
    with WidgetsBindingObserver {
  bool _showBanner = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkNotificationPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkNotificationPermission();
    }
  }

  Future<void> _checkNotificationPermission() async {
    final status = await Permission.notification.status;
    if (mounted) {
      setState(() {
        _showBanner = status.isDenied || status.isPermanentlyDenied;
      });
    }
  }

  Future<void> _handleNotificationTap() async {
    final status = await Permission.notification.status;

    if (status.isPermanentlyDenied) {
      // Open app settings if permanently denied
      await AppSettings.openAppSettings(type: AppSettingsType.notification);
    } else {
      // Request permission if just denied
      final result = await Permission.notification.request();

      if (mounted) {
        setState(() {
          _showBanner = result.isDenied || result.isPermanentlyDenied;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_showBanner) return verticalSpace(5);

    return GestureDetector(
      onTap: _handleNotificationTap,
      child: Container(
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
      ),
    );
  }
}
