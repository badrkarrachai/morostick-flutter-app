import 'package:flutter/material.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/favorites/ui/widgets/tabs/favorite_packs.dart';
import 'package:morostick/features/favorites/ui/widgets/tabs/favorite_stickers.dart';

class FavoritesCategoryContent extends StatelessWidget {
  final String categoryName;

  const FavoritesCategoryContent({
    super.key,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    // Show different content based on category
    if (categoryName == 'Packs') {
      return const FavoritePacks();
    }
    if (categoryName == 'Stickers') {
      return const FavoriteStickers();
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
