import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/features/home/ui/widgets/category_content.dart';
import 'package:morostick/features/home/ui/widgets/home_app_bar.dart';
import 'package:morostick/features/home/ui/widgets/home_categories_tab.dart';
import 'package:morostick/features/home/ui/widgets/home_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = true;

  final List<String> _categories = [
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

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 20 && _showTitle) {
      setState(() => _showTitle = false);
    } else if (_scrollController.offset <= 20 && !_showTitle) {
      setState(() => _showTitle = true);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Collapsible Title
            AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: EdgeInsets.zero,
              height: _showTitle ? kToolbarHeight : 0,
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: const HomeAppBar(),
              ),
            ),

            // Pinned Search and Categories
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  verticalSpace(8),
                  HomeSearchBar(controller: _searchController),
                  verticalSpace(3),
                  HomeCategoriesTab(
                    tabController: _tabController,
                    categories: _categories,
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _categories.map((category) {
                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: CategoryContent(categoryName: category),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
