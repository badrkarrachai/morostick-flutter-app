import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/morostick_app.dart';
import 'package:morostick/core/helpers/extensions.dart';

class CustomDialog extends StatefulWidget {
  final Widget child;
  final Color barrierColor;

  const CustomDialog({
    super.key,
    required this.child,
    this.barrierColor = Colors.black54,
  });

  static Future<T?> show<T>({
    required Widget child,
    Color barrierColor = Colors.black54,
    bool barrierDismissible = true,
  }) {
    if (navigatorKey.currentContext == null) return Future.value(null);

    return showGeneralDialog<T>(
      context: navigatorKey.currentContext!,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: 'Dialog Barrier',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return CustomDialog(
          barrierColor: barrierColor,
          child: child,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: widget.child,
    );
  }
}

class OfflineDialog extends StatelessWidget {
  const OfflineDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Material(
          color: Colors.white,
          elevation: 8,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: ColorsManager.mainPurple.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.wifi_off_rounded,
                    color: ColorsManager.mainPurple,
                    size: 40.r,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'No Internet Connection',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Seems like you are not connected to the internet. But you can still use the app.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.mainPurple,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Understood',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DialogManager {
  static bool _isDialogShowing = false;

  static void showOfflineDialog() {
    if (!_isDialogShowing) {
      _isDialogShowing = true;
      CustomDialog.show(
        barrierColor: Colors.black.withOpacity(0.5),
        child: const OfflineDialog(),
      ).then((_) => _isDialogShowing = false);
    }
  }
}

class OfflineStateHandler extends StatefulWidget {
  final AuthNavigationService authService;

  const OfflineStateHandler({
    super.key,
    required this.authService,
  });

  @override
  State<OfflineStateHandler> createState() => _OfflineStateHandlerState();
}

class _OfflineStateHandlerState extends State<OfflineStateHandler> {
  bool _wasOffline = false;

  @override
  void didUpdateWidget(OfflineStateHandler oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checkOfflineStatus();
  }

  @override
  void initState() {
    super.initState();
    _checkOfflineStatus();
  }

  void _checkOfflineStatus() {
    final isOffline = widget.authService.isOffline;
    if (isOffline && !_wasOffline) {
      _wasOffline = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DialogManager.showOfflineDialog();
      });
    } else if (!isOffline) {
      _wasOffline = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.authService,
      builder: (context, _) {
        _checkOfflineStatus();
        return const SizedBox.shrink();
      },
    );
  }
}
