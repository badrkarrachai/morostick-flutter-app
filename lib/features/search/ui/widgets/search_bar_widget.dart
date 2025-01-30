import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_text_form_field.dart';
import 'package:morostick/features/search/logic/search_cubit.dart';
import 'package:provider/provider.dart';

class SearchBarWidget extends StatelessWidget {
  final VoidCallback? onSearch; // Optional callback for additional search logic

  const SearchBarWidget({
    super.key,
    this.onSearch,
  });

  String? _validateSearch(String? value) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      height: 50.h,
      contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 0.h),
      controller: context.read<SearchCubit>().searchController,
      hintText: 'Search',
      validator: _validateSearch,
      hintStyle: TextStyles.font14HintTextRegular,
      prefixIcon: Icon(
        Icons.search,
        size: 22.sp,
        color: ColorsManager.grayPurple,
      ),
      onFieldSubmitted: (value) {
        if (value.trim().isNotEmpty) {
          // Add to recent searches using Provider
          context.read<SearchCubit>().addSearch(value.trim());
          context.read<SearchCubit>().submitSearch(value.trim());
          context.read<SearchCubit>().setSearchResultsScreenShowing(true);

          onSearch?.call(); // Call optional callback if provided
        } else {
          context.read<SearchCubit>().setSearchResultsScreenShowing(false);
        }
      },
      suffixIcon: ValueListenableBuilder<TextEditingValue>(
        valueListenable: context.read<SearchCubit>().searchController,
        builder: (context, value, child) {
          return AnimatedOpacity(
            opacity: value.text.isNotEmpty ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: GestureDetector(
                onTap: value.text.isNotEmpty
                    ? () {
                        context.read<SearchCubit>().searchController.clear();
                        context
                            .read<SearchCubit>()
                            .setSearchResultsScreenShowing(false);

                        // You can optionally trigger a new search here if needed
                        // onSearch?.call();
                      }
                    : null,
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorsManager.inputClearIconGray,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    size: 12.sp,
                    Icons.clear,
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
