import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/widgets/app_snackbar.dart';
import 'package:morostick/features/home/logic/for_you_tab_cubit.dart';
import 'package:morostick/features/home/logic/for_you_tab_state.dart';
import 'package:morostick/features/home/ui/widgets/tabs/for_you_tab/widgets/for_you_loading_shimmer.dart';
import 'package:morostick/features/home/ui/widgets/tabs/for_you_tab/widgets/no_data.dart';
import 'package:morostick/features/home/ui/widgets/tabs/for_you_tab/widgets/recommended_packs_carousel.dart';
import 'package:morostick/features/home/ui/widgets/suggested_for_you.dart';
import 'package:morostick/features/home/ui/widgets/tabs/for_you_tab/widgets/trending_this_month_collection.dart';

class ForYouTab extends StatefulWidget {
  const ForYouTab({super.key});

  @override
  State<ForYouTab> createState() => _ForYouTabState();
}

class _ForYouTabState extends State<ForYouTab>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _scrollController.addListener(_scrollListener);
  }

  void _initializeData() {
    // Only fetch if we don't have any data
    if (context.read<ForYouCubit>().state.data == null) {
      context.read<ForYouCubit>().getForYouContent();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_isNearBottom && !_isLoadingMore && !_hasReachedMax) {
      context.read<ForYouCubit>().loadMoreContent();
    }
  }

  bool get _isNearBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 200);
  }

  bool get _isLoadingMore => context.read<ForYouCubit>().state.isLoadingMore;
  bool get _hasReachedMax => context.read<ForYouCubit>().state.hasReachedMax;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ForYouCubit>().getForYouContent();
      },
      child: BlocConsumer<ForYouCubit, ForYouState>(
        listener: (context, state) {
          if (state.hasError && state.error != null) {
            final error = state.error!;
            if (!error.success && !error.message.contains("Internet")) {
              showAppSnackbar(
                title: error.message,
                description: error.error?.details ??
                    "Something went wrong, please try again later",
              );
            }
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const ForYouTabShimmer();
          }

          if (state.hasError) {
            return Center(
              child: NoDataWidget(
                title: state.error!.message,
                icon: state.error!.message.contains("Internet")
                    ? Icons.wifi_off_rounded
                    : null,
                message: state.error!.error?.details ??
                    "Please check your internet connection",
                onRefresh: () {
                  context.read<ForYouCubit>().getForYouContent();
                },
              ),
            );
          }

          final forYouData = state.data?.forYouData;
          if (forYouData == null) {
            return const SizedBox.shrink();
          }

          return SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(16),
                RecommendedPacksCarousel(
                  stickerPacks: forYouData.recommended,
                ),
                verticalSpace(16),
                TrendingThisMonthCollection(
                  trendingPacks: forYouData.trending,
                ),
                verticalSpace(25),
                ...[
                  SuggestedForYou(
                    suggestedPacks: forYouData.suggested.packs,
                  ),
                ],
                if (state.isLoadingMore)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
