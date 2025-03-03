import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/features/pack/ui/widgets/pack_option_tile.dart';

class ProfileImagesOptionsBottomSheet extends StatelessWidget {
  final VoidCallback onUpload;
  final VoidCallback onDelete;
  final String imageType;

  const ProfileImagesOptionsBottomSheet({
    super.key,
    required this.onUpload,
    required this.onDelete,
    required this.imageType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpace(8),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ColorsManager.lightGray,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          verticalSpace(16),
          PackOptionTile(
            icon: Icons.file_upload_outlined,
            title:
                'Upload ${imageType == "avatar" ? "Profile Image" : "Cover Image"}',
            onTap: onUpload,
          ),
          PackOptionTile(
            icon: Icons.delete_outlined,
            title:
                'Delete ${imageType == "avatar" ? "Profile Image" : "Cover Image"}',
            isDestructive: true,
            onTap: onDelete,
          ),
          verticalSpace(16),
        ],
      ),
    );
  }
}
