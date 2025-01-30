import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/widgets/app_snackbar.dart';
import 'package:morostick/features/home/ui/tabs/foryou_tab/widgets/no_data.dart';
import 'package:morostick/features/home/ui/tabs/other_categories_tabs/widgets/other_categories_shimmer.dart';
import 'package:morostick/features/home/ui/tabs/trending/widgets/trending_packs.dart';
import 'package:morostick/features/search/logic/search_cubit.dart';
import 'package:morostick/features/search/logic/search_state.dart';
import 'package:morostick/features/search/ui/widgets/selected_filters_view.dart';
import 'package:morostick/features/search/ui/widgets/serach_filters_bottom_sheet.dart';
import 'package:toastification/toastification.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listenWhen: (previous, current) =>
          previous.hasErrorSearch != current.hasErrorSearch ||
          previous.error != current.error,
      listener: (context, state) {
        if (state.hasErrorSearch && state.error != null) {
          if (!state.error!.message.contains("Internet")) {
            showAppSnackbar(
              title: state.error!.message,
              type: ToastificationType.error,
              description: "Something went wrong, please try again later",
            );
          }
        }
      },
      buildWhen: (previous, current) =>
          previous.isLoadingSearch != current.isLoadingSearch ||
          previous.hasErrorSearch != current.hasErrorSearch ||
          previous.searchResults?.packs != current.searchResults?.packs ||
          previous.isLoadingMore != current.isLoadingMore ||
          previous.activeFilters != current.activeFilters ||
          previous.isFiltersApplied != current.isFiltersApplied,
      builder: (context, state) {
        final searchCubit = context.read<SearchCubit>();
        final packs = state.searchResults?.packs ?? [];

        if (state.isLoadingSearch) {
          return const OtherCategoriesTabShimmer();
        }

        if (packs.isEmpty) {
          return Column(
            children: [
              verticalSpace(5),
              SelectedFiltersView(
                filters: searchCubit.currentFilters,
                onOpenFilters: () => _showFiltersBottomSheet(context),
                onClearAll: () {
                  searchCubit.updateFilters(SearchCubit.defaultFilters);
                },
                onRemoveFilter: (filterKey) {
                  final newFilters =
                      Map<String, dynamic>.from(searchCubit.currentFilters);
                  switch (filterKey) {
                    case 'sort':
                      newFilters[filterKey] = null;
                      break;
                    case 'minStickers':
                      newFilters[filterKey] = 5.0;
                      break;
                    case 'searchBy':
                      newFilters[filterKey] = 'all';
                      break;
                    case 'stickerType':
                      newFilters[filterKey] = 'both';
                      break;
                  }
                  searchCubit.updateFilters(newFilters);
                },
              ),
              verticalSpace(16),
              Expanded(
                child: NoDataWidget(
                  title: "No Results",
                  message: "No packs found for your search",
                  onRefresh: () => searchCubit.refresh(),
                ),
              ),
            ],
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            if (!state.isLoadingSearch) {
              await searchCubit.refresh();
            }
          },
          child: CustomScrollView(
            slivers: [
              // Filters Section
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    verticalSpace(5),
                    SelectedFiltersView(
                      filters: searchCubit.currentFilters,
                      onOpenFilters: () => _showFiltersBottomSheet(context),
                      onClearAll: () {
                        searchCubit.updateFilters(SearchCubit.defaultFilters);
                      },
                      onRemoveFilter: (filterKey) {
                        final newFilters = Map<String, dynamic>.from(
                            searchCubit.currentFilters);
                        switch (filterKey) {
                          case 'sort':
                            newFilters[filterKey] = null;
                            break;
                          case 'minStickers':
                            newFilters[filterKey] = 5.0;
                            break;
                          case 'searchBy':
                            newFilters[filterKey] = 'all';
                            break;
                          case 'stickerType':
                            newFilters[filterKey] = 'both';
                            break;
                        }
                        searchCubit.updateFilters(newFilters);
                      },
                    ),
                    verticalSpace(16),
                  ],
                ),
              ),

              // Content Section
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == packs.length && state.isLoadingMore) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (index == packs.length) {
                      return null;
                    }

                    return TrendingPacks(
                      trendingPacks: [packs[index]],
                    );
                  },
                  childCount: packs.length + 1,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFiltersBottomSheet(BuildContext context) async {
    final searchCubit = context.read<SearchCubit>();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (_, scrollController) => BlocProvider.value(
          value: searchCubit,
          child: FilterBottomSheet(
            initialFilters: searchCubit.currentFilters,
          ),
        ),
      ),
    );
  }
}
