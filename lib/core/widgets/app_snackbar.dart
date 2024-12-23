import 'package:flutter/material.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:toastification/toastification.dart';

void showAppSnackbar({
  IconData? icon,
  String? title,
  String? description,
  int? duration,
  ToastificationType? type,
  Color? color,
}) {
  toastification.show(
    title: Text(title ?? "Error", style: TextStyles.font13DarkPurpleMedium),
    description: Text(
        description ?? "Something went wrong. Please try again later.",
        style: TextStyles.font12DarkPurpleRegular),
    type: type ?? ToastificationType.success,
    style: ToastificationStyle.flat,
    autoCloseDuration: Duration(seconds: duration ?? 3),
    alignment: Alignment.topCenter,
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
  );
}
