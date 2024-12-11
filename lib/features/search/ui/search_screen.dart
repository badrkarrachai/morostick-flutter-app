import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/features/search/ui/widgets/category_content.dart';
import 'package:morostick/features/search/ui/widgets/search_bar_widget.dart';
import 'package:morostick/features/search/ui/widgets/search_categories_tab.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  late TabController _tabController;
  final List<String> _categories = [
    'Packs',
    'Stickers',
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
      backgroundColor: ColorsManager.backgroundLightColor,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Search Bar
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 13.h),
              child: Column(
                children: [
                  SearchBarWidget(controller: _searchController),
                  verticalSpace(5),
                  if (true)
                    SearchCategoriesTab(
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
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SearchCategoryContent(categoryName: category),
                              verticalSpace(24),
                            ],
                          ),
                        ),
                      );
                    },
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
