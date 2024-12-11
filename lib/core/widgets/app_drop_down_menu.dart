import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/colors.dart';

class AppDropDownMenu<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?) onChanged;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? selectedItemStyle;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? menuMaxHeight;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isExpanded;
  final bool isDense;
  final bool enabled;

  const AppDropDownMenu({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hintText,
    this.hintStyle,
    this.selectedItemStyle,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.menuMaxHeight,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
    this.isExpanded = true,
    this.isDense = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorsManager.backgroundLightColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
        border: Border.all(
          color: borderColor ?? ColorsManager.grayButtonBorder,
          width: borderWidth ?? 1.w,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<T>(
            value: value,
            items: items,
            onChanged: enabled ? onChanged : null,
            hint: hintText != null
                ? Text(
                    hintText!,
                    style: hintStyle ??
                        TextStyle(
                          fontSize: 14.sp,
                          color: ColorsManager.grayInputHintText,
                        ),
                  )
                : null,
            style: selectedItemStyle ??
                TextStyle(
                  fontSize: 14.sp,
                  color: ColorsManager.darkPurple,
                ),
            icon: suffixIcon ??
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: ColorsManager.grayPurple,
                  size: 24.sp,
                ),
            isExpanded: isExpanded,
            isDense: isDense,
            menuMaxHeight: menuMaxHeight,
            dropdownColor: ColorsManager.backgroundLightColor,
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
            focusColor: Colors.transparent,
            elevation: 2,
          ),
        ),
      ),
    );
  }
}
