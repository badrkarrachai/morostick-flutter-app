import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/widgets/app_snackbar.dart';
import 'package:morostick/features/home/logic/for_you_tab_cubit.dart';
import 'package:morostick/features/home/logic/for_you_tab_state.dart';
import 'package:morostick/features/home/ui/home_screen.dart';
import 'package:morostick/features/home/ui/widgets/tabs/for_you_tab/widgets/for_you_loading_shimmer.dart';
import 'package:morostick/features/home/ui/widgets/tabs/for_you_tab/widgets/no_data.dart';
import 'package:morostick/features/home/ui/widgets/tabs/for_you_tab/widgets/recommended_packs_carousel.dart';
import 'package:morostick/features/home/ui/widgets/suggested_for_you.dart';
import 'package:morostick/features/home/ui/widgets/tabs/for_you_tab/widgets/trending_this_month_collection.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForYouTab extends StatefulWidget {
  const ForYouTab({super.key});

  @override
  State<ForYouTab> createState() => _ForYouTabState();
}

class _ForYouTabState extends State<ForYouTab>
    with AutomaticKeepAliveClientMixin {
  DateTime? _lastLoadTime;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    if (context.read<ForYouCubit>().state.data == null) {
      context.read<ForYouCubit>().getForYouContent();
    }
  }

  bool _shouldLoadMore(ScrollNotification notification) {
    // Only handle vertical scroll notifications
    if (notification.metrics.axis != Axis.vertical) return false;

    final forYouCubit = context.read<ForYouCubit>();
    if (forYouCubit.state.isLoadingMore || forYouCubit.state.hasReachedMax) {
      return false;
    }

    // Throttle the load more calls
    if (_lastLoadTime != null) {
      final timeSinceLastLoad = DateTime.now().difference(_lastLoadTime!);
      if (timeSinceLastLoad.inMilliseconds < 500) {
        return false;
      }
    }

    // Check if notification is from our main scroll view, not from child scrollable
    if (notification.depth != 0) return false;

    // Get metrics from the notification
    final metrics = notification.metrics;
    final maxScroll = metrics.maxScrollExtent;
    final currentScroll = metrics.pixels;
    final loadMoreThreshold = maxScroll * 0.85;

    // Only load more if we're scrolling downward and near the bottom
    if (notification is ScrollUpdateNotification) {
      final isScrollingDown =
          notification.scrollDelta != null && notification.scrollDelta! > 0;

      if (isScrollingDown && currentScroll >= loadMoreThreshold) {
        _lastLoadTime = DateTime.now();
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (_shouldLoadMore(notification)) {
          context.read<ForYouCubit>().loadMoreContent();
        }
        return false;
      },
      child: BlocConsumer<ForYouCubit, ForYouState>(
        buildWhen: (previous, current) =>
            previous.isLoading != current.isLoading ||
            previous.hasError != current.hasError ||
            previous.data != current.data ||
            previous.isLoadingMore != current.isLoadingMore,
        listener: (context, state) {
          if (state.hasError && state.error != null) {
            final error = state.error!;
            if (!error.success && !error.message.contains("Internet")) {
              showAppSnackbar(
                title: error.message,
                type: ToastificationType.error,
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

          return CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    verticalSpace(16),
                    RecommendedPacksCarousel(
                      stickerPacks: forYouData.recommended,
                    ),
                    verticalSpace(25),
                    TrendingThisMonthCollection(
                      trendingPacks: forYouData.trending,
                      onSeeAllPressed: () {
                        HomeScreen.switchToTrendingTab(context, 1);
                      },
                    ),
                    verticalSpace(25),
                    SuggestedForYou(
                      suggestedPacks: forYouData.suggested.packs,
                    ),
                    if (state.isLoadingMore)
                      Center(
                        child: SizedBox(
                          width: 25.h,
                          height: 25.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                    verticalSpace(20),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
