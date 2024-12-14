import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/home/data/models/for_you_tab_response.dart';
import 'package:morostick/features/home/ui/widgets/tabs/for_you_tab/widgets/sticker_pack_card.dart';

class RecommendedPacksCarousel extends StatefulWidget {
  final List<StickerPack> stickerPacks;

  const RecommendedPacksCarousel({
    super.key,
    required this.stickerPacks,
  });

  @override
  State<RecommendedPacksCarousel> createState() =>
      _RecommendedStickersCarouselState();
}

class _RecommendedStickersCarouselState
    extends State<RecommendedPacksCarousel> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  late List<Color> _packColors;

  @override
  void initState() {
    super.initState();
    // Generate colors for all packs once
    _packColors = List.generate(
      widget.stickerPacks.length,
      (_) => ColorsManager.getRandomColor(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.stickerPacks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w, bottom: 12.h),
          child: Text(
            'Recommended For You',
            style: TextStyles.font14DarkPurpleSemiBold,
          ),
        ),
        CarouselSlider.builder(
          carouselController: _controller,
          options: CarouselOptions(
            height: 150.h,
            viewportFraction: 0.9,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (index, reason) {
              if (mounted) {
                setState(() => _current = index);
              }
            },
          ),
          itemCount: widget.stickerPacks.length,
          itemBuilder: (context, index, realIndex) {
            return StickerPackCard(
              stickerPack: widget.stickerPacks[index],
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              color: _packColors[index],
            );
          },
        ),
        if (widget.stickerPacks.length > 1) ...[
          SizedBox(height: 12.h),
          CarouselIndicators(
            itemCount: widget.stickerPacks.length,
            currentPage: _current,
            activeColor: _packColors[_current],
          ),
        ],
      ],
    );
  }
}

// Modify CarouselIndicators class:
class CarouselIndicators extends StatelessWidget {
  final int itemCount;
  final int currentPage;
  final Color activeColor; // Add this

  const CarouselIndicators({
    super.key,
    required this.itemCount,
    required this.currentPage,
    required this.activeColor, // Add this
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => CarouselIndicator(
          isActive: index == currentPage,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          activeColor: activeColor, // Add this
        ),
      ),
    );
  }
}

// Modify CarouselIndicator class:
class CarouselIndicator extends StatelessWidget {
  final bool isActive;
  final EdgeInsetsGeometry? margin;
  final Color activeColor; // Add this

  const CarouselIndicator({
    super.key,
    required this.isActive,
    this.margin,
    required this.activeColor, // Add this
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      width: isActive ? 60.w : 8.w,
      height: 8.h,
      margin: margin,
      decoration: BoxDecoration(
        color: isActive
            ? activeColor
            : activeColor.withOpacity(0.3), // Use activeColor here
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
