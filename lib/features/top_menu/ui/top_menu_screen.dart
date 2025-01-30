import 'package:flutter/material.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/routing/routes.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/images.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/top_menu/ui/widgets/top_menu_header.dart';
import 'package:morostick/features/top_menu/ui/widgets/top_menu_item.dart';
import 'package:morostick/features/top_menu/ui/widgets/top_menu_notification_banner.dart';
import 'package:morostick/features/top_menu/ui/widgets/top_menu_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        child: Stack(
          // Change outer Column to Stack
          children: [
            Column(
              children: [
                const TopMenuHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding:
                        EdgeInsets.only(bottom: 80.h), // Add padding for footer
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TopMenuNotificationBanner(),
                        TopMenuSection(
                          items: _buildMainTopMenuItems(),
                        ),
                        TopMenuSection(
                          title: 'Connect with',
                          items: _buildConnectItems(),
                        ),
                        if (_authService.isAuthenticated)
                          TopMenuSection(
                            title: 'Other',
                            items: _buildAboutItems(),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Footer
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: ColorsManager.backgroundLightColor,
                padding: EdgeInsets.all(24.w),
                child: Center(
                  child: Text(
                    'Copyright © 2024 By MoroStick All Rights Reserved.\nv.1.0.0',
                    textAlign: TextAlign.center,
                    style: TextStyles.font11GrayPurpleRegular,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<TopMenuItem> _buildMainTopMenuItems() => [
        TopMenuItem(
          icon: Images.account,
          title: 'Sign in and keep your data safe!',
          textStyle: TextStyles.font14PurpleSemiBold,
        ),
        TopMenuItem(
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

  List<TopMenuItem> _buildConnectItems() => [
        TopMenuItem(
          icon: Images.facebookLogo,
          title: 'Facebook',
          textStyle: TextStyles.font14DarkPurpleMedium,
          showToggle: true,
          switchValue: facebookLogin,
          onToggle: _handelFacebookLogin,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
        ),
        TopMenuItem(
          icon: Images.googleLogo,
          title: 'Google',
          textStyle: TextStyles.font14DarkPurpleMedium,
          showToggle: true,
          switchValue: googleLogin,
          onToggle: _handelGoogleLogin,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
        ),
      ];

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
    final authService = context.read<AuthNavigationService>();
    final success = await authService.logout();

    if (success && mounted) {
      Navigator.of(context, rootNavigator: true)
          .context
          .pushNamedAndRemoveAll(Routes.loginScreen);
    }
  }
}
