import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/home/data/models/for_you_tab_response.dart';
import 'package:morostick/features/home/logic/for_you_tab_cubit.dart';
import 'package:morostick/features/home/logic/for_you_tab_state.dart';
import 'package:morostick/features/home/ui/widgets/tabs/for_you_tab/widgets/sticker_pack_card.dart';

class RecommendedPacksCarousel extends StatelessWidget {
  final List<StickerPack> stickerPacks;

  const RecommendedPacksCarousel({
    super.key,
    required this.stickerPacks,
  });

  @override
  Widget build(BuildContext context) {
    if (stickerPacks.isEmpty) {
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
        _CarouselSlider(stickerPacks: stickerPacks),
        if (stickerPacks.length > 1) ...[
          SizedBox(height: 12.h),
          _CarouselIndicators(
            itemCount: stickerPacks.length,
            stickerPacks: stickerPacks,
          ),
        ],
      ],
    );
  }
}

class _CarouselSlider extends StatelessWidget {
  final List<StickerPack> stickerPacks;

  const _CarouselSlider({
    required this.stickerPacks,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForYouCubit, ForYouState>(
      buildWhen: (previous, current) =>
          previous.carouselColors != current.carouselColors,
      builder: (context, state) {
        return CarouselSlider.builder(
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
              context.read<ForYouCubit>().updateCarouselPage(index);
            },
          ),
          itemCount: stickerPacks.length,
          itemBuilder: (context, index, realIndex) {
            final color = index < state.carouselColors.length
                ? state.carouselColors[index]
                : ColorsManager.getRandomColor();

            return StickerPackCard(
              stickerPack: stickerPacks[index],
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              color: color,
            );
          },
        );
      },
    );
  }
}

class _CarouselIndicators extends StatelessWidget {
  final int itemCount;
  final List<StickerPack> stickerPacks;

  const _CarouselIndicators({
    required this.itemCount,
    required this.stickerPacks,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForYouCubit, ForYouState>(
      buildWhen: (previous, current) =>
          previous.carouselCurrentPage != current.carouselCurrentPage ||
          previous.carouselColors != current.carouselColors,
      builder: (context, state) {
        final currentPage = state.carouselCurrentPage;
        final color = currentPage < state.carouselColors.length
            ? state.carouselColors[currentPage]
            : ColorsManager.getRandomColor();

        return CarouselIndicators(
          itemCount: itemCount,
          currentPage: currentPage,
          activeColor: color,
        );
      },
    );
  }
}

class CarouselIndicators extends StatelessWidget {
  final int itemCount;
  final int currentPage;
  final Color activeColor;

  const CarouselIndicators({
    super.key,
    required this.itemCount,
    required this.currentPage,
    required this.activeColor,
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
          activeColor: activeColor,
        ),
      ),
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  final bool isActive;
  final EdgeInsetsGeometry? margin;
  final Color activeColor;

  const CarouselIndicator({
    super.key,
    required this.isActive,
    this.margin,
    required this.activeColor,
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
        color: isActive ? activeColor : activeColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
