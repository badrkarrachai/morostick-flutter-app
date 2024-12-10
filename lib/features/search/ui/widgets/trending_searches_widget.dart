import 'package:flutter/material.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/search/ui/search_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrendingSearchesWidget extends StatelessWidget {
  final List<TrendingItem> items;

  const TrendingSearchesWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trending Searches', style: TextStyles.font14RegularGray),
        verticalSpace(16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 2.5,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) =>
              TrendingItemWidget(item: items[index]),
        ),
      ],
    );
  }
}

class TrendingItemWidget extends StatelessWidget {
  final TrendingItem item;

  const TrendingItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: ColorsManager.grayInputBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          AppCachedNetworkImage(
            imageUrl: item.imageUrl,
            width: 40.w,
            height: 40.w,
            borderRadius: BorderRadius.circular(8.r),
          ),
          horizontalSpace(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.title,
                  style: TextStyles.font14DarkPurpleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (item.isRising)
                  Icon(
                    Icons.trending_up,
                    color: ColorsManager.mainPurple,
                    size: 16.w,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
