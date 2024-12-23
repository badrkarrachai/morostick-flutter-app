import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_text_form_field.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;

  const SearchBarWidget({
    super.key,
    required this.controller,
  });

  String? _validateSearch(String? value) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      height: 44.h,
      contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 0.h),
      controller: controller,
      hintText: 'Search',
      validator: _validateSearch,
      hintStyle: TextStyles.font14HintTextRegular,
      prefixIcon: Icon(
        Icons.search,
        size: 22.sp,
        color: ColorsManager.grayPurple,
      ),
      suffixIcon: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, child) {
          return AnimatedOpacity(
            opacity: value.text.isNotEmpty ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: GestureDetector(
                onTap: value.text.isNotEmpty ? () => controller.clear() : null,
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorsManager.inputClearIconGray,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.clear,
                    size: 12.sp,
                    color: ColorsManager.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
