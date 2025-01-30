import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/widgets/app_snackbar.dart';
import 'package:morostick/features/home/logic/trending_tab_cubit/trending_tab_cubit.dart';
import 'package:morostick/features/home/logic/trending_tab_cubit/trending_tab_state.dart';
import 'package:morostick/features/home/ui/tabs/foryou_tab/foryou_tab.dart';
import 'package:morostick/features/home/ui/tabs/foryou_tab/widgets/no_data.dart';
import 'package:morostick/features/home/ui/tabs/trending/widgets/top_categories.dart';
import 'package:morostick/features/home/ui/tabs/trending/widgets/trending_packs.dart';
import 'package:morostick/features/home/ui/tabs/trending/widgets/trending_shimmer.dart';
import 'package:toastification/toastification.dart';

class TrendingTab extends StatefulWidget {
  final ScrollController scrollController;

  const TrendingTab({super.key, required this.scrollController});

  @override
  State<TrendingTab> createState() => _TrendingTabState();
}

class _TrendingTabState extends State<TrendingTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    if (context.read<TrendingTabCubit>().state.data == null) {
      context.read<TrendingTabCubit>().getTrendingContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocConsumer<TrendingTabCubit, TrendingState>(
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
            child: TrendingShimmer(),
          );
        }

        if (state.hasError) {
          return RefreshIndicator(
            onRefresh: () async {
              if (!state.isLoading) {
                context.read<TrendingTabCubit>().refresh();
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
                    context.read<TrendingTabCubit>().refresh();
                  },
                ),
              ),
            ),
          );
        }

        final trendingData = state.data?.trendingData;
        if (_hasNoData(trendingData)) {
          return RefreshIndicator(
            onRefresh: () async {
              if (!state.isLoading) {
                context.read<TrendingTabCubit>().refresh();
              }
            },
            child: Center(
              child: SingleChildScrollView(
                child: NoDataWidget(
                  title: "No Data",
                  message: "No trending data found",
                  onRefresh: () {
                    context.read<TrendingTabCubit>().refresh();
                  },
                ),
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            if (!state.isLoading) {
              context.read<TrendingTabCubit>().refresh();
            }
          },
          child: LazyLoadingListView(
            scrollController: widget.scrollController,
            isLoading: state.isLoadingMore,
            hasReachedMax: state.hasReachedMax,
            onLoadMore: () =>
                context.read<TrendingTabCubit>().loadMoreContent(),
            headerWidgets: [
              verticalSpace(16),
              TopCategories(
                topCategories: trendingData?.topCategories ?? [],
                categoryColors: state.categoriesColors,
              ),
              verticalSpace(10),
            ],
            items: trendingData?.trending?.packs ?? [],
            itemBuilder: (context, index) {
              return TrendingPacks(
                trendingPacks: [trendingData!.trending!.packs![index]],
              );
            },
          ),
        );
      },
    );
  }

  bool _hasNoData(dynamic trendingData) {
    return trendingData == null ||
        (trendingData.topCategories!.isEmpty &&
            trendingData.trending!.packs!.isEmpty);
  }
}
