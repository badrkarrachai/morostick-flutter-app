import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/features/home/logic/category_packs_cubit/category_packs_cubit.dart';
import 'package:morostick/features/home/ui/tabs/foryou_tab/foryou_tab.dart';
import 'package:morostick/features/home/ui/tabs/other_categories_tabs/other_categories_tab.dart';
import 'package:morostick/features/home/ui/tabs/trending/trending_tab.dart';

// Add this class to manage independent states for each category
class CategoryPacksStateManager {
  static final Map<String, CategoryPacksCubit> _cubitInstances = {};

  static CategoryPacksCubit getCubitForCategory(
    BuildContext context,
    String categoryKey,
  ) {
    if (!_cubitInstances.containsKey(categoryKey)) {
      // Create a new cubit instance using the same dependencies as the parent
      final parentCubit = context.read<CategoryPacksCubit>();
      _cubitInstances[categoryKey] = CategoryPacksCubit(
        parentCubit.homeRepo,
      );
    }
    return _cubitInstances[categoryKey]!;
  }

  static void dispose(String categoryKey) {
    _cubitInstances[categoryKey]?.close();
    _cubitInstances.remove(categoryKey);
  }

  static void disposeAll() {
    for (var cubit in _cubitInstances.values) {
      cubit.close();
    }
    _cubitInstances.clear();
  }
}

class CategoryContent extends StatefulWidget {
  final String categoryName;
  final Function(ScrollDirection, double) onScroll;
  final List<String?> categoryNames;

  const CategoryContent({
    super.key,
    required this.categoryName,
    required this.categoryNames,
    required this.onScroll,
  });

  @override
  State<CategoryContent> createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;
    widget.onScroll(
      _scrollController.position.userScrollDirection,
      _scrollController.offset,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    if (widget.categoryName != 'For You' && widget.categoryName != 'Trending') {
      CategoryPacksStateManager.dispose(widget.categoryName);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildContent();
  }

  Widget _buildContent() {
    switch (widget.categoryName) {
      case 'For You':
        return ForYouTab(scrollController: _scrollController);
      case 'Trending':
        return TrendingTab(scrollController: _scrollController);
      default:
        return _buildCategoryTab(widget.categoryName);
    }
  }

  Widget _buildCategoryTab(String categoryKey) {
    return BlocProvider(
      create: (context) => CategoryPacksStateManager.getCubitForCategory(
        context,
        categoryKey,
      ),
      child: KeyedSubtree(
        key: ValueKey('category_tab_$categoryKey'),
        child: OtherCategoriesTab(
          scrollController: _scrollController,
          categoryKey: categoryKey,
        ),
      ),
    );
  }
}
