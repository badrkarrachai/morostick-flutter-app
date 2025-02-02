import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/data/models/pack_model.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/images.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/widgets/app_button.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';
import 'package:morostick/core/widgets/app_message_box.dart';
import 'package:morostick/features/favorites/logic/favorite_stickers_cubit/favorite_stickers_cubit.dart';
import 'package:morostick/features/favorites/logic/favorite_stickers_cubit/favorite_stickers_state.dart';
import 'package:morostick/features/favorites/ui/widgets/type_modal.dart';
import 'package:morostick/features/home/ui/tabs/foryou_tab/widgets/no_data.dart';
import 'package:morostick/features/home/ui/tabs/other_categories_tabs/widgets/other_categories_shimmer.dart';

class FavoriteStickers extends StatefulWidget {
  const FavoriteStickers({super.key});

  @override
  State<FavoriteStickers> createState() => _FavoriteStickersState();
}

class _FavoriteStickersState extends State<FavoriteStickers>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _removeLoadingOverlay();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<FavoriteStickersCubit>().loadMore();
    }
  }

  void _removeLoadingOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showLoadingOverlay() {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Container(
        color: Colors.black.withValues(alpha: 0.5),
        child: const Center(
          child: CircularProgressIndicator(
            color: ColorsManager.mainPurple,
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        physics: const ClampingScrollPhysics(),
      ),
      child: BlocConsumer<FavoriteStickersCubit, FavoriteStickersState>(
        listener: (context, state) {
          // Handle loading overlay
          if (state.isLoadingFavoriteSticker) {
            _showLoadingOverlay();
          } else {
            _removeLoadingOverlay();
          }

          // Handle error message box
          if (state.isMessageBoxError) {
            AppMessageBoxDialogServiceNonContext.showError(
              title: state.error!.message,
              message: state.error!.error?.details ??
                  "Something went wrong please try again later.",
              onConfirm: () {
                // Optional callback after clicking OK
              },
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const OtherCategoriesTabShimmer();
          }

          final stickers = state.filteredStickers;

          if (state.isEmpty) {
            return Column(
              children: [
                _buildFilterChips(context),
                Expanded(
                  child: NoDataWidget(
                    title: "No Favorite Stickers",
                    message:
                        "You haven't added any stickers to your favorites yet",
                    onRefresh: () =>
                        context.read<FavoriteStickersCubit>().refresh(),
                  ),
                ),
              ],
            );
          }

          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  if (!state.isLoading) {
                    await context.read<FavoriteStickersCubit>().refresh();
                  }
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: _buildFilterChips(context),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(
                        bottom: 80.h,
                        left: 12.w,
                        right: 12.w,
                      ),
                      sliver: SliverMasonryGrid.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12.h,
                        crossAxisSpacing: 12.w,
                        itemBuilder: (context, index) {
                          if (index >= stickers.length) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final sticker = stickers[index];
                          return _buildStickerItem(
                            context,
                            index,
                            sticker,
                            state.selectedFilter == StickerType.animated ||
                                state.selectedFilter == StickerType.all &&
                                    state.animatedStickers.contains(sticker),
                          );
                        },
                        childCount:
                            stickers.length + (state.isLoadingMore ? 1 : 0),
                      ),
                    ),
                  ],
                ),
              ),
              _buildBottomButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    final cubit = context.read<FavoriteStickersCubit>();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildFilterChip(context, 'All', StickerType.all, cubit),
          horizontalSpace(8),
          _buildFilterChip(context, 'Regular', StickerType.regular, cubit),
          horizontalSpace(8),
          _buildFilterChip(context, 'Animated', StickerType.animated, cubit),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, StickerType type,
      FavoriteStickersCubit cubit) {
    final isSelected = cubit.state.selectedFilter == type;
    return InkWell(
      onTap: () => cubit.setFilter(type),
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
                : ColorsManager.mainPurple.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: isSelected
              ? TextStyles.font13GrayWhiteRegular
              : TextStyles.font13PurpleRegular,
        ),
      ),
    );
  }

  Widget _buildStickerGrid(BuildContext context, FavoriteStickersState state,
      List<Sticker> stickers) {
    return Padding(
      padding: EdgeInsets.only(bottom: 80.h),
      child: MasonryGridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        crossAxisCount: 3,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        itemCount: stickers.length,
        itemBuilder: (context, index) {
          final sticker = stickers[index];
          return _buildStickerItem(
            context,
            index,
            sticker,
            state.selectedFilter == StickerType.animated ||
                state.selectedFilter == StickerType.all &&
                    state.animatedStickers.contains(sticker),
          );
        },
      ),
    );
  }

  Widget _buildStickerItem(
      BuildContext context, int index, Sticker sticker, bool isAnimated) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.getRandomColorWithOpacity(0.05),
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
              child: Stack(
                children: [
                  AppCachedNetworkImage(
                    imageUrl: sticker.webpUrl!,
                    fit: BoxFit.contain,
                    borderRadius: BorderRadius.circular(16.r),
                    errorWidget: Container(
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
                          color:
                              ColorsManager.mainPurple.withValues(alpha: 0.9),
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
            child: _buildFavoriteButton(context, sticker.id),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context, String stickerId) {
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
          onTap: () => context
              .read<FavoriteStickersCubit>()
              .toggleStickerFavorite(stickerId: stickerId),
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

  void _handleAddToWhatsApp() {
    showWhatsAppStickerTypeModal(context);
  }
}
