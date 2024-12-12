import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/text_styles.dart';

class DeleteAccountDialog extends StatelessWidget {
  final VoidCallback onConfirmDelete;

  const DeleteAccountDialog({
    super.key,
    required this.onConfirmDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Text(
        'Delete Account',
        style: TextStyles.font18BlackSemiBold.copyWith(
          color: Colors.red,
        ),
      ),
      content: Text(
        'Are you sure you want to delete your account? This action will delete all your data and cannot be undone after 30 days.',
        style: TextStyles.font14RegularGray,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyles.font14DarkPurpleMedium,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirmDelete();
          },
          child: Text(
            'Delete',
            style: TextStyles.font14DarkPurpleMedium.copyWith(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
