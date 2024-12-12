import 'package:flutter/material.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/features/profile/ui/widgets/change_password_dialog.dart';
import 'package:morostick/features/profile/ui/widgets/danger_zone.dart';
import 'package:morostick/features/profile/ui/widgets/delete_account_dialog.dart';
import 'package:morostick/features/profile/ui/widgets/profile_form.dart';
import 'package:morostick/features/profile/ui/widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Badr Karrachai');
  final _emailController =
      TextEditingController(text: 'Badrkarrachai1999@gmail.com');
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final bool _isEmailVerified = false;
  bool _isEditingName = true;
  bool _isEditingEmail = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundLightColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ProfileHeader(
                coverImageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUb1wzzdfF9VHLV7vHUr5x4wJdCWdwfFro2w&s',
                profileImageUrl:
                    'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/Badr2.jpg',
                onCoverImageTap: () {
                  // Handle cover image update
                },
                onProfileImageTap: () {
                  // Handle profile image update
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
                onEmailEditTap: () =>
                    setState(() => _isEditingEmail = !_isEditingEmail),
                onEmailVerifyTap: () {
                  // Handle email verification
                },
                onChangePasswordTap: _showChangePasswordDialog,
                nameValidator: (value) {
                  if (value?.isEmpty ?? true) return 'Name is required';
                  return null;
                },
                emailValidator: (value) {
                  if (value?.isEmpty ?? true) return 'Email is required';
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
    _nameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
