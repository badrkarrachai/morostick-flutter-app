import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/widgets/app_shimmer_loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForYouTabShimmer extends StatelessWidget {
  // Static constants for dimensions
  static final _titleHeight = 12.w;
  static final _titleWidth = 130.w;
  static final _carouselHeight = 150.h;
  static final _indicatorHeight = 8.h;
  static final _indicatorWidth = 8.w;
  static final _activeIndicatorWidth = 60.w;
  static final _cardSize = 95.w;
  static final _avatarSize = 31.w;
  static final _stickerPreviewSize = 64.w;

  // Reusable decorations
  static final _roundedDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16.r),
  );

  static const _circleDecoration = BoxDecoration(
    color: Colors.white,
    shape: BoxShape.circle,
  );

  const ForYouTabShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(16),
          const _RecommendedShimmer(),
          verticalSpace(16),
          const _TrendingShimmer(),
          verticalSpace(25),
          const _SuggestedShimmer(),
        ],
      ),
    );
  }
}

class _RecommendedShimmer extends StatelessWidget {
  const _RecommendedShimmer();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AppShimmerLoading(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, bottom: 12.h),
              child: Container(
                height: ForYouTabShimmer._titleHeight,
                width: ForYouTabShimmer._titleWidth,
                decoration: ForYouTabShimmer._roundedDecoration,
              ),
            ),
            Container(
              height: ForYouTabShimmer._carouselHeight,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: ForYouTabShimmer._roundedDecoration,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIndicator(true),
                  _buildIndicator(false),
                  _buildIndicator(false),
                ],
              ),
            ),
            verticalSpace(10),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return Container(
      height: ForYouTabShimmer._indicatorHeight,
      width: isActive
          ? ForYouTabShimmer._activeIndicatorWidth
          : ForYouTabShimmer._indicatorWidth,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: ForYouTabShimmer._roundedDecoration,
    );
  }
}

class _TrendingShimmer extends StatelessWidget {
  const _TrendingShimmer();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AppShimmerLoading(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, bottom: 12.h),
              child: Container(
                height: ForYouTabShimmer._titleHeight,
                width: ForYouTabShimmer._titleWidth,
                decoration: ForYouTabShimmer._roundedDecoration,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: List.generate(5, (index) => _TrendingCard()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrendingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w, left: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: ForYouTabShimmer._cardSize,
            width: ForYouTabShimmer._cardSize,
            decoration: ForYouTabShimmer._roundedDecoration,
          ),
          SizedBox(height: 8.h),
          Container(
            height: 13.h,
            width: 70.w,
            decoration: ForYouTabShimmer._roundedDecoration,
          ),
          SizedBox(height: 2.h),
          Container(
            height: 11.h,
            width: 40.w,
            decoration: ForYouTabShimmer._roundedDecoration,
          ),
        ],
      ),
    );
  }
}

class _SuggestedShimmer extends StatelessWidget {
  const _SuggestedShimmer();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: AppShimmerLoading(
          child: Column(
            children: List.generate(3, (index) => const _SuggestedItem()),
          ),
        ),
      ),
    );
  }
}

class _SuggestedItem extends StatelessWidget {
  const _SuggestedItem();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          verticalSpace(10),
          _buildStickerPreviews(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: ForYouTabShimmer._avatarSize,
          height: ForYouTabShimmer._avatarSize,
          decoration: ForYouTabShimmer._circleDecoration,
        ),
        horizontalSpace(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 12.h,
                width: 120.w,
                decoration: ForYouTabShimmer._roundedDecoration,
              ),
              verticalSpace(4),
              Container(
                height: 11.h,
                width: 80.w,
                decoration: ForYouTabShimmer._roundedDecoration,
              ),
            ],
          ),
        ),
        Container(
          width: 60.w,
          height: 30.h,
          decoration: ForYouTabShimmer._roundedDecoration,
        ),
      ],
    );
  }

  Widget _buildStickerPreviews() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        5,
        (index) => Container(
          width: ForYouTabShimmer._stickerPreviewSize,
          height: ForYouTabShimmer._stickerPreviewSize,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }
}
