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
      state._tabController?.animateTo(pageIndex);
    }
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  late final PageStorageBucket _bucket;
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<bool> _isAppBarVisible = ValueNotifier<bool>(true);
  static const int _shimmerCount = 3;

  void _initializeTabController(int length, {int initialIndex = 0}) {
    _tabController?.dispose();
    _tabController = TabController(
      length: length,
      vsync: this,
      initialIndex: initialIndex.clamp(0, length - 1),
    );
    _tabController?.addListener(_handleTabChange);
  }

  @override
  void initState() {
    super.initState();
    _bucket = PageStorageBucket();
    // Initialize with static categories first
    _initializeTabController(
        CategoriesCubit.staticCategories.length + _shimmerCount);
  }

  void _handleTabChange() {
    if (_tabController?.indexIsChanging ?? false) {
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
    _tabController?.dispose();
    _searchController.dispose();
    _isAppBarVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<CategoriesCubit, CategoriesState>(
        listenWhen: (previous, current) =>
            previous.categories.length != current.categories.length,
        listener: (context, state) {
          if (!state.isLoading) {
            final currentIndex = _tabController?.index ?? 0;
            _initializeTabController(
              state.categories.length,
              initialIndex: currentIndex,
            );
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

          if (_tabController?.length != displayCategories.length) {
            _initializeTabController(
              displayCategories.length,
              initialIndex: _tabController?.index ?? 0,
            );
          }

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
                      if (_tabController != null)
                        HomeCategoriesTab(
                          tabController: _tabController!,
                          categories: displayCategories,
                          isLoading: state.isLoading,
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageStorage(
                    bucket: _bucket,
                    child: _tabController == null
                        ? const Center(child: CircularProgressIndicator())
                        : TabBarView(
                            controller: _tabController,
                            children: [
                              for (var i = 0; i < displayCategories.length; i++)
                                CategoryContent(
                                  key: PageStorageKey(
                                      'tab_${displayCategories[i]}'),
                                  categoryName: displayCategories[i],
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
