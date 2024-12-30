import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/widgets/app_snackbar.dart';
import 'package:morostick/features/home/logic/foryou_tab_cubit/foryou_tab_cubit.dart';
import 'package:morostick/features/home/logic/foryou_tab_cubit/foryou_tab_state.dart';
import 'package:morostick/features/home/ui/home_screen.dart';
import 'package:morostick/features/home/ui/tabs/foryou_tab/widgets/foryou_loading_shimmer.dart';
import 'package:morostick/features/home/ui/tabs/foryou_tab/widgets/no_data.dart';
import 'package:morostick/features/home/ui/tabs/foryou_tab/widgets/recommended_packs_carousel.dart';
import 'package:morostick/features/home/ui/tabs/foryou_tab/widgets/suggested_for_you.dart';
import 'package:morostick/features/home/ui/tabs/foryou_tab/widgets/trending_this_month_collection.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForYouTab extends StatefulWidget {
  final ScrollController scrollController;

  const ForYouTab({
    super.key,
    required this.scrollController,
  });

  @override
  State<ForYouTab> createState() => _ForYouTabState();
}

class _ForYouTabState extends State<ForYouTab>
    with AutomaticKeepAliveClientMixin {
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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocConsumer<ForYouCubit, ForYouState>(
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
          return const SingleChildScrollView(
            child: ForYouTabShimmer(),
          );
        }

        if (state.hasError) {
          return RefreshIndicator(
            onRefresh: () async {
              if (!state.isLoading) {
                context.read<ForYouCubit>().refresh();
              }
            },
            child: Center(
              child: SingleChildScrollView(
                child: NoDataWidget(
                  title: state.error!.message,
                  icon: state.error!.message.contains("Internet")
                      ? Icons.wifi_off_rounded
                      : null,
                  message: state.error!.error?.details ??
                      "Please check your internet connection",
                  onRefresh: () {
                    context.read<ForYouCubit>().refresh();
                  },
                ),
              ),
            ),
          );
        }

        final forYouData = state.data?.forYouData;
        if (_hasNoData(forYouData)) {
          return RefreshIndicator(
            onRefresh: () async {
              if (!state.isLoading) {
                context.read<ForYouCubit>().refresh();
              }
            },
            child: Center(
              child: SingleChildScrollView(
                child: NoDataWidget(
                  title: "No Data",
                  message: "No data found for you",
                  onRefresh: () {
                    context.read<ForYouCubit>().refresh();
                  },
                ),
              ),
            ),
          );
        }

        // Using LazyLoadingListView for efficient loading
        return RefreshIndicator(
          onRefresh: () async {
            if (!state.isLoading) {
              context.read<ForYouCubit>().refresh();
            }
          },
          child: LazyLoadingListView(
            scrollController: widget.scrollController,
            isLoading: state.isLoadingMore,
            hasReachedMax: state.hasReachedMax,
            onLoadMore: () => context.read<ForYouCubit>().loadMoreContent(),
            headerWidgets: [
              verticalSpace(16),
              RecommendedPacksCarousel(
                stickerPacks: forYouData?.recommended ?? [],
              ),
              verticalSpace(25),
              TrendingThisMonthCollection(
                trendingPacks: forYouData?.trending ?? [],
                onSeeAllPressed: () =>
                    HomeScreen.switchToTrendingTab(context, 1),
              ),
              verticalSpace(25),
            ],
            items: forYouData?.suggested?.packs ?? [],
            itemBuilder: (context, index) {
              return SuggestedForYou(
                suggestedPacks: [forYouData!.suggested!.packs![index]],
              );
            },
          ),
        );
      },
    );
  }

  bool _hasNoData(dynamic forYouData) {
    return forYouData == null ||
        (forYouData.recommended!.isEmpty &&
            forYouData.trending!.isEmpty &&
            forYouData.suggested!.packs!.isEmpty);
  }
}

// Optimized LazyLoadingListView
class LazyLoadingListView extends StatelessWidget {
  final List<dynamic> items;
  final bool isLoading;
  final VoidCallback onLoadMore;
  final Widget Function(BuildContext, int) itemBuilder;
  final bool hasReachedMax;
  final List<Widget>? headerWidgets; // Made optional
  final ScrollController scrollController;
  final EdgeInsetsGeometry? padding;

  const LazyLoadingListView({
    super.key,
    required this.items,
    required this.isLoading,
    required this.onLoadMore,
    required this.itemBuilder,
    this.headerWidgets, // Optional parameter
    this.hasReachedMax = false,
    required this.scrollController,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final headersLength = headerWidgets?.length ?? 0;

    return ListView.builder(
      controller: scrollController,
      padding: padding,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: headersLength + items.length + (hasReachedMax ? 0 : 1),
      itemBuilder: (context, index) {
        // Handle header widgets if they exist
        if (headerWidgets != null && index < headersLength) {
          return headerWidgets![index];
        }

        // Adjust index for actual items
        final itemIndex = index - headersLength;

        // Handle loading more indicator
        if (itemIndex == items.length) {
          if (!hasReachedMax) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onLoadMore();
            });

            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: SizedBox(
                  width: 25.h,
                  height: 25.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
              ),
            );
          }
          return null;
        }

        // Build regular item
        return itemBuilder(context, itemIndex);
      },
    );
  }
}
