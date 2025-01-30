import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/images.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/widgets/app_button.dart';
import 'package:morostick/core/widgets/app_message_box.dart';
import 'package:morostick/features/favorites/ui/widgets/type_modal.dart';
import 'package:morostick/features/home/ui/tabs/foryou_tab/widgets/no_data.dart';
import 'package:morostick/features/pack/logic/view_pack_details_cubit.dart';
import 'package:morostick/features/pack/logic/view_pack_details_state.dart';
import 'package:morostick/features/pack/ui/widgets/creator_info.dart';
import 'package:morostick/features/pack/ui/widgets/loading_pack_shimmer.dart';
import 'package:morostick/features/pack/ui/widgets/pack_app_bar.dart';
import 'package:morostick/features/pack/ui/widgets/pack_header.dart';
import 'package:morostick/features/pack/ui/widgets/sticker_grid.dart';

class PackScreen extends StatefulWidget {
  const PackScreen({
    super.key,
  });

  @override
  State<PackScreen> createState() => _PackScreenState();
}

class _PackScreenState extends State<PackScreen> {
  @override
  void initState() {
    super.initState();
    _loadPackDetails();
  }

  void _loadPackDetails() {
    context.read<ViewPackDetailsCubit>().getPackDetails();
  }

  void _toggleFavorite(String packId, bool isFavorite) {
    if (!mounted) return;
    context.read<ViewPackDetailsCubit>().togglePackFavorite(packId, isFavorite);
  }

  void _handleHide(String packId, BuildContext otherContext) {
    context.read<ViewPackDetailsCubit>().handelHidePack(packId, otherContext);
  }

  void _handleReportMessagBox(Function(BuildContext) showReportDialog) {
    context
        .read<ViewPackDetailsCubit>()
        .handelReportPackMessageBox(showReportDialog);
  }

  void _handleReport(String packId, String reason) {
    context.read<ViewPackDetailsCubit>().reportPack(packId, reason);
    context.pop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewPackDetailsCubit, ViewPackDetailsState>(
      builder: (context, state) {
        if (state.isLoadingPack) {
          return Scaffold(
            backgroundColor: ColorsManager.backgroundLightColor,
            appBar: PackAppBar(
              isFavorite: state.pack?.isFavorite ?? false,
              onFavoriteToggle: _toggleFavorite,
              onHide: _handleHide,
              onReport: _handleReport,
              isLoading: state.isLoadingPack,
              packId: '',
              mainContext: context,
              handelReportMessagBox: _handleReportMessagBox,
            ),
            body: const SafeArea(
              child: Center(
                child: StickerPackDetailShimmer(),
              ),
            ),
          );
        }
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

        if (state.hasError) {
          return RefreshIndicator(
            onRefresh: () async {
              if (!state.isLoadingPack) {
                context.read<ViewPackDetailsCubit>().refresh();
              }
            },
            child: Scaffold(
              appBar: PackAppBar(
                isFavorite: state.pack?.isFavorite ?? false,
                onFavoriteToggle: _toggleFavorite,
                onHide: _handleHide,
                onReport: _handleReport,
                isLoading: state.isLoadingPack,
                packId: '',
                mainContext: context,
                handelReportMessagBox: _handleReportMessagBox,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: NoDataWidget(
                    title: state.error!.message,
                    icon: state.error!.message.contains("Internet")
                        ? Icons.wifi_off_rounded
                        : null,
                    message: state.error!.error?.details ??
                        "Please check your internet connection",
                    onRefresh: () {
                      context.read<ViewPackDetailsCubit>().refresh();
                    },
                  ),
                ),
              ),
            ),
          );
        }

        final pack = state.pack;
        if (pack == null) {
          return const Scaffold(
            body: Center(
              child: Text('Pack not found'),
            ),
          );
        }

        return Scaffold(
          backgroundColor: ColorsManager.backgroundLightColor,
          appBar: PackAppBar(
            isFavorite: state.isFavorite,
            onFavoriteToggle: _toggleFavorite,
            packId: pack.id,
            onHide: _handleHide,
            onReport: _handleReport,
            mainContext: context,
            handelReportMessagBox: _handleReportMessagBox,
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<ViewPackDetailsCubit>().refresh();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PackHeader(
                      packName: pack.name ?? '',
                      downloads: state.downloadCount,
                      favorites: state.favoriteCount,
                      mainStickerUrl: pack.trayIcon ?? '',
                    ),
                    CreatorInfo(
                      imageUrl: pack.creator.avatarUrl ?? '',
                      name: pack.creator.name ?? '',
                      followers: 0, // Add to your model if needed
                      isVerified: false, // Add to your model if needed
                      isFollowing: false, // Add to your model if needed
                      onFollowTap: () {
                        // Handle follow/unfollow
                      },
                      onCreatorTap: () {
                        // Navigate to creator profile
                      },
                    ),
                    verticalSpace(8),
                    if (pack.stickers != null) ...[
                      StickerGrid(
                        stickers: state.stickers,
                        colors: state.stickerBGColors,
                        onFavoriteToggle: (sticker) {
                          // Handle favoriting logic
                          context
                              .read<ViewPackDetailsCubit>()
                              .toggleStickerFavorite(stickerId: sticker.id);
                        },
                        showAnimatedIndicator: pack.isAnimatedPack!,
                      ),
                    ],
                    verticalSpace(110), // Space for bottom button
                  ],
                ),
              ),
            ),
          ),
          bottomSheet: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: AppButton(
              buttonText: 'Add to WhatsApp',
              textStyle: TextStyles.font16WhiteSemiBold,
              onPressed: () => showWhatsAppStickerTypeModal(context),
              borderColor: ColorsManager.whatsappGreen,
              leftIcon: SizedBox(
                width: 23.w,
                height: 23.h,
                child: SvgPicture.asset(Images.whatsappLogo),
              ),
              backgroundColor: ColorsManager.whatsappGreen,
            ),
          ),
        );
      },
    );
  }
}
