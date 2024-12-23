import 'package:flutter/material.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/search/ui/widgets/tabs/search_default_screen.dart';
import 'package:morostick/features/search/ui/widgets/tabs/search_packs_tab.dart';

class SearchCategoryContent extends StatelessWidget {
  final String categoryName;

  const SearchCategoryContent({
    super.key,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    // Show different content based on category
    if (categoryName == 'Stickers') {
      return const SearchDefaultScreen();
    }

    if (categoryName == 'Packs') {
      return const SearchPacksTab();
    }

    // Default content for other categories
    return Center(
      child: Text(
        'Content for $categoryName',
        style: TextStyles.font15DarkPurpleMedium,
      ),
    );
  }
}
