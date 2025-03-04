import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:morostick/core/data/models/pack_model.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';

class StickerGrid extends StatelessWidget {
  final List<Sticker> stickers;
  final bool showAnimatedIndicator;
  final Function(Sticker sticker) onFavoriteToggle;
  final List<Color> colors;

  const StickerGrid({
    super.key,
    required this.stickers,
    this.showAnimatedIndicator = false,
    required this.onFavoriteToggle,
    this.colors = const [],
  });

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      crossAxisCount: 3,
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      itemCount: stickers.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _buildStickerItem(
        stickers[index],
        index,
      ),
    );
  }

  Widget _buildStickerItem(Sticker sticker, int index) {
    return Container(
      decoration: BoxDecoration(
        color: colors.isEmpty
            ? ColorsManager.getRandomColorWithOpacity(0.05)
            : colors[index % colors.length].withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(8.w),
            child: AspectRatio(
                aspectRatio: 1,
                child: AppCachedNetworkImage.thumbnail(
                  imageUrl: sticker.webpUrl ?? '',
                )),
          ),
          Positioned(
            top: 5.h,
            right: 5.w,
            child: _buildFavoriteButton(index),
          ),
          if (showAnimatedIndicator)
            Positioned(
              bottom: 8.h,
              left: 8.w,
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: ColorsManager.mainPurple.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.motion_photos_on_rounded,
                  color: ColorsManager.white,
                  size: 12.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton(int index) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.white.withValues(alpha: 0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onFavoriteToggle(stickers[index]),
          borderRadius: BorderRadius.circular(50),
          child: Padding(
            padding: EdgeInsets.all(7.r),
            child: Icon(
              (stickers[index].isFavorite ?? false)
                  ? Icons.favorite_rounded
                  : Icons.favorite_outline_rounded,
              color: ColorsManager.mainPurple,
              size: 15.sp,
            ),
          ),
        ),
      ),
    );
  }
}
