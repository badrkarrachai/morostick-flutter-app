import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/features/search/logic/search_cubit.dart';
import 'package:morostick/features/search/logic/search_state.dart';
import 'package:morostick/features/search/ui/tabs/search_results_screen.dart';
import 'package:morostick/features/search/ui/widgets/recent_searches_widget.dart';
import 'package:morostick/features/search/ui/widgets/trending_searches_loading_shimmer.dart';
import 'package:morostick/features/search/ui/widgets/trending_searches_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchDefaultScreen extends StatefulWidget {
  const SearchDefaultScreen({super.key});

  @override
  State<SearchDefaultScreen> createState() => _SearchDefaultScreenState();
}

class _SearchDefaultScreenState extends State<SearchDefaultScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listenWhen: (previous, current) =>
          previous.isSearchResultsScreenShowing !=
          current.isSearchResultsScreenShowing,
      listener: (context, state) {
        // Only handle screen transitions here
      },
      buildWhen: (previous, current) =>
          previous.isSearchResultsScreenShowing !=
              current.isSearchResultsScreenShowing ||
          previous.isLoadingTrendingSearches !=
              current.isLoadingTrendingSearches ||
          previous.trendingSearches != current.trendingSearches ||
          previous.recentSearches != current.recentSearches,
      builder: (context, state) {
        return IndexedStack(
          index: state.isSearchResultsScreenShowing ? 1 : 0,
          children: [
            // Default Search Screen (index 0)
            RefreshIndicator(
              onRefresh: () async {
                if (!state.isLoadingTrendingSearches) {
                  await context.read<SearchCubit>().fetchTrendingSearches();
                }
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RecentSearchesWidget(
                        searches: state.recentSearches,
                        onClearAll: () =>
                            context.read<SearchCubit>().clearAllSearches(),
                        onRemoveSearch: (search) =>
                            context.read<SearchCubit>().removeSearch(search),
                      ),
                      verticalSpace(24),
                      if (state.isLoadingTrendingSearches &&
                          state.trendingSearches.isEmpty)
                        const TrendingSearchesLoadingShimmer()
                      else if (state.trendingSearches.isNotEmpty)
                        TrendingSearchesWidget(items: state.trendingSearches)
                      else
                        const SizedBox.shrink(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
            // Search Results Screen (index 1)
            const SearchResultsScreen(),
          ],
        );
      },
    );
  }
}
