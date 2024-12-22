import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/widgets/app_broken_widgets.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/home/data/models/for_you_tab_response.dart';

class TrendingThisMonthCollection extends StatelessWidget {
  final List<StickerPack> trendingPacks;
  final VoidCallback? onSeeAllPressed;
  final void Function(StickerPack pack)? onPackTapped;

  const TrendingThisMonthCollection({
    super.key,
    required this.trendingPacks,
    this.onSeeAllPressed,
    this.onPackTapped,
  });

  @override
  Widget build(BuildContext context) {
    if (trendingPacks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending This Month',
                style: TextStyles.font14DarkPurpleSemiBold,
              ),
              GestureDetector(
                onTap: onSeeAllPressed,
                child: Text(
                  'See All',
                  style: TextStyles.font13DarkPurpleMedium.copyWith(
                    color: ColorsManager.mainPurple,
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: List.generate(
              trendingPacks.length,
              (index) => Padding(
                padding: EdgeInsets.only(
                  right: index != trendingPacks.length - 1 ? 15.w : 0,
                ),
                child: TrendingPackCard(
                  pack: trendingPacks[index],
                  onTap: onPackTapped != null
                      ? () => onPackTapped!(trendingPacks[index])
                      : null,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class TrendingPackCard extends StatelessWidget {
  final StickerPack pack;
  final VoidCallback? onTap;

  const TrendingPackCard({
    super.key,
    required this.pack,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStickerPreview(),
          verticalSpace(8.h),
          _buildPackInfo(),
        ],
      ),
    );
  }

  Widget _buildStickerPreview() {
    return Hero(
      tag: 'trending_pack_${pack.id}',
      child: Container(
        height: 95.w,
        width: 95.w,
        decoration: BoxDecoration(
          color:
              StickerPackColorManager.getColorWithOpacityForPack(pack.id, 0.2),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(10.w),
        child: pack.previewStickers.isNotEmpty
            ? AppCachedImageExtensions.thumbnail(
                imageUrl: pack.previewStickers.first.webpUrl,
                borderRadius: BorderRadius.circular(8.r),
              )
            : Center(
                child: brokenPackImage(),
              ),
      ),
    );
  }

  Widget _buildPackInfo() {
    return SizedBox(
      width: 95.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pack.name,
            style: TextStyles.font13DarkPurpleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpace(2.h),
          Row(
            children: [
              Text(
                '${pack.totalStickers} stickers',
                style: TextStyles.font11GrayPurpleRegular,
              ),
              if (pack.isAnimatedPack) ...[
                horizontalSpace(4.w),
                Icon(
                  Icons.animation,
                  size: 12.sp,
                  color: ColorsManager.grayPurple,
                ),
              ],
              if (pack.stats.favorites > 0) ...[
                horizontalSpace(4.w),
                brokenPackImage(),
                horizontalSpace(2.w),
                Text(
                  '${pack.stats.favorites}',
                  style: TextStyles.font11GrayPurpleRegular,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
