import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/widgets/app_shimmer_loading.dart';
import 'package:morostick/features/profile/ui/widgets/image_edit_button.dart';

class ProfileHeader extends StatelessWidget {
  final String? coverImageUrl;
  final String profileImageUrl;
  final VoidCallback onCoverImageTap;
  final VoidCallback onProfileImageTap;
  final bool isLoadingProfileImage;
  final bool isLoadingCoverImage;

  const ProfileHeader({
    super.key,
    required this.coverImageUrl,
    required this.profileImageUrl,
    required this.onCoverImageTap,
    required this.onProfileImageTap,
    required this.isLoadingProfileImage,
    required this.isLoadingCoverImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Cover image container with fixed height
        GestureDetector(
          onTap: onCoverImageTap,
          child: Container(
            height: 180.h,
            width: screenW,
            decoration: BoxDecoration(
              color: ColorsManager.mainPurple.withValues(alpha: 0.1),
            ),
            child: Stack(
              children: [
                if (isLoadingCoverImage)
                  AppShimmerLoading(
                    child: Container(
                      color: ColorsManager.lighterPurple,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                // Cover image
                if (!isLoadingCoverImage)
                  AppCachedNetworkImage(
                    imageUrl: coverImageUrl ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorWidget: Center(child: SizedBox()),
                  ),
                // Cover edit button
                if (!isLoadingCoverImage)
                  Positioned(
                    bottom: 16.h,
                    right: 16.w,
                    child: ImageEditButton(
                      onTap: onCoverImageTap,
                      size: 36.w,
                      icon: Icons.camera_alt_outlined,
                    ),
                  ),
              ],
            ),
          ),
        ),
        // Profile image and content section
        Transform.translate(
          offset: Offset(-110, -52.h),
          child: _StandaloneProfileImage(
            imageUrl: profileImageUrl,
            onTap: onProfileImageTap,
            onEditTap: onProfileImageTap,
            isLoading: isLoadingProfileImage,
          ),
        ),
      ],
    );
  }
}

// New standalone widget for profile image
class _StandaloneProfileImage extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;
  final VoidCallback onEditTap;
  final bool isLoading;

  const _StandaloneProfileImage({
    required this.imageUrl,
    required this.onTap,
    required this.onEditTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorsManager.white,
              width: 4.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              if (isLoading)
                AppShimmerLoading(
                  child: CircleAvatar(
                    radius: 50.r,
                    backgroundColor: ColorsManager.lighterPurple,
                    child: ClipOval(
                      child: SizedBox(
                        width: 100.w,
                        height: 100.w,
                      ),
                    ),
                  ),
                ),
              if (!isLoading)
                CircleAvatar(
                  radius: 50.r,
                  backgroundColor: ColorsManager.lighterPurple,
                  child: ClipOval(
                    child: AppCachedNetworkImage(
                      imageUrl: imageUrl,
                      width: 100.w,
                      height: 100.w,
                      fit: BoxFit.cover,
                      errorWidget: Icon(
                        Icons.person_outline_rounded,
                        color: ColorsManager.mainPurple,
                        size: 40.sp,
                      ),
                    ),
                  ),
                ),
              if (!isLoading)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: onEditTap,
                      child: ImageEditButton(
                        onTap: onEditTap,
                        icon: Icons.camera_alt_outlined,
                        size: 32.w,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
