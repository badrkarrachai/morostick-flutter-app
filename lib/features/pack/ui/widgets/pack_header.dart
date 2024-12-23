import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';

class PackHeader extends StatelessWidget {
  final String packName;
  final int downloads;
  final int favorites;
  final String mainStickerUrl;

  const PackHeader({
    super.key,
    required this.packName,
    required this.downloads,
    required this.favorites,
    required this.mainStickerUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorsManager.mainPurple,
            ColorsManager.mainPurple.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.mainPurple.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20.w,
            top: -20.h,
            child: Transform.rotate(
              angle: -0.2,
              child: Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                // Main Sticker Preview
                Container(
                  width: 80.w,
                  height: 80.w,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: AppCachedNetworkImage(
                    imageUrl: mainStickerUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, url, error) => Icon(
                      Icons.emoji_emotions_outlined,
                      color: ColorsManager.mainPurple,
                      size: 32.sp,
                    ),
                  ),
                ),
                horizontalSpace(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        packName,
                        style: TextStyles.font18BlackSemiBold.copyWith(
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpace(8),
                      Row(
                        children: [
                          _buildStatistic(
                            icon: HugeIcons.strokeRoundedDownloadCircle01,
                            count: downloads,
                          ),
                          horizontalSpace(16),
                          _buildStatistic(
                            icon: Icons.favorite_outline,
                            count: favorites,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistic({
    required IconData icon,
    required int count,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 16.sp,
        ),
        horizontalSpace(4),
        Text(
          _formatNumber(count),
          style: TextStyles.font13GrayWhiteRegular,
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
