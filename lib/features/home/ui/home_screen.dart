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
        child: Column(
          children: [
            verticalSpace(5),
            const HomeAppBar(),
            verticalSpace(8),
            HomeSearchBar(controller: _searchController),
            verticalSpace(8),
            HomeCategoriesTab(
              tabController: _tabController,
              categories: _categories,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _categories.map((category) {
                  return CategoryContent(categoryName: category);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
