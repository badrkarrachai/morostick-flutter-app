import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/images.dart';
import 'package:morostick/core/theming/text_styles.dart';

class PackOutsidePreview extends StatelessWidget {
  final String? userImageUrl;
  final String title;
  final String author;
  final int downloads;
  final String timeAgo;
  final List<String> stickerPreviews;
  final VoidCallback onAddPressed;

  const PackOutsidePreview({
    super.key,
    this.userImageUrl,
    required this.title,
    required this.author,
    required this.downloads,
    required this.timeAgo,
    required this.stickerPreviews,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            children: [
              // Title and Details
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppCachedImageExtensions.avatar(
                      size: 31.w,
                      imageUrl: userImageUrl ??
                          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/Badr2.jpg',
                    ),
                    horizontalSpace(8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title with red dot
                        Row(
                          children: [
                            Text(
                              title,
                              style: TextStyles.font14DarkPurpleSemiBold,
                            ),
                            SizedBox(width: 8.w),
                          ],
                        ),
                        verticalSpace(2),
                        // Author and Downloads
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              author,
                              style: TextStyles.font11GrayPurpleRegular,
                            ),
                            Text(
                              ' • ',
                              style: TextStyles.font11GrayPurpleRegular,
                            ),
                            Text(
                              '${downloads / 1000}K ',
                              style: TextStyles.font11GrayPurpleRegular,
                            ),
                            Icon(
                              HugeIcons.strokeRoundedDownloadCircle01,
                              size: 13.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Add Button
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: ColorsManager.whatsappGreen
                      .withOpacity(0.2), // WhatsApp green color
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      Images.whatsappLogo,
                      width: 15.w,
                      height: 15.w,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Add',
                      style: TextStyles.font13DarkPurpleSemiBold.copyWith(
                        color: ColorsManager.darkPurple,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Stickers Preview
          SizedBox(height: 10.h),
          SizedBox(
            height: 64.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                stickerPreviews.length,
                (index) => StickerPreview(
                  imageUrl: stickerPreviews[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StickerPreview extends StatelessWidget {
  final String imageUrl;

  const StickerPreview({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.w,
      height: 64.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: AppCachedImageExtensions.thumbnail(
        imageUrl: imageUrl,
      ),
    );
  }
}
