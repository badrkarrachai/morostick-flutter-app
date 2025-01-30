import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_text_form_field.dart';
import 'package:morostick/features/main_navigation/logic/main_navigation_cubit.dart';

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
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
        height: 45,
        controller: controller,
        hintText: 'Search',
        validator: _validateSearch,
        hintStyle: TextStyles.font14HintTextRegular,
        isEnabled: false,
        onTap: () {
          context.read<MainNavigationCubit>().selectIndex(1);
        },
        prefixIcon: Icon(
          Icons.search,
          size: 22.sp,
          color: ColorsManager.grayPurple,
        ),
      ),
    );
  }
}
