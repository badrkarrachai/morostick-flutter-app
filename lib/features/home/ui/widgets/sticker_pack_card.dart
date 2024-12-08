import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
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
                child: CachedNetworkImage(
                  width: 110.w,
                  height: 110.h,
                  imageUrl: stickerPack.imageUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Container(
                    color: ColorsManager.mainPurple.withOpacity(0.1),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.mainPurple,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
