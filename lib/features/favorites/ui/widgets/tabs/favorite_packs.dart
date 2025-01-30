import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritePacks extends StatefulWidget {
  const FavoritePacks({super.key});

  @override
  State<FavoritePacks> createState() => _FavoritePacksState();
}

class _FavoritePacksState extends State<FavoritePacks> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFilterChips(),
        verticalSpace(5),
        const Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SuggestedForYou(),
                // SuggestedForYou(),
                // SuggestedForYou(),
                // SuggestedForYou(),
                // SuggestedForYou(),
                // SuggestedForYou(),
                // SuggestedForYou(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            _buildFilterChip('All'),
            horizontalSpace(8),
            _buildFilterChip('Regular'),
            horizontalSpace(8),
            _buildFilterChip('Animated'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String filter) {
    final bool isSelected = selectedFilter == filter;
    return InkWell(
      onTap: () => setState(() => selectedFilter = filter),
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorsManager.mainPurple
              : ColorsManager.lighterPurple,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? ColorsManager.mainPurple
                : ColorsManager.mainPurple.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Text(
          filter,
          style: isSelected
              ? TextStyles.font13GrayWhiteRegular
              : TextStyles.font13PurpleRegular,
        ),
      ),
    );
  }
}
