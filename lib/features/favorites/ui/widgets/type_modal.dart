import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showWhatsAppStickerTypeModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => const WhatsAppStickerTypeSelector(),
  );
}

class WhatsAppStickerTypeSelector extends StatelessWidget {
  const WhatsAppStickerTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0.w),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          _buildOptions(context),
          _buildCancelButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorsManager.lightGray,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ColorsManager.lightGray,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          verticalSpace(16),
          Text(
            'Add Stickers to WhatsApp',
            style: TextStyles.font18BlackSemiBold,
          ),
          verticalSpace(8),
          Text(
            'Choose which type of stickers to add',
            style: TextStyles.font14RegularGray,
          ),
        ],
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          _buildOptionCard(
            context,
            title: 'Regular Stickers',
            description: 'Static stickers for everyday use',
            icon: Icons.emoji_emotions_outlined,
            count: 25,
            onTap: () => _handleSelection(context, isAnimated: false),
          ),
          verticalSpace(12),
          _buildOptionCard(
            context,
            title: 'Animated Stickers',
            description: 'Moving stickers for extra expression',
            icon: Icons.motion_photos_on_rounded,
            count: 15,
            isAnimated: true,
            onTap: () => _handleSelection(context, isAnimated: true),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required int count,
    bool isAnimated = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: ColorsManager.lighterPurple.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: ColorsManager.mainPurple.withOpacity(0.1),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: ColorsManager.mainPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: ColorsManager.mainPurple,
                size: 24.sp,
              ),
            ),
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyles.font16DarkPurpleSemiBold,
                      ),
                      if (isAnimated) ...[
                        horizontalSpace(8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorsManager.mainPurple,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            'GIF',
                            style: TextStyles.font13GrayWhiteRegular,
                          ),
                        ),
                      ],
                    ],
                  ),
                  verticalSpace(4),
                  Text(
                    description,
                    style: TextStyles.font13GrayPurpleRegular,
                  ),
                  verticalSpace(4),
                  Text(
                    '$count stickers',
                    style: TextStyles.font13PurpleRegular,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: ColorsManager.mainPurple,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: AppButton(
        buttonText: 'Cancel',
        textStyle: TextStyles.font16DarkPurpleSemiBold,
        onPressed: () => Navigator.pop(context),
        backgroundColor: ColorsManager.lighterPurple,
        borderColor: ColorsManager.mainPurple.withOpacity(0.1),
      ),
    );
  }

  void _handleSelection(BuildContext context, {required bool isAnimated}) {
    Navigator.pop(context);
    // Implement the WhatsApp addition logic here based on the selection
  }
}
