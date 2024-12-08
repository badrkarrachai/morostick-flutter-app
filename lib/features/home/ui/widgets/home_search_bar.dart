import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/widgets/app_text_form_field.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const HomeSearchBar({
    super.key,
    required this.controller,
  });

  String? _validateSearch(String? value) {
    return null; // Add validation if needed
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: AppTextFormField(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        controller: controller,
        hintText: 'Search',
        validator: _validateSearch,
        prefixIcon: Icon(
          Icons.search,
          size: 24.sp,
          color: ColorsManager.grayPurple,
        ),
      ),
    );
  }
}
