import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/features/search/ui/widgets/recent_searches_widget.dart';
import 'package:morostick/features/search/ui/widgets/trending_searches_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchDefaultScreen extends StatefulWidget {
  const SearchDefaultScreen({super.key});

  @override
  State<SearchDefaultScreen> createState() => _SearchDefaultScreenState();
}

class _SearchDefaultScreenState extends State<SearchDefaultScreen> {
  final List<String> recentSearches = ['heart'];
  final List<TrendingItem> trendingItems = [
    TrendingItem(
      'scientist',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      true,
    ),
    TrendingItem(
      'powerful',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(5).png",
      false,
    ),
    TrendingItem(
      'between',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(6).png",
      false,
    ),
    TrendingItem(
      'as',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(1).png",
      true,
    ),
    TrendingItem(
      'hollow',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(2).png",
      false,
    ),
    TrendingItem(
      'slip',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(3).png",
      false,
    ),
    TrendingItem(
      'happily',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(6).png",
      false,
    ),
    TrendingItem(
      'earlier',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(5).png",
      false,
    ),
    TrendingItem(
      'brother',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      true,
    ),
    TrendingItem(
      'club',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(3).png",
      false,
    ),
    TrendingItem(
      'magic',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(2).png",
      false,
    ),
    TrendingItem(
      'worker',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(1).png",
      false,
    ),
    TrendingItem(
      'burst',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'sky',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
    TrendingItem(
      'hung',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      true,
    ),
    TrendingItem(
      'swim',
      "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RecentSearchesWidget(
            searches: recentSearches,
            onClearAll: () => setState(() => recentSearches.clear()),
            onRemoveSearch: (search) =>
                setState(() => recentSearches.remove(search)),
          ),
          verticalSpace(24),
          TrendingSearchesWidget(items: trendingItems),
        ],
      ),
    );
  }
}

class TrendingItem {
  final String title;
  final String imageUrl;
  final bool isRising;

  TrendingItem(this.title, this.imageUrl, this.isRising);
}
