import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/features/favorites/ui/favorites_screen.dart';
import 'package:morostick/features/home/logic/category_packs_cubit/category_packs_cubit.dart';
import 'package:morostick/features/home/logic/category_tabs_cubit/category_tabs_cubit.dart';
import 'package:morostick/features/home/logic/foryou_tab_cubit/foryou_tab_cubit.dart';
import 'package:morostick/features/home/logic/trending_tab_cubit/trending_tab_cubit.dart';
import 'package:morostick/features/home/ui/home_screen.dart';
import 'package:morostick/features/main_navigation/logic/main_navigation_cubit.dart';
import 'package:morostick/features/main_navigation/logic/main_navigation_state.dart';
import 'package:morostick/features/profile/ui/profile_screen.dart';
import 'package:morostick/features/search/ui/search_screen.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainNavigationCubit, MainNavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              // Screens
              Positioned.fill(
                bottom: 56, // Height of navigation bar
                child: IndexedStack(
                  index: state.selectedIndex,
                  children: _buildScreens(),
                ),
              ),

              // Custom Navigation Bar
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
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
            // Animated background indicator
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: isSelected ? 0 : 34, // Start from center when not selected
              right: isSelected ? 0 : 34, // Start from center when not selected
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
            // Static icon
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
}
