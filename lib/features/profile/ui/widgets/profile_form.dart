import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/widgets/app_text_form_field.dart';

class ProfileForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final bool isEmailVerified;
  final bool isEditingName;
  final bool isEditingEmail;
  final VoidCallback onNameEditTap;
  final VoidCallback onEmailEditTap;
  final VoidCallback onEmailVerifyTap;
  final VoidCallback onChangePasswordTap;
  final Function(String?) nameValidator;
  final Function(String?) emailValidator;

  const ProfileForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.isEmailVerified,
    required this.isEditingName,
    required this.isEditingEmail,
    required this.onNameEditTap,
    required this.onEmailEditTap,
    required this.onEmailVerifyTap,
    required this.onChangePasswordTap,
    required this.nameValidator,
    required this.emailValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 70.h, 20.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile Information',
            style: TextStyles.font16BlackSemiBold,
          ),
          verticalSpace(24),
          _buildNameField(),
          verticalSpace(16),
          _buildEmailField(),
          if (!isEmailVerified) ...[
            verticalSpace(8),
            _buildEmailVerification(),
          ],
          verticalSpace(24),
          _buildPasswordSection(),
          verticalSpace(16),
          _buildInfoText()
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return AppTextFormField(
      controller: nameController,
      hintText: 'Full Name',
      isEnabled: isEditingName,
      validator: nameValidator,
      prefixIcon: Icon(Icons.person_outline, size: 20.sp),
    );
  }

  Widget _buildEmailField() {
    return AppTextFormField(
      controller: emailController,
      hintText: 'Email Address',
      isEnabled: isEditingEmail,
      validator: emailValidator,
      prefixIcon: Icon(Icons.email_outlined, size: 20.sp),
    );
  }

  Widget _buildEmailVerification() {
    return InkWell(
      onTap: onEmailVerifyTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: ColorsManager.lighterPurple,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: ColorsManager.mainPurple,
              size: 20.sp,
            ),
            horizontalSpace(8),
            Text(
              'Verify your email',
              style: TextStyles.font13PurpleRegular,
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColorsManager.mainPurple,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordSection() {
    return InkWell(
      onTap: onChangePasswordTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 1, color: ColorsManager.grayButtonBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: ColorsManager.lighterPurple,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.lock_outline_rounded,
                color: ColorsManager.mainPurple,
                size: 20.sp,
              ),
            ),
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Change Password',
                    style: TextStyles.font14DarkPurpleMedium,
                  ),
                  Text(
                    'Last changed 3 months ago',
                    style: TextStyles.font13GrayPurpleRegular,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColorsManager.mainPurple,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: ColorsManager.lighterPurple,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: ColorsManager.mainPurple.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: ColorsManager.mainPurple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.visibility_outlined,
                  color: ColorsManager.mainPurple,
                  size: 20.sp,
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Public Information',
                      style: TextStyles.font14DarkPurpleSemiBold,
                    ),
                    verticalSpace(4),
                    Text(
                      'Your name, profile picture, and cover photo will be visible to other users. Your email address will remain private and secure.',
                      style: TextStyles.font13GrayPurpleRegular,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        verticalSpace(24),
      ],
    );
  }
}
