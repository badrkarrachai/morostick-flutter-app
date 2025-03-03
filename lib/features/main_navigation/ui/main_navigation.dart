import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/features/favorites/logic/favorite_packs_cubit/favorite_packs_cubit.dart';
import 'package:morostick/features/favorites/logic/favorite_stickers_cubit/favorite_stickers_cubit.dart';
import 'package:morostick/features/favorites/ui/favorites_screen.dart';
import 'package:morostick/features/home/logic/category_packs_cubit/category_packs_cubit.dart';
import 'package:morostick/features/home/logic/category_tabs_cubit/category_tabs_cubit.dart';
import 'package:morostick/features/home/logic/foryou_tab_cubit/foryou_tab_cubit.dart';
import 'package:morostick/features/home/logic/trending_tab_cubit/trending_tab_cubit.dart';
import 'package:morostick/features/home/ui/home_screen.dart';
import 'package:morostick/features/main_navigation/logic/main_navigation_cubit.dart';
import 'package:morostick/features/main_navigation/logic/main_navigation_state.dart';
import 'package:morostick/features/profile/logic/profile_cubit.dart';
import 'package:morostick/features/profile/ui/profile_screen.dart';
import 'package:morostick/features/search/logic/search_cubit.dart';
import 'package:morostick/features/search/ui/search_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  Widget _buildHomeScreen() {
    // Key helps Flutter maintain state
    return MultiBlocProvider(
      key: const PageStorageKey('home_screen'),
      providers: [
        BlocProvider.value(
          value: getIt<ForYouCubit>(),
        ),
        BlocProvider.value(
          value: getIt<TrendingTabCubit>(),
        ),
        BlocProvider.value(
          value: getIt<CategoriesCubit>(),
        ),
        BlocProvider.value(
          value: getIt<CategoryPacksCubit>(),
        ),
      ],
      child: const HomeScreen(),
    );
  }

  Widget _buildSearchScreen() {
    return BlocProvider.value(
      key: const PageStorageKey('search_screen'),
      value: getIt<SearchCubit>(),
      child: const SearchScreen(),
    );
  }

  Widget _buildFavoritesScreen() {
    return MultiBlocProvider(
      key: const PageStorageKey('favorites_screen'),
      providers: [
        BlocProvider.value(
          key: const PageStorageKey('favorites_screen'),
          value: getIt<FavoritePacksCubit>(),
        ),
        BlocProvider.value(
          key: const PageStorageKey('favorites_screen'),
          value: getIt<FavoriteStickersCubit>(),
        ),
      ],
      child: const FavoritesScreen(),
    );
  }

  Widget _buildProfileScreen() {
    return MultiBlocProvider(
      key: const PageStorageKey('profile_screen'),
      providers: [
        BlocProvider.value(
          value: getIt<ProfileCubit>(),
        ),
      ],
      child: const ProfileScreen(
        key: PageStorageKey('profile_screen'),
      ),
    );
  }

  Widget _buildCurrentScreen(int index) {
    switch (index) {
      case 0:
        return _buildHomeScreen();
      case 1:
        return _buildSearchScreen();
      case 2:
        return _buildFavoritesScreen();
      case 3:
        return _buildProfileScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildNavItem(
      BuildContext context, int index, IconData icon, int selectedIndex) {
    final isSelected = index == selectedIndex;
    return InkWell(
      onTap: () {
        if ((index == 2 || index == 3) &&
            getIt<AuthNavigationService>().isGuestMode) {
          GuestDialogService.showGuestRestriction(
            message: 'Sorry, please login to access this page',
          );
          return;
        }
        context.read<MainNavigationCubit>().selectIndex(index);
      },
      child: SizedBox(
        width: 68,
        height: 35,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: isSelected ? 0 : 34,
              right: isSelected ? 0 : 34,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 150),
                opacity: isSelected ? 1.0 : 0.0,
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: ColorsManager.mainPurple.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
              ),
            ),
            Icon(
              icon,
              color: isSelected
                  ? ColorsManager.mainPurple
                  : ColorsManager.grayPurple,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainNavigationCubit, MainNavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              // Screens
              Positioned.fill(
                bottom: Platform.isIOS ? 20 : 56,
                child: PageStorage(
                  bucket: PageStorageBucket(),
                  child: _buildCurrentScreen(state.selectedIndex),
                ),
              ),

              // Navigation Bar
              Positioned(
                left: 0,
                right: 0,
                bottom: Platform.isIOS ? 18 : 0,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNavItem(
                          context,
                          0,
                          HugeIcons.strokeRoundedHome01,
                          state.selectedIndex,
                        ),
                        _buildNavItem(
                          context,
                          1,
                          HugeIcons.strokeRoundedSearch01,
                          state.selectedIndex,
                        ),
                        _buildNavItem(
                          context,
                          2,
                          HugeIcons.strokeRoundedFavourite,
                          state.selectedIndex,
                        ),
                        _buildNavItem(
                          context,
                          3,
                          HugeIcons.strokeRoundedUser,
                          state.selectedIndex,
                        ),
                      ],
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
}
