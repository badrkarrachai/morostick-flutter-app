import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/features/favorites/ui/widgets/favorites_categories_tab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/features/favorites/ui/widgets/favorites_category_content.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Packs',
      'icon': HugeIcons.strokeRoundedBlockchain01,
    },
    {
      'title': 'Stickers',
      'icon': HugeIcons.strokeRoundedLaughing,
    },
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(color: ColorsManager.white),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: FavoritesCategoriesTab(
              tabController: _tabController,
              categories: _categories,
            ),
          ),

          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _categories.map((category) {
                return FavoritesCategoryContent(
                  categoryName: category['title'],
                );
              }).toList(),
            ),
          )
        ],
      )),
    );
  }
}
