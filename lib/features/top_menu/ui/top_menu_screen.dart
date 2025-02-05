import 'package:flutter/material.dart';
import 'package:morostick/core/data/models/user_model.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/routing/routes.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/services/user_service.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/images.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_message_box.dart';
import 'package:morostick/core/widgets/app_snackbar.dart';
import 'package:morostick/features/main_navigation/logic/main_navigation_cubit.dart';
import 'package:morostick/features/top_menu/logic/top_menu_cubit.dart';
import 'package:morostick/features/top_menu/ui/widgets/top_menu_header.dart';
import 'package:morostick/features/top_menu/ui/widgets/top_menu_item.dart';
import 'package:morostick/features/top_menu/ui/widgets/top_menu_notification_banner.dart';
import 'package:morostick/features/top_menu/ui/widgets/top_menu_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toastification/toastification.dart';

class TopMenuScreen extends StatefulWidget {
  const TopMenuScreen({super.key});

  @override
  State<TopMenuScreen> createState() => _TopMenuScreenState();
}

class _TopMenuScreenState extends State<TopMenuScreen> {
  final AuthNavigationService _authService = getIt<AuthNavigationService>();

  bool facebookLogin = false;

  bool googleLogin = false;

  void _handelFacebookLogin(bool value) {
    setState(() {
      facebookLogin = value;
    });
  }

  void _handelGoogleLogin(bool value) {
    setState(() {
      googleLogin = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundLightColor,
      body: SafeArea(
        child: Column(
          children: [
            const TopMenuHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding:
                    EdgeInsets.only(bottom: 80.h), // Add padding for footer
                child: ListenableBuilder(
                    listenable: getIt<UserService>(),
                    builder: (context, _) {
                      final user = getIt<UserService>().currentUser;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TopMenuNotificationBanner(),
                          TopMenuSection(
                            items: _buildMainTopMenuItems(user),
                          ),
                          TopMenuSection(
                            items: _buildConnectItems(),
                          ),
                          if (_authService.isAuthenticated)
                            TopMenuSection(
                              title: 'Other',
                              items: _buildAboutItems(),
                            ),
                          verticalSpace(23),
                          Center(
                            child: Text(
                              'Copyright © 2024 By MoroStick All Rights Reserved.\nv.1.0.0',
                              textAlign: TextAlign.center,
                              style: TextStyles.font11GrayPurpleRegular,
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<TopMenuItem> _buildMainTopMenuItems(User? user) => [
        TopMenuItem(
          icon: Images.account,
          onTap: () {
            if (user != null) {
              getIt<MainNavigationCubit>().selectIndex(3);
              context.pop();
            } else {
              getIt<AuthNavigationService>().disableGuestMode();
              context.pushReplacementNamed(Routes.loginScreen);
            }
          },
          title: user?.name != null
              ? 'Account'
              : 'Sign in and keep your data safe!',
          textStyle: user?.name != null
              ? TextStyles.font14DarkPurpleMedium
              : TextStyles.font14PurpleSemiBold,
        ),
        TopMenuItem(
          onTap: () {
            Share.share(
                "MoroStick lets you create and share fun WhatsApp stickers, including animated ones! Easily design your own stickers and send them to friends. Download now on the Google Play Store or App Store. https://play.google.com/store/apps/details?id=com.morostick.app");
          },
          icon: Images.inviteFriend,
          title: 'Invite a friend',
          textStyle: TextStyles.font14DarkPurpleMedium,
        ),
        TopMenuItem(
          icon: Images.privacyPolicy,
          title: 'Privacy Policy',
          textStyle: TextStyles.font14DarkPurpleMedium,
          onTap: () => context.pushNamed(Routes.webviewScreen, arguments: {
            'title': 'Privacy Policy',
            'url': 'https://www.google.com/',
          }),
        ),
        TopMenuItem(
          icon: Images.termsAndConditions,
          title: 'Terms and Conditions',
          textStyle: TextStyles.font14DarkPurpleMedium,
          onTap: () => context.pushNamed(Routes.webviewScreen, arguments: {
            'title': 'Terms and Conditions',
            'url': 'https://www.facebook.com/',
          }),
        ),
        TopMenuItem(
          icon: Images.faq,
          title: 'FAQs',
          textStyle: TextStyles.font14DarkPurpleMedium,
          onTap: () => context.pushNamed(Routes.webviewScreen, arguments: {
            'title': 'FAQs',
            'url': 'https://www.facebook.com/',
          }),
        ),
      ];

  Widget _buildConnectItems() {
    return BlocConsumer<TopMenuCubit, TopMenuState>(
      listener: (context, state) {
        state.whenOrNull(
          loading: (isGoogleAuthEnabled, isFacebookAuthEnabled) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => PopScope(
                canPop: false,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: ColorsManager.mainPurple,
                  ),
                ),
              ),
            );
          },
          success: (isGoogleAuthEnabled, isFacebookAuthEnabled) {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
          error: (error, isGoogleAuthEnabled, isFacebookAuthEnabled) {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }

            if (isGoogleAuthEnabled || isFacebookAuthEnabled) {
              showAppSnackbar(
                title: error.message,
                type: ToastificationType.error,
                description: error.error?.details ??
                    "Something went wrong, please try again later",
              );
            }
          },
        );
      },
      builder: (context, state) {
        return Column(
          children: [
            TopMenuSection(
              title: 'Connect with',
              items: [
                TopMenuItem(
                  icon: Images.facebookLogo,
                  title: 'Facebook',
                  textStyle: TextStyles.font14DarkPurpleMedium,
                  showToggle: true,
                  switchValue: state.isFacebookAuthEnabled,
                  onToggle: (value) =>
                      context.read<TopMenuCubit>().toggleFacebookAuth(value),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                ),
                TopMenuItem(
                  icon: Images.googleLogo,
                  title: 'Google',
                  textStyle: TextStyles.font14DarkPurpleMedium,
                  showToggle: true,
                  switchValue: state.isGoogleAuthEnabled,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                  onToggle: (value) =>
                      context.read<TopMenuCubit>().toggleGoogleAuth(value),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  List<TopMenuItem> _buildAboutItems() => [
        TopMenuItem(
          icon: Images.logOut,
          iconColor: ColorsManager.crimsonRed,
          title: 'Log Out',
          textStyle: TextStyles.font14DarkPurpleMedium,
          onTap: _handleLogout,
        ),
      ];

  Future<void> _handleLogout() async {
    AppMessageBoxDialogManager.showConfirmDialog(
      context: context, // Use the current context
      title: 'Log Out',
      message: 'Are you sure you want to log out?',
      confirmText: 'Log Out',
      cancelText: 'Cancel',
      icon: Icons.logout,
      iconColor: ColorsManager.crimsonRed,
      iconBackgroundColor: ColorsManager.crimsonRed.withValues(alpha: 0.1),
      confirmButtonBackgroundColor: ColorsManager.crimsonRed,
      onConfirm: () async {
        final authService = context.read<AuthNavigationService>();
        final success = await authService.logout();

        if (success && mounted) {
          // Navigate to login screen after logout
          getIt<AuthNavigationService>().disableGuestMode();
          context.pushNamedAndRemoveAll(Routes.loginScreen);
        }
      },
    );
  }
}
