import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/widgets/app_shimmer_loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrendingShimmer extends StatelessWidget {
  const TrendingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(16),
          RecommendedPacksCarouselShimmer(),
          verticalSpace(10),
          const SuggestedForYouShimmer(),
        ],
      ),
    );
  }
}

class RecommendedPacksCarouselShimmer extends StatelessWidget {
  static const int _itemCount = 10;
  static const int _crossAxisCount = 5;
  final double _itemSpacing = 8.w;

  RecommendedPacksCarouselShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate layout dimensions
    final double totalWidth = MediaQuery.of(context).size.width - 32.w;
    final double itemWidth =
        (totalWidth - (_crossAxisCount - 1) * _itemSpacing) / _crossAxisCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title shimmer
        Padding(
          padding: EdgeInsets.only(left: 20.w, bottom: 12.h),
          child: AppShimmerLoading(
            child: Container(
              height: 11.w,
              width: 130.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        ),
        // Grid shimmer
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomMultiChildLayout(
            delegate: ShimmerGridDelegate(
              itemCount: _itemCount,
              itemWidth: itemWidth,
              itemSpacing: _itemSpacing,
              crossAxisCount: _crossAxisCount,
            ),
            children: List.generate(
              _itemCount,
              (index) => LayoutId(
                id: index,
                child: _buildGridItem(itemWidth),
              ),
            ),
          ),
        ),
        verticalSpace(10),
      ],
    );
  }

  Widget _buildGridItem(double width) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          AppShimmerLoading(
            child: Container(
              height: 65.h,
              width: 65.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          verticalSpace(8),
          AppShimmerLoading(
            child: Container(
              height: 10.h,
              width: 54.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerGridDelegate extends MultiChildLayoutDelegate {
  final int itemCount;
  final double itemWidth;
  final double itemSpacing;
  final int crossAxisCount;

  ShimmerGridDelegate({
    required this.itemCount,
    required this.itemWidth,
    required this.itemSpacing,
    required this.crossAxisCount,
  });

  @override
  Size getSize(BoxConstraints constraints) {
    final double itemHeight = itemWidth * 1.6;
    final int rowCount = (itemCount / crossAxisCount).ceil();
    final double totalHeight =
        rowCount * itemHeight + (rowCount - 1) * itemSpacing;
    return Size(constraints.maxWidth, totalHeight);
  }

  @override
  void performLayout(Size size) {
    final double itemHeight = itemWidth * 1.6;
    int row = 0;
    int col = 0;

    for (int i = 0; i < itemCount; i++) {
      if (hasChild(i)) {
        final double dx = col * (itemWidth + itemSpacing);
        final double dy = row * (itemHeight + itemSpacing);

        layoutChild(
            i, BoxConstraints.tightFor(width: itemWidth, height: itemHeight));
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
  bool shouldRelayout(ShimmerGridDelegate oldDelegate) =>
      itemCount != oldDelegate.itemCount ||
      itemWidth != oldDelegate.itemWidth ||
      itemSpacing != oldDelegate.itemSpacing ||
      crossAxisCount != oldDelegate.crossAxisCount;
}

class SuggestedForYouShimmer extends StatelessWidget {
  static const int _itemCount = 5;

  const SuggestedForYouShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: List.generate(
          _itemCount,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: 32.h),
            child: _SuggestedItemShimmer(),
          ),
        ),
      ),
    );
  }
}

class _SuggestedItemShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppShimmerLoading(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 31.w,
                height: 31.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              horizontalSpace(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    verticalSpace(4),
                    Container(
                      height: 11.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 60.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
            ],
          ),
          // Stickers Preview
          verticalSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              5,
              (index) => Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
