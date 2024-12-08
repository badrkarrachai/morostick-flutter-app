import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/home/ui/widgets/recommended_packs_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/features/home/ui/widgets/trending_this_month_collection.dart';

class CategoryContent extends StatelessWidget {
  final String categoryName;

  const CategoryContent({
    super.key,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    // Show different content based on category
    if (categoryName == 'For You') {
      return const ForYouContent();
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

class ForYouContent extends StatelessWidget {
  const ForYouContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(16.h),
          const RecommendedPacksCarousel(),
          // Add more sections for the "For you" tab below
          verticalSpace(16),

          const TrendingThisMonthCollection(),
        ],
      ),
    );
  }
}
