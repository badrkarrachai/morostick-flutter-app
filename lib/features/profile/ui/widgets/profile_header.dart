import 'package:flutter/material.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/features/profile/ui/widgets/image_edit_button.dart';

class ProfileHeader extends StatelessWidget {
  final String coverImageUrl;
  final String profileImageUrl;
  final VoidCallback onCoverImageTap;
  final VoidCallback onProfileImageTap;

  const ProfileHeader({
    super.key,
    required this.coverImageUrl,
    required this.profileImageUrl,
    required this.onCoverImageTap,
    required this.onProfileImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _CoverImage(
          imageUrl: coverImageUrl,
          onTap: onCoverImageTap,
        ),
        _ProfileImage(
          imageUrl: profileImageUrl,
          onTap: onProfileImageTap,
        ),
      ],
    );
  }
}

class _CoverImage extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  const _CoverImage({
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsManager.mainPurple.withOpacity(0.1),
      ),
      child: Stack(
        children: [
          AppCachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, url, error) => Center(
              child: Icon(
                Icons.image_outlined,
                color: ColorsManager.mainPurple,
                size: 40.sp,
              ),
            ),
          ),
          Positioned(
            bottom: 16.h,
            right: 16.w,
            child: ImageEditButton(
              onTap: onTap,
              icon: Icons.camera_alt_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  const _ProfileImage({
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -50.h,
      left: 24.w,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: ColorsManager.white,
            width: 4.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundColor: ColorsManager.lighterPurple,
              child: ClipOval(
                child: AppCachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 100.w,
                  height: 100.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, url, error) => Icon(
                    Icons.person_outline_rounded,
                    color: ColorsManager.mainPurple,
                    size: 40.sp,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ImageEditButton(
                onTap: onTap,
                icon: Icons.camera_alt_outlined,
                size: 32.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
