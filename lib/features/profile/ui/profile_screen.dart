import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/services/user_service.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_button.dart';
import 'package:morostick/core/widgets/app_snackbar.dart';
import 'package:morostick/features/profile/logic/profile_cubit.dart';
import 'package:morostick/features/profile/ui/widgets/change_password_dialog.dart';
import 'package:morostick/features/profile/ui/widgets/danger_zone.dart';
import 'package:morostick/features/profile/ui/widgets/delete_account_dialog.dart';
import 'package:morostick/features/profile/ui/widgets/profile_form.dart';
import 'package:morostick/features/profile/ui/widgets/profile_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/features/profile/ui/widgets/profile_images_options_bottomsheet.dart';
import 'package:toastification/toastification.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final bool _isEmailVerified =
      getIt<UserService>().currentUser?.emailVerified ?? false;
  bool _isEditingName = true;
  bool _isEditingEmail =
      getIt<UserService>().currentUser?.emailVerified == false;

  late ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = context.read<ProfileCubit>();

    // Initialize controllers with data from Cubit
    final userState = _profileCubit.state;
    _nameController = TextEditingController(text: userState.name);
    _emailController = TextEditingController(text: userState.email);

    // Listen to controller changes to update Cubit state
    _nameController.addListener(_onNameChanged);
    _emailController.addListener(_onEmailChanged);
  }

  void _onNameChanged() {
    _profileCubit.updateNameLocally(_nameController.text);
  }

  void _onEmailChanged() {
    _profileCubit.updateEmailLocally(_emailController.text);
  }

  Future<void> _pickAndUploadProfileImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedImage != null) {
        final File imageFile = File(pickedImage.path);

        // Check file extension before uploading
        final String extension = pickedImage.path.split('.').last.toLowerCase();
        if (!['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(extension)) {
          showAppSnackbar(
            title: 'Invalid Format',
            duration: 3,
            type: ToastificationType.error,
            description:
                'Please select an image in jpg, jpeg, png, gif, or webp format',
          );
          return;
        }

        // Upload the image using the ProfileCubit
        _profileCubit.updateUserAvatar(imageFile);
      }
    } catch (e) {
      showAppSnackbar(
        title: 'Error',
        duration: 3,
        type: ToastificationType.error,
        description: 'Failed to pick image: ${e.toString()}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.maybeMap(
          success: (_) {
            showAppSnackbar(
              title: 'Profile updated successfully!',
              duration: 3,
              type: ToastificationType.success,
              description: 'Your profile has been updated successfully!',
            );
          },
          error: (state) {
            showAppSnackbar(
              title: state.error.message ?? 'Error',
              duration: 3,
              type: ToastificationType.error,
              description:
                  state.error.error?.details ?? 'Failed to update profile',
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        bool isLoading = false;
        state.maybeMap(
          loading: (_) => isLoading = true,
          orElse: () {},
        );

        // Get avatar URL from state or user service as fallback
        final avatarUrl = state.avatarUrl ??
            getIt<UserService>().currentUser?.avatar?.url ??
            'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/ProfileScreen/NoProfileImage.png';

        return Scaffold(
          backgroundColor: ColorsManager.backgroundLightColor,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 120.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ProfileHeader(
                          coverImageUrl:
                              getIt<UserService>().currentUser?.coverImage?.url,
                          profileImageUrl: avatarUrl,
                          onCoverImageTap: () {
                            // Handle cover image update
                          },
                          isLoadingProfileImage: isLoading,
                          onProfileImageTap: () {
                            if (isLoading) {
                              return;
                            }
                            _showOptionsBottomSheet(context);
                          },
                        ),
                        ProfileForm(
                          nameController: _nameController,
                          emailController: _emailController,
                          isEmailVerified: _isEmailVerified,
                          isEditingName: _isEditingName,
                          isEditingEmail: _isEditingEmail,
                          onNameEditTap: () =>
                              setState(() => _isEditingName = !_isEditingName),
                          onEmailEditTap: () => setState(
                              () => _isEditingEmail = !_isEditingEmail),
                          onEmailVerifyTap: () {
                            // Handle email verification
                          },
                          onChangePasswordTap: _showChangePasswordDialog,
                          nameValidator: (value) {
                            if (value?.isEmpty ?? true)
                              return 'Name is required';
                            return null;
                          },
                          emailValidator: (value) {
                            if (value?.isEmpty ?? true)
                              return 'Email is required';
                            if (!value!.contains('@')) return 'Invalid email';
                            return null;
                          },
                        ),
                        DangerZone(
                          onDeleteTap: _showDeleteAccountDialog,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: AppButton(
                    buttonText: 'Apply Changes',
                    textStyle: TextStyles.font16WhiteSemiBold,
                    onPressed: () {
                      if (isLoading) return;
                      if (_formKey.currentState?.validate() ?? false) {
                        // Call the Cubit to update the user profile
                        _profileCubit.updateUserProfile();
                      }
                    },
                    borderColor: ColorsManager.mainPurple,
                    backgroundColor: ColorsManager.mainPurple,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ProfileImagesOptionsBottomSheet(
        onUpload: () {
          context.pop();
          _pickAndUploadProfileImage();
        },
        onDelete: () {
          context.pop();
        },
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => ChangePasswordDialog(
        formKey: _formKey,
        currentPasswordController: _currentPasswordController,
        newPasswordController: _newPasswordController,
        confirmPasswordController: _confirmPasswordController,
        onUpdatePressed: () {},
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => DeleteAccountDialog(
        onConfirmDelete: () {},
      ),
    );
  }

  @override
  void dispose() {
    _nameController.removeListener(_onNameChanged);
    _emailController.removeListener(_onEmailChanged);
    _nameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
