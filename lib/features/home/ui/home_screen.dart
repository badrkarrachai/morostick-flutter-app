import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/features/home/ui/widgets/category_content.dart';
import 'package:morostick/features/home/ui/widgets/home_app_bar.dart';
import 'package:morostick/features/home/ui/widgets/home_categories_tab.dart';
import 'package:morostick/features/home/ui/widgets/home_search_bar.dart';

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
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  static const List<String> _categories = [
    'For You',
    'Trending',
    'Love',
    'Meme',
    'Comedy',
    'Gaming',
    'Art',
    'Music',
    'Food',
    'Lifestyle',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _categories.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                floating: true,
                snap: false,
                pinned: false,
                toolbarHeight: kToolbarHeight + 5,
                title: Container(
                  color: Colors.white,
                  child: const HomeAppBar(),
                ),
                automaticallyImplyLeading: false,
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0,
              ),
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    minHeight: 105,
                    maxHeight: 105,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          verticalSpace(5),
                          HomeSearchBar(controller: _searchController),
                          verticalSpace(5),
                          HomeCategoriesTab(
                            tabController: _tabController,
                            categories: _categories,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: _categories.map((category) {
              return CategoryContent(categoryName: category);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  const _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
