import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/text_styles.dart';

class DangerZone extends StatelessWidget {
  final VoidCallback onDeleteTap;

  const DangerZone({
    super.key,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(16),
          _buildDeleteButton(),
        ],
      ),
    );
  }

  Widget _buildDeleteButton() {
    return InkWell(
      onTap: onDeleteTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.red.withOpacity(0.3),
            width: 1,
          ),
        ),
        padding: EdgeInsets.all(12.r),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                HugeIcons.strokeRoundedDelete02,
                color: Colors.red,
                size: 20.sp,
              ),
            ),
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delete Account',
                    style: TextStyles.font14DarkPurpleMedium.copyWith(
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    'This will delete all your data.',
                    style: TextStyles.font13GrayPurpleRegular.copyWith(
                      color: Colors.red.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.red,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
