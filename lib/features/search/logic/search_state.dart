import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/features/search/data/models/search_response.dart';
import 'package:morostick/features/search/data/models/trending_searches_response.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    // Trending Searches
    @Default(false) bool isLoadingTrendingSearches,
    @Default([]) List<TrendingSearchItem> trendingSearches,
    @Default(false) bool hasErrorTrendingSearches,
    GeneralResponse? error,
    // Recent Searches
    @Default([]) List<String> recentSearches,
    // Search Results
    @Default(false) bool isLoadingSearch,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasErrorSearch,
    @Default(false) bool hasReachedMax,
    @Default(false) bool isSearchResultsScreenShowing,
    @Default(1) int currentPage,
    SearchData? searchResults,
    // Search Filters
    @Default(false) bool isFiltersApplied,
    @Default({}) Map<String, dynamic> activeFilters,
  }) = _SearchState;
}
