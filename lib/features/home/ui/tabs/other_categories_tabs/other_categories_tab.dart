import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/widgets/app_snackbar.dart';
import 'package:morostick/features/home/logic/category_packs_cubit/category_packs_cubit.dart';
import 'package:morostick/features/home/logic/category_packs_cubit/category_packs_state.dart';
import 'package:morostick/features/home/ui/tabs/foryou_tab/foryou_tab.dart';
import 'package:morostick/features/home/ui/tabs/foryou_tab/widgets/no_data.dart';
import 'package:morostick/features/home/ui/tabs/other_categories_tabs/widgets/other_categories_shimmer.dart';
import 'package:morostick/features/home/ui/tabs/trending/widgets/trending_packs.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtherCategoriesTab extends StatefulWidget {
  final ScrollController scrollController;
  final String categoryKey;

  const OtherCategoriesTab({
    super.key,
    required this.scrollController,
    required this.categoryKey,
  });

  @override
  State<OtherCategoriesTab> createState() => _OtherCategoriesTabState();
}

class _OtherCategoriesTabState extends State<OtherCategoriesTab> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<CategoryPacksCubit>().getPacksByCategory(widget.categoryKey);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryPacksCubit, CategoryPacksState>(
      buildWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.hasError != current.hasError ||
          previous.packs != current.packs ||
          previous.isLoadingMore != current.isLoadingMore,
      listener: (context, state) {
        if (state.hasError && state.errorMessage != null) {
          if (!state.errorMessage!.contains("Internet")) {
            showAppSnackbar(
              title: state.errorMessage!,
              type: ToastificationType.error,
              description: "Something went wrong, please try again later",
            );
          }
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const SingleChildScrollView(
            child: OtherCategoriesTabShimmer(),
          );
        }

        if (state.hasError) {
          return RefreshIndicator(
            onRefresh: () async {
              if (!state.isLoading) {
                context.read<CategoryPacksCubit>().refresh(widget.categoryKey);
              }
            },
            child: Center(
              child: SingleChildScrollView(
                child: NoDataWidget(
                  title: state.errorMessage ?? "Error",
                  icon: state.errorMessage?.contains("Internet") == true
                      ? Icons.wifi_off_rounded
                      : null,
                  message: state.errorDetails ??
                      "Sorry, something went wrong. Please try again later.",
                  onRefresh: () {
                    context
                        .read<CategoryPacksCubit>()
                        .refresh(widget.categoryKey);
                  },
                ),
              ),
            ),
          );
        }

        if (state.packs.isEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              if (!state.isLoading) {
                context.read<CategoryPacksCubit>().refresh(widget.categoryKey);
              }
            },
            child: Center(
              child: SingleChildScrollView(
                child: NoDataWidget(
                  title: "No Data",
                  message: "No packs found for this category",
                  onRefresh: () {
                    context
                        .read<CategoryPacksCubit>()
                        .refresh(widget.categoryKey);
                  },
                ),
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            if (!state.isLoading) {
              context.read<CategoryPacksCubit>().refresh(widget.categoryKey);
            }
          },
          child: LazyLoadingListView(
            padding: EdgeInsets.only(top: 16.h),
            scrollController: widget.scrollController,
            isLoading: state.isLoadingMore,
            hasReachedMax: state.hasReachedMax,
            onLoadMore: () =>
                context.read<CategoryPacksCubit>().loadMore(widget.categoryKey),
            items: state.packs,
            itemBuilder: (context, index) {
              return TrendingPacks(
                trendingPacks: [state.packs[index]],
              );
            },
          ),
        );
      },
    );
  }
}
