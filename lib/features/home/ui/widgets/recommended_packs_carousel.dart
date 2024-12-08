import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/home/ui/widgets/sticker_pack_card.dart';

class StickerPack {
  final String title;
  final String imageUrl;
  final int stickerCount;
  final Color? backgroundColor;

  const StickerPack({
    required this.title,
    required this.imageUrl,
    required this.stickerCount,
    this.backgroundColor,
  });
}

class RecommendedPacksCarousel extends StatefulWidget {
  const RecommendedPacksCarousel({super.key});

  @override
  State<RecommendedPacksCarousel> createState() =>
      _RecommendedStickersCarouselState();
}

class _RecommendedStickersCarouselState
    extends State<RecommendedPacksCarousel> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  static List<StickerPack> stickerPacks = [
    StickerPack(
      title: 'Smart Pack',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/pngwing.com%20(3).png',
      stickerCount: 12,
      backgroundColor: ColorsManager.getRandomColor(),
    ),
    StickerPack(
      title: 'Dogs Stickers',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/pngwing.com%20(2).png',
      stickerCount: 17,
      backgroundColor: ColorsManager.getRandomColor(),
    ),
    StickerPack(
      title: 'Cats Stickers',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/pngwing.com%20(1).png',
      stickerCount: 20,
      backgroundColor: ColorsManager.getRandomColor(),
    ),
    StickerPack(
      title: 'Mood Stickers',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/pngwing.com%20(4).png',
      stickerCount: 13,
      backgroundColor: ColorsManager.getRandomColor(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w, bottom: 12.h),
          child: Text(
            'Recommended for you',
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
            autoPlayAnimationDuration: const Duration(milliseconds: 500),
            autoPlayCurve: Curves.easeInOut,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (index, reason) {
              setState(() => _current = index);
            },
          ),
          itemCount: stickerPacks.length,
          itemBuilder: (context, index, realIndex) {
            return StickerPackCard(
              stickerPack: stickerPacks[index],
              margin: EdgeInsets.symmetric(horizontal: 4.w),
            );
          },
        ),
        SizedBox(height: 12.h),
        CarouselIndicators(
          itemCount: stickerPacks.length,
          currentPage: _current,
          activeColor: stickerPacks[_current].backgroundColor!, // Add this
        ),
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
