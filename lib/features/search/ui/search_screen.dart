import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/features/search/ui/widgets/search_bar_widget.dart';
import 'package:morostick/features/search/ui/tabs/search_default_screen.dart';
import 'package:morostick/features/search/logic/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _currentScreen = 'default';

  Future<void> _handleRefresh() async {
    if (_currentScreen == 'default') {
      await context.read<SearchCubit>().fetchTrendingSearches();
    }
    // Add other screen refresh handlers here if needed
  }

  void _updateCurrentScreen(String screenName) {
    if (mounted && _currentScreen != screenName) {
      setState(() {
        _currentScreen = screenName;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundLightColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 13.h),
              child: SearchBarWidget(controller: _searchController),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: screenH,
                    child: SearchDefaultScreen(
                      currentScreen: _currentScreen,
                      onScreenChange: _updateCurrentScreen,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
