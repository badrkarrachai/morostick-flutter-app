import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/helpers/spacing.dart';

class SelectedFiltersView extends StatelessWidget {
  final Map<String, dynamic> filters;
  final VoidCallback onClearAll;
  final VoidCallback onOpenFilters;
  final Function(String) onRemoveFilter;

  const SelectedFiltersView({
    super.key,
    required this.filters,
    required this.onClearAll,
    required this.onOpenFilters,
    required this.onRemoveFilter,
  });

  @override
  Widget build(BuildContext context) {
    final activeFilters = _getActiveFilters();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with filters button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              gradient: LinearGradient(
                colors: [
                  ColorsManager.mainPurple.withValues(alpha: 0.08),
                  ColorsManager.mainPurple.withValues(alpha: 0.03),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.filter_list_rounded,
                      color: ColorsManager.mainPurple,
                      size: 20.sp,
                    ),
                    horizontalSpace(8),
                    Text(
                      '${activeFilters.isEmpty ? 'No' : activeFilters.length} Active Filters',
                      style: TextStyles.font13DarkPurpleSemiBold,
                    ),
                  ],
                ),
                TextButton(
                  onPressed: onOpenFilters,
                  style: TextButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    backgroundColor:
                        ColorsManager.mainPurple.withValues(alpha: 0.1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.tune_rounded,
                        color: ColorsManager.mainPurple,
                        size: 16.sp,
                      ),
                      horizontalSpace(4),
                      Text(
                        'Filters',
                        style: TextStyles.font13PurpleSemiBold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        if (activeFilters.isNotEmpty) verticalSpace(10),

        // Scrollable filters with clear all as first item
        if (activeFilters.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Clear All Button as first filter chip
                Padding(
                  padding: EdgeInsets.only(right: 6.w, left: 16.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorsManager.mainPurple.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color:
                              ColorsManager.mainPurple.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onClearAll,
                        borderRadius: BorderRadius.circular(20.r),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 11.h,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.replay_outlined,
                                size: 16.sp,
                                color: ColorsManager.mainPurple,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Active filter chips
                ...activeFilters.entries.map((filter) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: GestureDetector(
                      onTap: onOpenFilters,
                      child: TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 300),
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: child,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorsManager.lighterPurple,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: ColorsManager.mainPurple
                                    .withValues(alpha: 0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.only(
                            left: 10.w,
                            right: 8.w,
                            top: 8.h,
                            bottom: 8.h,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _getFilterIcon(filter.key),
                              horizontalSpace(6),
                              Text(
                                _getFilterDisplayText(filter.key, filter.value),
                                style: TextStyles.font13DarkPurpleMedium,
                              ),
                              horizontalSpace(4),
                              Container(
                                margin: EdgeInsets.only(left: 4.w),
                                decoration: const BoxDecoration(
                                  color: ColorsManager.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => onRemoveFilter(filter.key),
                                    customBorder: const CircleBorder(),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.w),
                                      child: Icon(
                                        Icons.close_rounded,
                                        size: 16.sp,
                                        color: ColorsManager.mainPurple,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
      ],
    );
  }

  Widget _getFilterIcon(String filterKey) {
    final IconData icon;
    switch (filterKey) {
      case 'sort':
        icon = Icons.star_border;
        break;
      case 'minStickers':
        icon = Icons.emoji_emotions_outlined;
        break;
      case 'searchBy':
        icon = Icons.search_rounded;
        break;
      case 'stickerType':
        icon = Icons.motion_photos_on_rounded;
        break;
      default:
        icon = Icons.filter_alt_rounded;
    }
    return Icon(
      icon,
      size: 16.sp,
      color: ColorsManager.mainPurple,
    );
  }

  Map<String, dynamic> _getActiveFilters() {
    // Define default values
    const defaultValues = {
      'sort': null,
      'minStickers': 5.0,
      'searchBy': 'all',
      'stickerType': 'both'
    };

    return Map.fromEntries(
      filters.entries.where((entry) {
        // Skip null values
        if (entry.value == null) return false;

        // Compare with default values
        final defaultValue = defaultValues[entry.key];
        if (defaultValue == entry.value) return false;

        // Handle special cases
        switch (entry.key) {
          case 'minStickers':
            // If it's an int, convert to double for comparison
            final valueAsDouble =
                entry.value is int ? entry.value.toDouble() : entry.value;
            return valueAsDouble != defaultValue;

          case 'searchBy':
            return entry.value != 'all';

          case 'stickerType':
            return entry.value != 'both';

          default:
            return true;
        }
      }),
    );
  }

  String _getFilterDisplayText(String key, dynamic value) {
    switch (key) {
      case 'sort':
        return value.toString();
      case 'minStickers':
        return '${value.round()} Stickers';
      case 'searchBy':
        return value == 'pack' ? 'Pack Name' : 'Creator';
      case 'stickerType':
        return value.toString().capitalizeFirst()!;
      default:
        return value.toString();
    }
  }
}
