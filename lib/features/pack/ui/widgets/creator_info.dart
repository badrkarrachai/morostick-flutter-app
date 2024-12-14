import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';

class CreatorInfo extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int followers;
  final bool isVerified;
  final bool isFollowing;
  final VoidCallback onFollowTap;
  final VoidCallback onCreatorTap;

  const CreatorInfo({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.followers,
    this.isVerified = false,
    this.isFollowing = false,
    required this.onFollowTap,
    required this.onCreatorTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 5.h, bottom: 10.h),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
            color: ColorsManager.lighterGray,
            borderRadius: BorderRadius.all(Radius.circular(16.r))),
        child: InkWell(
          onTap: onCreatorTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Row(
            children: [
              AppCachedImageExtensions.avatar(
                imageUrl: imageUrl,
                size: 40.w,
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyles.font14DarkPurpleSemiBold,
                        ),
                        // if (isVerified) ...[
                        //   horizontalSpace(4),
                        //   Icon(
                        //     Icons.verified_rounded,
                        //     color: ColorsManager.mainPurple,
                        //     size: 16.sp,
                        //   ),
                        // ],
                      ],
                    ),
                    // verticalSpace(2),
                    // Text(
                    //   _formatFollowers(followers),
                    //   style: TextStyles.font13GrayPurpleRegular,
                    // ),
                  ],
                ),
              ),
              // TextButton(
              //   onPressed: onFollowTap,
              //   style: TextButton.styleFrom(
              //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              //     backgroundColor: isFollowing
              //         ? Colors.transparent
              //         : ColorsManager.lighterPurple,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20.r),
              //       side: BorderSide(
              //         color: isFollowing
              //             ? ColorsManager.mainPurple
              //             : Colors.transparent,
              //         width: 1,
              //       ),
              //     ),
              //   ),
              //   child: Text(
              //     isFollowing ? 'Following' : 'Follow',
              //     style: isFollowing
              //         ? TextStyles.font13PurpleRegular
              //         : TextStyles.font13PurpleSemiBold,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatFollowers(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M followers';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K followers';
    }
    return '$count followers';
  }
}
