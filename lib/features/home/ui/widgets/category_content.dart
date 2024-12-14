import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/home/ui/widgets/tabs/for_you_tab/for_you_tab.dart';
import 'package:morostick/features/home/ui/widgets/top_categories.dart';

class CategoryContent extends StatefulWidget {
  final String categoryName;

  const CategoryContent({
    super.key,
    required this.categoryName,
  });

  @override
  State<CategoryContent> createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent> {
  @override
  Widget build(BuildContext context) {
    // Show different content based on category
    if (widget.categoryName == 'For You') {
      return const ForYouTab();
    }
    if (widget.categoryName == 'Trending') {
      return const TrendingContent();
    }
    if (widget.categoryName == 'Love') {
      return const LoveContent();
    }

    // Default content for other categories
    return Center(
      child: Text(
        'Content for ${widget.categoryName}',
        style: TextStyles.font15DarkPurpleMedium,
      ),
    );
  }
}

class TrendingContent extends StatelessWidget {
  const TrendingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(16),
          const TopCategories(),
          verticalSpace(16),
          // const SuggestedForYou(),
          // const SuggestedForYou(),
        ],
      ),
    );
  }
}

class LoveContent extends StatelessWidget {
  const LoveContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(16),
          // const SuggestedForYou(),
          // const SuggestedForYou(),
          // const SuggestedForYou(),
          // const SuggestedForYou(),
          // const SuggestedForYou(),
          // const SuggestedForYou(),
          // const SuggestedForYou(),
        ],
      ),
    );
  }
}
