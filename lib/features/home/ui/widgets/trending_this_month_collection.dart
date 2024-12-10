import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/home/ui/widgets/recommended_packs_carousel.dart';

class TrendingThisMonthCollection extends StatelessWidget {
  const TrendingThisMonthCollection({super.key});

  static final List<StickerPack> trendingPacks = [
    const StickerPack(
      title: 'Reaction Cat',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/pngwing.com.png',
      stickerCount: 7,
    ),
    const StickerPack(
      title: 'Dodge Dog',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/pngwing.com%20(6).png',
      stickerCount: 12,
    ),
    const StickerPack(
      title: 'Mr Bean',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/pngwing.com%20(7).png',
      stickerCount: 15,
    ),
    const StickerPack(
      title: 'Chef Salt',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/pngwing.com%20(8).png',
      stickerCount: 15,
    ),
    const StickerPack(
      title: 'Reaction Girl',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/pngwing.com%20(5).png',
      stickerCount: 15,
    ),
    // Add more packs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w, bottom: 12.h),
          child: Text(
            'Trending This Month',
            style: TextStyles.font14DarkPurpleSemiBold,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: IntrinsicHeight(
            child: Row(
              children: trendingPacks
                  .map((pack) => TrendingPackCard(pack: pack))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }
}

class TrendingPackCard extends StatelessWidget {
  final StickerPack pack;

  const TrendingPackCard({
    super.key,
    required this.pack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.0.w, left: 5.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container
          Container(
            height: 95.w, // Square aspect ratio
            width: 95.w,
            decoration: BoxDecoration(
              color: ColorsManager.getRandomColorWithOpacity(0.2),
              borderRadius: BorderRadius.circular(16.r),
            ),
            padding: EdgeInsets.all(10.w),
            child: AppCachedImageExtensions.thumbnail(
              imageUrl: pack.imageUrl,
            ),
          ),
          verticalSpace(8),
          // Title
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Text(
              pack.title,
              style: TextStyles.font13DarkPurpleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Sticker count
          Padding(
            padding: EdgeInsets.only(left: 4.w, top: 2.h),
            child: Text(
              '${pack.stickerCount} stickers',
              style: TextStyles.font11GrayPurpleRegular,
            ),
          ),
        ],
      ),
    );
  }
}
