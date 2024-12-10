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
    return null; // Add validation if needed
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
      controller: controller,
      hintText: 'Search',
      validator: _validateSearch,
      hintStyle: TextStyles.font14HintTextRegular,
      prefixIcon: Icon(
        Icons.search,
        size: 22.sp,
        color: ColorsManager.grayPurple,
      ),
    );
  }
}
