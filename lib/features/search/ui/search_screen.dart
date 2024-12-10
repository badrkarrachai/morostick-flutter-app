import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/features/search/ui/widgets/recent_searches_widget.dart';
import 'package:morostick/features/search/ui/widgets/search_bar_widget.dart';
import 'package:morostick/features/search/ui/widgets/trending_searches_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> recentSearches = ['heart'];
  final List<TrendingItem> trendingItems = [
    TrendingItem(
      'beşiktaş',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'beşiktaş',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'beşiktaş',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'beşiktaş',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'beşiktaş',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'beşiktaş',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'beşiktaş',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'beşiktaş',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'beşiktaş',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'beşiktaş',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'beşiktaş',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'beşiktaş',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'beşiktaş',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'beşiktaş',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'beşiktaş',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'beşiktaş',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundLightColor,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Search Bar
            Padding(
              padding: EdgeInsets.all(16.w),
              child: SearchBarWidget(controller: _searchController),
            ),

            // Scrollable Content
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RecentSearchesWidget(
                            searches: recentSearches,
                            onClearAll: () =>
                                setState(() => recentSearches.clear()),
                            onRemoveSearch: (search) =>
                                setState(() => recentSearches.remove(search)),
                          ),
                          verticalSpace(24),
                          TrendingSearchesWidget(items: trendingItems),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class TrendingItem {
  final String title;
  final String imageUrl;
  final bool isRising;

  TrendingItem(this.title, this.imageUrl, this.isRising);
}
