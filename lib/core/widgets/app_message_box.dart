import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_button.dart';
import 'package:morostick/morostick_app.dart';

class AppMessageBox extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final List<AppMessageBoxButton> buttons;
  final Color? backgroundColor;
  final Color? iconBackgroundColor;
  final Color? iconColor;

  const AppMessageBox({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    required this.buttons,
    this.backgroundColor,
    this.iconBackgroundColor,
    this.iconColor,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String message,
    required IconData icon,
    required List<AppMessageBoxButton> buttons,
    Color? backgroundColor,
    Color? iconBackgroundColor,
    Color? iconColor,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: AppMessageBox(
            title: title,
            message: message,
            icon: icon,
            buttons: buttons
                .map((button) => AppMessageBoxButton(
                      text: button.text,
                      onPressed: () {
                        context.pop();
                        button.onPressed();
                      },
                      isPrimary: button.isPrimary,
                      backgroundColor: button.backgroundColor,
                      textColor: button.textColor,
                      borderColor: button.borderColor,
                    ))
                .toList(),
            backgroundColor: backgroundColor,
            iconBackgroundColor: iconBackgroundColor,
            iconColor: iconColor,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64.r,
                height: 64.r,
                decoration: BoxDecoration(
                  color: iconBackgroundColor ??
                      ColorsManager.mainPurple.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32.r,
                  color: iconColor ?? ColorsManager.mainPurple,
                ),
              ),
              verticalSpace(16),
              Text(
                title,
                style: TextStyles.font18DarkPurpleSemiBold,
                textAlign: TextAlign.center,
              ),
              verticalSpace(8),
              Text(
                message,
                style: TextStyles.font14GrayPurpleRegular,
                textAlign: TextAlign.center,
              ),
              verticalSpace(24),
              if (buttons.length == 1)
                buttons.first
              else
                Row(
                  children: buttons.map((button) {
                    final isLast = buttons.last == button;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: buttons.first == button ? 0 : 8.w,
                          right: isLast ? 0 : 8.w,
                        ),
                        child: button,
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppMessageBoxButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const AppMessageBoxButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      buttonText: text,
      onPressed: onPressed,
      backgroundColor: backgroundColor ??
          (isPrimary ? ColorsManager.mainPurple : Colors.transparent),
      isFixedSize: false,
      verticalPadding: 11.h,
      borderColor:
          borderColor ?? (isPrimary ? null : ColorsManager.grayButtonBorder),
      borderWidth: isPrimary ? 0 : 1,
      textStyle: isPrimary
          ? TextStyles.font14WhiteSemiBold
          : TextStyles.font14GrayPurpleSemiBold,
      buttonHeight: 48.h,
    );
  }
}

class AppMessageBoxDialogServiceNonContext {
  static BuildContext? get _context => AppKeys.navigatorKey.currentContext;

  static void showSuccess({
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    if (_context != null) {
      AppMessageBoxDialogManager.showSuccessDialog(
        context: _context!,
        title: title,
        message: message,
        onConfirm: onConfirm,
      );
    }
  }

  static void showError({
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    if (_context != null) {
      AppMessageBoxDialogManager.showErrorDialog(
        context: _context!,
        title: title,
        message: message,
        onConfirm: onConfirm,
      );
    }
  }

  static void showConfirm({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String? confirmText,
    String? cancelText,
    IconData? icon,
  }) {
    if (_context != null) {
      AppMessageBoxDialogManager.showConfirmDialog(
        context: _context!,
        icon: icon,
        title: title,
        message: message,
        onConfirm: onConfirm,
        confirmText: confirmText,
        cancelText: cancelText,
      );
    }
  }
}

class AppMessageBoxDialogManager {
  static final List<_DialogRequest> _dialogQueue = [];
  static bool _isDialogShowing = false;

  static void _showNextDialog() {
    if (_dialogQueue.isEmpty || _isDialogShowing) return;

    _isDialogShowing = true;
    final request = _dialogQueue.removeAt(0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppMessageBox.show(
        context: request.context,
        title: request.title,
        message: request.message,
        icon: request.icon,
        buttons: request.buttons,
        backgroundColor: request.backgroundColor,
        iconBackgroundColor: request.iconBackgroundColor,
        iconColor: request.iconColor,
      ).then((_) {
        _isDialogShowing = false;
        _showNextDialog();
      });
    });
  }

  static void showSuccessDialog({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    _dialogQueue.add(_DialogRequest(
      context: context,
      title: title,
      message: message,
      icon: Icons.check_circle_outlined,
      buttons: [
        AppMessageBoxButton(
          text: 'OK',
          onPressed: () {
            onConfirm?.call();
          },
        ),
      ],
    ));
    _showNextDialog();
  }

  static void showErrorDialog({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    _dialogQueue.add(_DialogRequest(
      context: context,
      title: title,
      message: message,
      icon: Icons.error_outline,
      iconColor: ColorsManager.normalRed,
      iconBackgroundColor: ColorsManager.normalRed.withValues(alpha: 0.1),
      buttons: [
        AppMessageBoxButton(
          text: 'OK',
          onPressed: () {
            onConfirm?.call();
          },
          backgroundColor: ColorsManager.normalRed,
        ),
      ],
    ));
    _showNextDialog();
  }

  static void showConfirmDialog({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String? confirmText,
    String? cancelText,
    IconData? icon,
  }) {
    _dialogQueue.add(_DialogRequest(
      context: context,
      title: title,
      message: message,
      icon: icon ?? Icons.help_outline,
      buttons: [
        AppMessageBoxButton(
          text: cancelText ?? 'Cancel',
          onPressed: () {},
          isPrimary: false,
        ),
        AppMessageBoxButton(
          text: confirmText ?? 'Confirm',
          onPressed: () {
            onConfirm();
          },
        ),
      ],
    ));
    _showNextDialog();
  }
}

class _DialogRequest {
  final BuildContext context;
  final String title;
  final String message;
  final IconData icon;
  final List<AppMessageBoxButton> buttons;
  final Color? backgroundColor;
  final Color? iconBackgroundColor;
  final Color? iconColor;

  _DialogRequest({
    required this.context,
    required this.title,
    required this.message,
    required this.icon,
    required this.buttons,
    this.backgroundColor,
    this.iconBackgroundColor,
    this.iconColor,
  });
}
