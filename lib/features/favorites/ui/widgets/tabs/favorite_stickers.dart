import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/images.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_button.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';
import 'package:morostick/features/favorites/ui/widgets/type_modal.dart';

class FavoriteStickers extends StatefulWidget {
  const FavoriteStickers({super.key});

  @override
  State<FavoriteStickers> createState() => _FavoriteStickersState();
}

class _FavoriteStickersState extends State<FavoriteStickers> {
  String selectedFilter = 'All';

  final List<String> regularStickerUrls = List.generate(
    30,
    (index) =>
        'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/pngwing.com%20(2).png',
  );

  final List<String> animatedStickerUrls = List.generate(
    15,
    (index) =>
        'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/pngwing.com%20(2).png',
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _buildFilterChips(),
            Expanded(
              child: _buildStickerGrid(),
            ),
          ],
        ),
        _buildBottomButton(),
      ],
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            _buildFilterChip('All'),
            horizontalSpace(8),
            _buildFilterChip('Regular'),
            horizontalSpace(8),
            _buildFilterChip('Animated'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String filter) {
    final bool isSelected = selectedFilter == filter;
    return InkWell(
      onTap: () => setState(() => selectedFilter = filter),
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorsManager.mainPurple
              : ColorsManager.lighterPurple,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? ColorsManager.mainPurple
                : ColorsManager.mainPurple.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Text(
          filter,
          style: isSelected
              ? TextStyles.font13GrayWhiteRegular
              : TextStyles.font13PurpleRegular,
        ),
      ),
    );
  }

  Widget _buildStickerGrid() {
    final List<String> filteredStickers = _getFilteredStickers();

    return Padding(
      padding: EdgeInsets.only(bottom: 80.h),
      child: MasonryGridView.count(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        crossAxisCount: 3,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        itemCount: filteredStickers.length,
        itemBuilder: (context, index) => _buildStickerItem(
          index,
          filteredStickers[index],
          selectedFilter == 'Animated' ||
              (selectedFilter == 'All' &&
                  animatedStickerUrls.contains(filteredStickers[index])),
        ),
      ),
    );
  }

  List<String> _getFilteredStickers() {
    switch (selectedFilter) {
      case 'Regular':
        return regularStickerUrls;
      case 'Animated':
        return animatedStickerUrls;
      default:
        return [...regularStickerUrls, ...animatedStickerUrls];
    }
  }

  Widget _buildStickerItem(int index, String url, bool isAnimated) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.getRandomColorWithOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              child: Stack(
                children: [
                  AppCachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.contain,
                    borderRadius: BorderRadius.circular(16.r),
                    errorBuilder: (context, url, error) => Container(
                      color: ColorsManager.lighterPurple,
                      child: Icon(
                        Icons.emoji_emotions_outlined,
                        color: ColorsManager.mainPurple,
                        size: 32.sp,
                      ),
                    ),
                  ),
                  if (isAnimated)
                    Positioned(
                      bottom: 1.h,
                      left: 1.w,
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                          color: ColorsManager.mainPurple.withOpacity(0.9),
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
            ),
          ),
          Positioned(
            top: 5.h,
            right: 5.w,
            child: _buildFavoriteButton(index),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton(int index) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.white.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleRemoveFromFavorites(index),
          borderRadius: BorderRadius.circular(50),
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Icon(
              Icons.favorite_rounded,
              color: ColorsManager.mainPurple,
              size: 15.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Positioned(
      bottom: 16.h,
      left: 16.w,
      right: 16.w,
      child: AppButton(
        buttonText: 'Add to WhatsApp',
        textStyle: TextStyles.font16WhiteSemiBold,
        onPressed: _handleAddToWhatsApp,
        borderColor: ColorsManager.whatsappGreen,
        leftIcon: SizedBox(
          width: 23.w,
          height: 23.h,
          child: SvgPicture.asset(Images.whatsappLogo),
        ),
        backgroundColor: ColorsManager.whatsappGreen,
      ),
    );
  }

  void _handleRemoveFromFavorites(int index) {
    setState(() {
      final stickers = _getFilteredStickers();
      final url = stickers[index];
      if (regularStickerUrls.contains(url)) {
        regularStickerUrls.remove(url);
      }
      if (animatedStickerUrls.contains(url)) {
        animatedStickerUrls.remove(url);
      }
    });
  }

  void _handleAddToWhatsApp() {
    showWhatsAppStickerTypeModal(context);
  }
}
