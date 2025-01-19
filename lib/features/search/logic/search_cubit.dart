import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/helpers/shared_pref_helper.dart';
import 'package:morostick/features/search/data/repos/search_repo.dart';
import 'package:morostick/features/search/logic/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  static const String _recentSearchesKey = 'recent_searches';
  static const int _maxRecentSearches = 10;
  final SearchRepo _searchRepo;
  final List<Future> _pendingOperations = [];

  SearchCubit(this._searchRepo) : super(const SearchState()) {
    _loadRecentSearches();
    fetchTrendingSearches();
  }

  @override
  Future<void> close() async {
    // Wait for all pending operations to complete
    if (_pendingOperations.isNotEmpty) {
      await Future.wait(_pendingOperations);
    }
    return super.close();
  }

  Future<void> _loadRecentSearches() async {
    try {
      final searchesString =
          await SharedPrefHelper.getString(_recentSearchesKey);
      final List<String> savedSearches =
          searchesString.isEmpty ? [] : searchesString.split(',');

      emit(state.copyWith(recentSearches: savedSearches));
    } catch (e) {
      emit(state.copyWith(recentSearches: []));
    }
  }

  Future<void> addSearch(String search) async {
    if (search.trim().isEmpty) return;

    try {
      final currentSearches = List<String>.from(state.recentSearches);

      // Remove if already exists
      currentSearches.remove(search);

      // Add to front
      currentSearches.insert(0, search);

      // Keep only most recent
      if (currentSearches.length > _maxRecentSearches) {
        currentSearches.removeLast();
      }

      // Save to SharedPreferences using helper
      await SharedPrefHelper.setString(
          _recentSearchesKey, currentSearches.join(','));

      emit(state.copyWith(recentSearches: currentSearches));
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> removeSearch(String search) async {
    try {
      final currentSearches = List<String>.from(state.recentSearches);
      currentSearches.remove(search);

      // Save using helper
      await SharedPrefHelper.setString(
          _recentSearchesKey, currentSearches.join(','));

      emit(state.copyWith(recentSearches: currentSearches));
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> clearAllSearches() async {
    try {
      await SharedPrefHelper.removeData(_recentSearchesKey);
      emit(state.copyWith(recentSearches: []));
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> fetchTrendingSearches() async {
    if (state.isLoadingTrendingSearches) return;

    emit(state.copyWith(
      isLoadingTrendingSearches: true,
      hasErrorTrendingSearches: false,
      error: null,
    ));

    try {
      final operation = _searchRepo.getTrendingSearches();
      _pendingOperations.add(operation);

      final result = await operation;

      result.when(
        success: (response) {
          if (response.trendingData != null) {
            emit(state.copyWith(
              isLoadingTrendingSearches: false,
              trendingSearches: response.trendingData!.trending,
              hasErrorTrendingSearches: false,
              error: null,
            ));
          } else {
            emit(state.copyWith(
              isLoadingTrendingSearches: false,
              hasErrorTrendingSearches: true,
              error: const GeneralResponse(
                success: false,
                status: 500,
                message: 'Invalid response format',
              ),
            ));
          }
        },
        failure: (error) {
          emit(state.copyWith(
            isLoadingTrendingSearches: false,
            hasErrorTrendingSearches: true,
            error: error.apiErrorModel,
          ));
        },
      );

      _pendingOperations.remove(operation);
    } catch (e) {
      emit(state.copyWith(
        isLoadingTrendingSearches: false,
        hasErrorTrendingSearches: true,
        error: GeneralResponse(
          success: false,
          status: 500,
          message: e.toString(),
        ),
      ));
    }
  }
}
