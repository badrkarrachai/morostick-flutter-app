import 'package:flutter/material.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/features/home/ui/widgets/recommended_packs_carousel.dart';

class StickerPackCard extends StatelessWidget {
  final StickerPack stickerPack;
  final EdgeInsetsGeometry? margin;

  const StickerPackCard({
    super.key,
    required this.stickerPack,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: stickerPack.backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: AppCachedImageExtensions.thumbnail(
                  width: 110.w,
                  height: 110.h,
                  imageUrl: stickerPack.imageUrl,
                ),
              ),
              horizontalSpace(20),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      stickerPack.title.replaceAll(' ', '\n').toUpperCase(),
                      style: TextStyles.font23WhiteSemiBold,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${stickerPack.stickerCount} STICKERS',
                      style: TextStyles.font13GrayWhiteRegular,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
