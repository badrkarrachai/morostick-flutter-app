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
  final List<StickerPack> stickerPacks;

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
  late final double _indicatorWidth = 8.w;
  late final double _indicatorHeight = 8.h;
  late final double _activeIndicatorWidth = 60.w;

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
            color: state.colors.isEmpty
                ? Colors.grey
                : state.colors[index % state.colors.length],
          );
        },
      ),
    );
  }

  Widget _buildIndicators(CarouselState state) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.stickerPacks.length,
          (index) => _buildIndicator(
            isActive: index == state.currentPage,
            activeColor: state.activeColor,
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator({
    required bool isActive,
    required Color activeColor,
  }) {
    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: AnimatedContainer(
          duration: _indicatorAnimationDuration,
          curve: Curves.easeOutCubic,
          width: isActive ? _activeIndicatorWidth : _indicatorWidth,
          height: _indicatorHeight,
          decoration: BoxDecoration(
            color: isActive ? activeColor : activeColor.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
    );
  }
}

class _CarouselItem extends StatelessWidget {
  final StickerPack stickerPack;
  final Color color;

  const _CarouselItem({
    super.key,
    required this.stickerPack,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: StickerPackCard(
          stickerPack: stickerPack,
          color: color,
        ),
      ),
    );
  }
}
