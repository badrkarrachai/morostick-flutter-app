// home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/features/home/logic/category_tabs_cubit/category_tabs_cubit.dart';
import 'package:morostick/features/home/logic/category_tabs_cubit/category_tabs_state.dart';
import 'package:morostick/features/home/ui/widgets/category_content.dart';
import 'package:morostick/features/home/ui/widgets/home_app_bar.dart';
import 'package:morostick/features/home/ui/widgets/home_categories_tab.dart';
import 'package:morostick/features/home/ui/widgets/home_search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static void switchToTrendingTab(BuildContext context, int pageIndex) {
    final _HomeScreenState? state =
        context.findAncestorStateOfType<_HomeScreenState>();
    if (state != null) {
      state._tabController.animateTo(pageIndex);
    }
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late final PageStorageBucket _bucket;
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<bool> _isAppBarVisible = ValueNotifier<bool>(true);
  static const int _shimmerCount = 3;

  @override
  void initState() {
    super.initState();
    _bucket = PageStorageBucket();
    _tabController = TabController(
      length: CategoriesCubit.staticCategories.length + _shimmerCount,
      vsync: this,
    );
    _tabController.addListener(_handleTabChange);
    context.read<CategoriesCubit>().loadCategories();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      _isAppBarVisible.value = true;
    }
  }

  void handleScroll(ScrollDirection direction, double offset) {
    final bool isAtTop = offset <= 0;
    final bool isScrollingDown = direction == ScrollDirection.reverse;

    if (isAtTop) {
      _isAppBarVisible.value = true;
    } else if (isScrollingDown && _isAppBarVisible.value) {
      _isAppBarVisible.value = false;
    } else if (direction == ScrollDirection.forward &&
        !_isAppBarVisible.value) {
      if (offset <= 0) {
        _isAppBarVisible.value = true;
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _isAppBarVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) {
          if (!state.isLoading && state.categories.isNotEmpty) {
            final currentIndex =
                _tabController.index.clamp(0, state.categories.length - 1);
            _tabController.dispose();
            _tabController = TabController(
              length: state.categories.length,
              vsync: this,
              initialIndex: currentIndex,
            );
            _tabController.addListener(_handleTabChange);
          }
        },
        builder: (context, state) {
          final displayCategories = state.isLoading
              ? [
                  ...CategoriesCubit.staticCategories.map((cat) => cat.name),
                  ...List.generate(
                      _shimmerCount, (index) => 'Loading ${index + 1}')
                ]
              : state.categories.map((cat) => cat.name).toList();

          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _isAppBarVisible,
                    builder: (context, isVisible, child) => AnimatedSlide(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      offset: Offset(0, isVisible ? 0 : -1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: isVisible ? kToolbarHeight + 5 : 0,
                        child: const HomeAppBar(),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 104.5,
                  child: Column(
                    children: [
                      verticalSpace(5),
                      HomeSearchBar(controller: _searchController),
                      verticalSpace(5),
                      HomeCategoriesTab(
                        tabController: _tabController,
                        categories: displayCategories,
                        isLoading: state.isLoading,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageStorage(
                    bucket: _bucket,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        for (var i = 0; i < displayCategories.length; i++)
                          CategoryContent(
                            key: PageStorageKey('tab_${displayCategories[i]}'),
                            categoryName: displayCategories[i]!,
                            categoryNames: displayCategories,
                            onScroll: handleScroll,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
