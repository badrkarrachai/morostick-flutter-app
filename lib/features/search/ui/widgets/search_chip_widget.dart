import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/search/logic/search_cubit.dart';

class SearchChipWidget extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const SearchChipWidget({
    super.key,
    required this.label,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SearchCubit>().searchController.text = label;
        context.read<SearchCubit>().addSearch(label.trim());
        context.read<SearchCubit>().submitSearch(label.trim());
        context.read<SearchCubit>().setSearchResultsScreenShowing(true);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: ColorsManager.grayInputBackground,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: TextStyles.font14DarkPurpleMedium),
            horizontalSpace(4),
            GestureDetector(
              onTap: onRemove,
              child: Icon(Icons.close,
                  size: 16.w, color: ColorsManager.grayPurple),
            ),
          ],
        ),
      ),
    );
  }
}
