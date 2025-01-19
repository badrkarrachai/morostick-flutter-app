import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
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
  }) = _SearchState;
}
