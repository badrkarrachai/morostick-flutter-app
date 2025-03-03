import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/services/user_service.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_button.dart';
import 'package:morostick/core/widgets/app_message_box.dart';
import 'package:morostick/core/widgets/app_snackbar.dart';
import 'package:morostick/features/profile/logic/profile_cubit.dart';
import 'package:morostick/features/profile/ui/widgets/change_password_dialog.dart';
import 'package:morostick/features/profile/ui/widgets/danger_zone.dart';
import 'package:morostick/features/profile/ui/widgets/delete_account_dialog.dart';
import 'package:morostick/features/profile/ui/widgets/profile_form.dart';
import 'package:morostick/features/profile/ui/widgets/profile_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/features/profile/ui/widgets/profile_images_options_bottomsheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toastification/toastification.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // Check if an operation just completed (transitioning from loading to not loading)
        if (state.error != null) {
          showAppSnackbar(
            title: state.error?.message ?? 'Error',
            duration: 3,
            type: ToastificationType.error,
            description:
                state.error?.error?.details ?? 'Failed to update profile',
          );
        }
        if (state.didUpdateSuccessfully) {
          showAppSnackbar(
            title: 'Profile updated successfully!',
            duration: 3,
            type: ToastificationType.success,
            description: 'Your profile has been updated successfully!',
          );
          // Reset the flag
          context.read<ProfileCubit>().resetUpdateFlag();
        }
      },
      builder: (context, state) {
        final bool isLoading =
            state.isUpdatingProfile || state.isUpdatingAvatar;

        // Get avatar URL from state or default image as fallback
        final avatarUrl = state.avatarUrl != null && state.avatarUrl!.isNotEmpty
            ? state.avatarUrl!
            : 'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/ProfileScreen/NoProfileImage.png';

        return Scaffold(
          backgroundColor: ColorsManager.backgroundLightColor,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 200.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ProfileHeader(
                          coverImageUrl: state.coverImageUrl,
                          profileImageUrl: avatarUrl,
                          onCoverImageTap: () {
                            if (isLoading) {
                              return;
                            }
                            _showOptionsBottomSheet(context, 'cover');
                          },
                          isLoadingProfileImage: state.isUpdatingAvatar,
                          isLoadingCoverImage: state.isUploadingCoverImage,
                          onProfileImageTap: () {
                            if (isLoading) {
                              return;
                            }
                            _showOptionsBottomSheet(context, 'avatar');
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
                            if (value?.isEmpty ?? true) {
                              return 'Name is required';
                            }
                            return null;
                          },
                          emailValidator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Email is required';
                            }
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
              Transform.translate(
                offset: Offset(0, Platform.isIOS ? -50 : 0),
                child: Align(
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
              ),
            ],
          ),
        );
      },
    );
  }

  void _showOptionsBottomSheet(BuildContext context, String imageType) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ProfileImagesOptionsBottomSheet(
        imageType: imageType,
        onUpload: () {
          context.pop();
          _pickAndUploadImage(imageType);
        },
        onDelete: () {
          context.pop();
          AppMessageBoxDialogServiceNonContext.showConfirm(
            title: 'Confirm Action',
            message:
                'Are you sure you want to delete your ${imageType == "avatar" ? "profile picture" : "cover image"}?',
            confirmText: 'Yes, proceed',
            cancelText: 'No, cancel',
            onConfirm: () {
              _deleteUserAvatar(imageType);
            },
          );
        },
      ),
    );
  }

  void _deleteUserAvatar(String imageType) {
    if (imageType == 'avatar') {
      _profileCubit.deleteUserAvatar();
    } else if (imageType == 'cover') {
      _profileCubit.deleteUserCoverImage();
    }
  }

  Future<void> _pickAndUploadImage(String imageType) async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedImage != null) {
        // Check file extension
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

        // Define requirements based on image type
        final Map<String, dynamic> requirements = imageType == 'avatar'
            ? {
                'maxSize': 5 * 1024 * 1024, // 5MB
                'width': 1024, // Target width for avatar
                'height': 1024, // Target height for avatar (square)
                'name': 'Avatar',
                'aspectRatio': 1.0, // Square aspect ratio
              }
            : {
                'maxSize': 8 * 1024 * 1024, // 8MB
                'width': 2560, // Target width for cover
                'height': 1080, // Target height for cover
                'name': 'Cover image',
                'aspectRatio': 2560 / 1080, // Cover aspect ratio
              };

        // Allow user to crop the image using image_cropper package
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedImage.path,
          aspectRatio: CropAspectRatio(
            ratioX: requirements['aspectRatio'],
            ratioY: 1,
          ),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop ${requirements['name']}',
              toolbarColor: Theme.of(context).primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: imageType == 'avatar'
                  ? CropAspectRatioPreset.square
                  : CropAspectRatioPreset.ratio16x9,
              lockAspectRatio: true,
            ),
            IOSUiSettings(
              title: 'Crop ${requirements['name']}',
              aspectRatioLockEnabled: true,
              resetAspectRatioEnabled: false,
            ),
          ],
        );

        if (croppedFile == null) {
          // User canceled the cropping
          return;
        }

        // Read the cropped image
        File imageFile = File(croppedFile.path);
        final Uint8List imageBytes = await imageFile.readAsBytes();
        final img.Image? croppedImage = img.decodeImage(imageBytes);

        if (croppedImage == null) {
          showAppSnackbar(
            title: 'Error',
            duration: 3,
            type: ToastificationType.error,
            description: 'Failed to process image format',
          );
          return;
        }

        // Resize to target dimensions
        final img.Image resizedImage = img.copyResize(
          croppedImage,
          width: requirements['width'],
          height: requirements['height'],
          interpolation: img.Interpolation.average,
        );

        // Create temporary file for processed image
        final tempDir = await getTemporaryDirectory();
        final String outputFormat = 'jpg';
        final tempPath =
            '${tempDir.path}/processed_${DateTime.now().millisecondsSinceEpoch}.$outputFormat';

        // Encode and save the processed image with quality control
        List<int> encodedImage = img.encodeJpg(resizedImage, quality: 85);

        // Check if file size is still too large and reduce quality if needed
        if (encodedImage.length > requirements['maxSize']) {
          int quality = 70;
          while (
              encodedImage.length > requirements['maxSize'] && quality > 30) {
            encodedImage = img.encodeJpg(resizedImage, quality: quality);
            quality -= 10;
          }
        }

        await File(tempPath).writeAsBytes(encodedImage);
        File processedFile = File(tempPath);

        // Upload the processed image
        if (imageType == 'avatar') {
          await _profileCubit.updateUserAvatar(processedFile);
        } else if (imageType == 'cover') {
          await _profileCubit.updateUserCoverImage(processedFile);
        }
      }
    } catch (e) {
      showAppSnackbar(
        title: 'Error',
        duration: 3,
        type: ToastificationType.error,
        description: 'Failed to process image: ${e.toString()}',
      );
    }
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
