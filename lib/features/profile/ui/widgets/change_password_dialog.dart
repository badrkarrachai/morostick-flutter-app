import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_text_form_field.dart';

class ChangePasswordDialog extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onUpdatePressed;

  const ChangePasswordDialog({
    super.key,
    required this.formKey,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.onUpdatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Change Password',
              style: TextStyles.font18BlackSemiBold,
            ),
            verticalSpace(24),
            AppTextFormField(
              controller: currentPasswordController,
              hintText: 'Current Password',
              isObscureText: true,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Current password is required';
                }
                return null;
              },
            ),
            verticalSpace(16),
            AppTextFormField(
              controller: newPasswordController,
              hintText: 'New Password',
              isObscureText: true,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'New password is required';
                if (value!.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            verticalSpace(16),
            AppTextFormField(
              controller: confirmPasswordController,
              hintText: 'Confirm New Password',
              isObscureText: true,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please confirm your password';
                }
                if (value != newPasswordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            verticalSpace(24),
            _buildDialogActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyles.font14DarkPurpleMedium,
          ),
        ),
        horizontalSpace(8),
        ElevatedButton(
          onPressed: onUpdatePressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.mainPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(
            'Update',
            style: TextStyles.font14WhiteSemiBold,
          ),
        ),
      ],
    );
  }
}
