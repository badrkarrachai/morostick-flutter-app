import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/helpers/number_and_text_formatter.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/images.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/pack/ui/pack_screen.dart';

class PackOutsidePreview extends StatelessWidget {
  final String? userImageUrl;
  final String title;
  final String author;
  final int downloads;
  final String timeAgo;
  final List<String> stickerPreviews;
  final VoidCallback onAddPressed;
  final Widget? actionButton;

  const PackOutsidePreview({
    super.key,
    this.userImageUrl,
    required this.title,
    required this.author,
    required this.downloads,
    required this.timeAgo,
    required this.stickerPreviews,
    required this.onAddPressed,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PackScreen(),
          ),
        );
      },
      child: Container(
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
                            'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/ProfileScreen/NoProfileImage.png',
                      ),
                      horizontalSpace(8),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 0.6.sw),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              title,
                              style: TextStyles.font14DarkPurpleSemiBold,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(width: 8.w),
                            verticalSpace(2),
                            // Author and Downloads
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  '${NumberFormatter.formatCount(downloads)} ',
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
                      ),
                    ],
                  ),
                ),
                // Add Button
                actionButton ??
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorsManager.whatsappGreen
                            .withValues(alpha: 0.2), // WhatsApp green color
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
                children: [
                  ...List.generate(
                    stickerPreviews.length > 5 ? 5 : stickerPreviews.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(left: index == 0 ? 0 : 3.w),
                      child: StickerPreview(
                        imageUrl: stickerPreviews[index],
                      ),
                    ),
                  ),
                  // Fill remaining slots with empty boxes if less than 5 items
                  if (stickerPreviews.length < 5)
                    ...List.generate(
                      5 - stickerPreviews.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(left: 3.w),
                        child: Container(
                          width: 64.w,
                          height: 64.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.transparent,
                          ),
                        ),
                      ),
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
