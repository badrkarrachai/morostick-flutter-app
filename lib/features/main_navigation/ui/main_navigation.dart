import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/images.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/favorites/ui/favorites_screen.dart';
import 'package:morostick/features/home/logic/category_packs_cubit/category_packs_cubit.dart';
import 'package:morostick/features/home/logic/category_tabs_cubit/category_tabs_cubit.dart';
import 'package:morostick/features/home/logic/foryou_tab_cubit/foryou_tab_cubit.dart';
import 'package:morostick/features/home/logic/trending_tab_cubit/trending_tab_cubit.dart';
import 'package:morostick/features/home/ui/home_screen.dart';
import 'package:morostick/features/profile/ui/profile_screen.dart';
import 'package:morostick/features/search/ui/search_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  static late PersistentTabController controller;
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final AuthNavigationService _authService = getIt<AuthNavigationService>();
  late PersistentTabController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    MainNavigation.controller = _controller;
  }

  List<Widget> _buildScreens() {
    return [
      MultiBlocProvider(providers: [
        BlocProvider(create: (context) => getIt<ForYouCubit>()),
        BlocProvider(create: (context) => getIt<TrendingTabCubit>()),
        BlocProvider(create: (context) => getIt<CategoriesCubit>()),
        BlocProvider(create: (context) => getIt<CategoryPacksCubit>()),
      ], child: const HomeScreen()),
      const SearchScreen(),
      const FavoritesScreen(),
      const ProfileScreen(),
    ];
  }

  void _handleTabSelection(int index) {
    // Check if trying to access protected routes (Favorites or Profile)
    if ((index == 2 || index == 3) && _authService.isGuestMode) {
      GuestDialogService.showGuestRestriction(
        message: 'Sorry, please login to access this page',
      );
      // Stay on current tab
      _controller.jumpToTab(_currentIndex);
      return;
    }
    // Update current index and allow navigation
    _currentIndex = index;
    _controller.jumpToTab(index);
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Images.homeFilled,
          width: 20.sp,
          height: 20.sp,
          colorFilter:
              const ColorFilter.mode(ColorsManager.mainPurple, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          Images.homeStroke,
          width: 20.sp,
          height: 20.sp,
          colorFilter:
              const ColorFilter.mode(ColorsManager.grayPurple, BlendMode.srcIn),
        ),
        title: ('Home'),
        textStyle: TextStyles.font12PurpleRegular,
        activeColorPrimary: ColorsManager.mainPurple.withValues(alpha: 0.3),
        activeColorSecondary: ColorsManager.mainPurple,
        inactiveColorPrimary: ColorsManager.grayPurple,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Images.searchFilled,
          width: 20.sp,
          height: 20.sp,
          colorFilter:
              const ColorFilter.mode(ColorsManager.mainPurple, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          Images.searchStroke,
          width: 20.sp,
          height: 20.sp,
          colorFilter:
              const ColorFilter.mode(ColorsManager.grayPurple, BlendMode.srcIn),
        ),
        title: ('Search'),
        textStyle: TextStyles.font12PurpleRegular,
        activeColorPrimary: ColorsManager.mainPurple.withValues(alpha: 0.3),
        activeColorSecondary: ColorsManager.mainPurple,
        inactiveColorPrimary: ColorsManager.grayPurple,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Images.favouriteFilled,
          width: 20.sp,
          height: 20.sp,
          colorFilter:
              const ColorFilter.mode(ColorsManager.mainPurple, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          Images.favouriteStroke,
          width: 20.sp,
          height: 20.sp,
          colorFilter:
              const ColorFilter.mode(ColorsManager.grayPurple, BlendMode.srcIn),
        ),
        title: ('Favorites'),
        textStyle: TextStyles.font12PurpleRegular,
        activeColorPrimary: ColorsManager.mainPurple.withValues(alpha: 0.3),
        activeColorSecondary: ColorsManager.mainPurple,
        inactiveColorPrimary: ColorsManager.grayPurple,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Images.userFilled,
          width: 20.sp,
          height: 20.sp,
          colorFilter:
              const ColorFilter.mode(ColorsManager.mainPurple, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          Images.userStroke,
          width: 20.sp,
          height: 20.sp,
          colorFilter:
              const ColorFilter.mode(ColorsManager.grayPurple, BlendMode.srcIn),
        ),
        title: ('Profile'),
        textStyle: TextStyles.font12PurpleRegular,
        activeColorPrimary: ColorsManager.mainPurple.withValues(alpha: 0.3),
        activeColorSecondary: ColorsManager.mainPurple,
        inactiveColorPrimary: ColorsManager.grayPurple,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      navBarHeight: 63.h,
      bottomScreenMargin: 63.h,
      onItemSelected: _handleTabSelection,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0),
        colorBehindNavBar: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      navBarStyle: NavBarStyle.style7,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
