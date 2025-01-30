import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/features/search/data/models/trending_searches_response.dart';
import 'package:morostick/features/search/logic/search_cubit.dart';

class TrendingSearchesWidget extends StatelessWidget {
  final List<TrendingSearchItem> items;

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
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 3.5,
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
  final TrendingSearchItem item;

  const TrendingItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SearchCubit>().searchController.text = item.name;
        context.read<SearchCubit>().addSearch(item.name.trim());
        context.read<SearchCubit>().submitSearch(item.name.trim());
        context.read<SearchCubit>().setSearchResultsScreenShowing(true);
      },
      child: Container(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          color: ColorsManager.grayInputBackground,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            AppCachedNetworkImage(
              imageUrl: item.previewSticker.webpUrl,
              width: 40.w,
              height: 40.w,
              borderRadius: BorderRadius.circular(8.r),
            ),
            horizontalSpace(5),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: TextStyles.font14DarkPurpleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (item.isHot)
                    Icon(
                      HugeIcons.strokeRoundedArrowUpRight01,
                      color: ColorsManager.mainPurple,
                      size: 16.w,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
