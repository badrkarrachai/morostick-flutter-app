import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  final Widget? prefixIcon;
  final String? errorText;
  final bool? isEnabled;
  final VoidCallback? onTap;
  final double? height;

  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
    this.prefixIcon,
    this.errorText,
    this.isEnabled = true,
    this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height,
        child: TextFormField(
          controller: controller,
          enabled: isEnabled,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: ColorsManager.mainPurple,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
            enabledBorder: enabledBorder ??
                OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: ColorsManager.grayInputBackground,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.grayInputBackground,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            errorText: errorText,
            errorStyle: TextStyles.font14DarkPurpleMedium.copyWith(
              color: Colors.red,
              fontSize: 12,
            ),
            hintStyle: hintStyle ?? TextStyles.font14HintTextRegular,
            hintText: hintText,
            suffixIcon: suffixIcon != null
                ? Theme(
                    data: Theme.of(context).copyWith(
                      iconTheme: IconThemeData(
                        color: isEnabled == false ? Colors.grey[400] : null,
                      ),
                    ),
                    child: suffixIcon!,
                  )
                : null,
            prefixIcon: prefixIcon != null
                ? Theme(
                    data: Theme.of(context).copyWith(
                      iconTheme: IconThemeData(
                        color: isEnabled == false ? Colors.grey[400] : null,
                      ),
                    ),
                    child: prefixIcon!,
                  )
                : null,
            fillColor: isEnabled == false
                ? Colors.grey[200]
                : backgroundColor ?? ColorsManager.grayInputBackground,
            filled: true,
          ),
          obscureText: isObscureText ?? false,
          style: (isEnabled == false)
              ? TextStyles.font14DarkPurpleMedium.copyWith(
                  color: Colors.grey[600],
                )
              : TextStyles.font14DarkPurpleMedium,
          validator: (value) {
            if (isEnabled == false) return null;
            return validator(value);
          },
        ),
      ),
    );
  }
}
