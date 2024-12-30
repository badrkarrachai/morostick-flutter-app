import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/data/models/pack_model.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/home/ui/home_screen.dart';

class TopCategories extends StatelessWidget {
  final List<Category> topCategories;
  final List<Color> categoryColors;

  // Pre-calculated dimensions
  final double _itemSpacing = 8.w;
  final int _crossAxisCount = 5;

  TopCategories({
    super.key,
    required this.topCategories,
    required this.categoryColors,
  });

  @override
  Widget build(BuildContext context) {
    if (topCategories.isEmpty) return const SizedBox.shrink();

    // Calculate layout once
    final double totalWidth =
        MediaQuery.of(context).size.width - 32.w; // Account for padding
    final double itemWidth =
        (totalWidth - (_crossAxisCount - 1) * _itemSpacing) / _crossAxisCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w, bottom: 12.h),
          child: Text(
            'Trending Categories',
            style: TextStyles.font14DarkPurpleSemiBold,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomMultiChildLayout(
            delegate: CategoryLayoutDelegate(
              itemCount: topCategories.length,
              itemWidth: itemWidth,
              itemSpacing: _itemSpacing,
              crossAxisCount: _crossAxisCount,
            ),
            children: List.generate(
              topCategories.length,
              (index) => LayoutId(
                id: index,
                child: SizedBox(
                  width: itemWidth,
                  child: CategoryItem(
                    key: ValueKey(topCategories[index].id),
                    category: topCategories[index],
                    index: index,
                    backgroundColor: _getCategoryColor(index),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(int index) {
    return index < categoryColors.length
        ? categoryColors[index].withValues(alpha: 0.4)
        : ColorsManager.getRandomColor();
  }
}

class CategoryLayoutDelegate extends MultiChildLayoutDelegate {
  final int itemCount;
  final double itemWidth;
  final double itemSpacing;
  final int crossAxisCount;

  CategoryLayoutDelegate({
    required this.itemCount,
    required this.itemWidth,
    required this.itemSpacing,
    required this.crossAxisCount,
  });

  @override
  Size getSize(BoxConstraints constraints) {
    final double itemHeight = itemWidth * 1.6; // Maintain aspect ratio
    final int rowCount = (itemCount / crossAxisCount).ceil();
    final double totalHeight =
        rowCount * itemHeight + (rowCount - 1) * itemSpacing;

    return Size(constraints.maxWidth, totalHeight);
  }

  @override
  void performLayout(Size size) {
    final double itemHeight = itemWidth * 1.6; // Maintain aspect ratio
    int row = 0;
    int col = 0;

    for (int i = 0; i < itemCount; i++) {
      if (hasChild(i)) {
        final double dx = col * (itemWidth + itemSpacing);
        final double dy = row * (itemHeight + itemSpacing);

        layoutChild(
          i,
          BoxConstraints.tightFor(width: itemWidth, height: itemHeight),
        );
        positionChild(i, Offset(dx, dy));
      }

      col++;
      if (col >= crossAxisCount) {
        col = 0;
        row++;
      }
    }
  }

  @override
  bool shouldRelayout(CategoryLayoutDelegate oldDelegate) =>
      itemCount != oldDelegate.itemCount ||
      itemWidth != oldDelegate.itemWidth ||
      itemSpacing != oldDelegate.itemSpacing ||
      crossAxisCount != oldDelegate.crossAxisCount;
}

class CategoryItem extends StatelessWidget {
  static const double _imagePadding = 8.0;

  final Category category;
  final Color backgroundColor;
  final int index;

  const CategoryItem({
    super.key,
    required this.category,
    required this.backgroundColor,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Precompute sizes
    final double imageSize = 65.w;
    final double emojiContainerSize = 24.w;

    return GestureDetector(
      onTap: () {
        HomeScreen.switchToTrendingTab(context, index + 2);
      },
      child: RepaintBoundary(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none, // Avoid unnecessary clipping
              children: [
                _buildImageContainer(imageSize),
                if (_shouldShowEmoji) _buildEmojiOverlay(emojiContainerSize),
              ],
            ),
            SizedBox(height: 4.h),
            _buildCategoryName(),
          ],
        ),
      ),
    );
  }

  bool get _shouldShowEmoji =>
      category.emoji != null && category.emoji!.isNotEmpty;

  Widget _buildImageContainer(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      padding: const EdgeInsets.all(_imagePadding),
      child: AppCachedNetworkImage.thumbnail(
        borderRadius: BorderRadius.circular(52.r),
        imageUrl: category.trayIcon ?? '',
        width: size,
        height: size,
      ),
    );
  }

  Widget _buildEmojiOverlay(double size) {
    return Positioned(
      right: 0,
      top: 0,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: ColorsManager.darkPurple.withValues(alpha: 0.8),
          shape: BoxShape.circle,
        ),
        child: Text(
          category.emoji!.first,
          style: TextStyle(
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryName() {
    return Text(
      category.name ?? '',
      style: TextStyles.font12GrayPurpleRegular.copyWith(
        color: ColorsManager.darkPurple,
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textHeightBehavior: const TextHeightBehavior(
        leadingDistribution: TextLeadingDistribution.even,
      ),
    );
  }
}

// Extension to cache commonly used values
extension CategoryCacheExtension on TopCategories {
  static final Map<String, Size> _textSizeCache = {};

  static Size getTextSize(String text, TextStyle style) {
    return _textSizeCache.putIfAbsent(
      text,
      () => (TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 2,
        textDirection: TextDirection.ltr,
      )..layout())
          .size,
    );
  }
}
