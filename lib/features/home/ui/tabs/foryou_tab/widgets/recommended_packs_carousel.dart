import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/data/models/pack_model.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/home/logic/foryou_tab_cubit/foryou_tab_cubit.dart';
import 'package:morostick/features/home/logic/foryou_tab_cubit/foryou_tab_state.dart';
import 'package:morostick/features/home/ui/tabs/foryou_tab/widgets/sticker_pack_card.dart';

class RecommendedPacksCarousel extends StatefulWidget {
  final List<Pack> stickerPacks;

  const RecommendedPacksCarousel({
    super.key,
    required this.stickerPacks,
  });

  @override
  State<RecommendedPacksCarousel> createState() =>
      _RecommendedPacksCarouselState();
}

class _RecommendedPacksCarouselState extends State<RecommendedPacksCarousel>
    with AutomaticKeepAliveClientMixin {
  // Constants
  static const _carouselAnimationDuration = Duration(milliseconds: 800);
  static const _autoPlayInterval = Duration(seconds: 5);
  static const _indicatorAnimationDuration = Duration(milliseconds: 240);

  // Controllers
  final _carouselController = CarouselSliderController();

  // Cached dimensions
  late final double _carouselHeight = 150.h;
  late final EdgeInsets _titlePadding =
      EdgeInsets.only(left: 20.w, bottom: 12.h);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.stickerPacks.isEmpty) return const SizedBox.shrink();

    return BlocSelector<ForYouCubit, ForYouState, CarouselState>(
      selector: (state) => state.carouselState,
      builder: (context, carouselState) {
        return RepaintBoundary(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              _buildCarousel(carouselState),
              if (widget.stickerPacks.length > 1)
                _buildIndicators(carouselState),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: _titlePadding,
      child: Text(
        'Recommended For You',
        style: TextStyles.font14DarkPurpleSemiBold,
      ),
    );
  }

  Widget _buildCarousel(CarouselState carouselState) {
    switch (carouselState.status) {
      case CarouselStatus.loading:
        return _buildLoadingCarousel();
      case CarouselStatus.error:
        return _buildErrorCarousel();
      case CarouselStatus.loaded:
        return _buildLoadedCarousel(carouselState);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildLoadingCarousel() {
    return SizedBox(
      height: _carouselHeight,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorCarousel() {
    return SizedBox(
      height: _carouselHeight,
      child: const Center(
        child: Icon(Icons.error_outline),
      ),
    );
  }

  Widget _buildLoadedCarousel(CarouselState state) {
    return SizedBox(
      height: _carouselHeight,
      child: CarouselSlider.builder(
        carouselController: _carouselController,
        options: CarouselOptions(
          height: _carouselHeight,
          viewportFraction: 0.9,
          autoPlay: widget.stickerPacks.length > 1,
          autoPlayInterval: _autoPlayInterval,
          autoPlayAnimationDuration: _carouselAnimationDuration,
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          onPageChanged: (index, _) =>
              context.read<ForYouCubit>().updateCarouselPage(index),
        ),
        itemCount: widget.stickerPacks.length,
        itemBuilder: (context, index, _) {
          return _CarouselItem(
            key: ValueKey('carousel_${widget.stickerPacks[index].id}'),
            stickerPack: widget.stickerPacks[index],
            packId: widget.stickerPacks[index].id,
            color: state.colors.isEmpty
                ? Colors.grey
                : state.colors[index % state.colors.length],
          );
        },
      ),
    );
  }

  Widget _buildIndicators(CarouselState state) {
    // Get the current active color
    final activeColor = state.colors.isEmpty
        ? Colors.grey
        : state.colors[state.currentPage % state.colors.length];

    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.stickerPacks.length,
          (index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: AnimatedContainer(
              duration: _indicatorAnimationDuration,
              curve: Curves.easeOutCubic,
              width: index == state.currentPage ? 60.w : 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: activeColor.withValues(
                  alpha: index == state.currentPage ? 1.0 : 0.3,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CarouselItem extends StatelessWidget {
  final Pack stickerPack;
  final Color color;
  final String packId;

  const _CarouselItem({
    super.key,
    required this.stickerPack,
    required this.color,
    required this.packId,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: StickerPackCard(
          packId: packId,
          stickerPack: stickerPack,
          color: color,
        ),
      ),
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color color;
  final double spacing;
  final Duration animationDuration;

  // Cached dimensions using screenutil for responsive sizing
  final double _activeWidth;
  final double _inactiveWidth;
  final double _height;
  final double _radius;

  CarouselIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    required this.color,
    this.spacing = 4.0,
    this.animationDuration = const Duration(milliseconds: 240),
  })  : _activeWidth = 60.w,
        _inactiveWidth = 8.w,
        _height = 8.h,
        _radius = 4.r;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing.w),
          child: _IndicatorDot(
            isActive: index == currentIndex,
            color: color,
            activeWidth: _activeWidth,
            inactiveWidth: _inactiveWidth,
            height: _height,
            radius: _radius,
            animationDuration: animationDuration,
          ),
        ),
      ),
    );
  }
}

class _IndicatorDot extends StatelessWidget {
  final bool isActive;
  final Color color;
  final double activeWidth;
  final double inactiveWidth;
  final double height;
  final double radius;
  final Duration animationDuration;

  const _IndicatorDot({
    required this.isActive,
    required this.color,
    required this.activeWidth,
    required this.inactiveWidth,
    required this.height,
    required this.radius,
    required this.animationDuration,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedContainer(
        duration: animationDuration,
        curve: Curves.easeOutCubic,
        width: isActive ? activeWidth : inactiveWidth,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: isActive ? color : color.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}
