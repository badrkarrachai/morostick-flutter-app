import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/widgets/app_shimmer_loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrendingSearchesLoadingShimmer extends StatelessWidget {
  // Static constants for dimensions

  // Reusable decorations
  static final _roundedDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12.r),
  );

  const TrendingSearchesLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(7),
          const _TrendingShimmer(
            width: 140,
            height: 15,
          ),
          verticalSpace(16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 16.w,
              childAspectRatio: 3.5,
            ),
            itemCount: 16,
            itemBuilder: (context, index) => _TrendingShimmer(
              width: 179,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendingShimmer extends StatelessWidget {
  final double height;
  final double width;
  const _TrendingShimmer({super.key, this.height = 50, this.width = 160});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AppShimmerLoading(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: height,
              width: width,
              decoration: TrendingSearchesLoadingShimmer._roundedDecoration,
            ),
          ],
        ),
      ),
    );
  }
}
