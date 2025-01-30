// search_cubit.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/helpers/shared_pref_helper.dart';
import 'package:morostick/features/search/data/models/search_response.dart';
import 'package:morostick/features/search/data/repos/search_repo.dart';
import 'package:morostick/features/search/logic/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  static const String _recentSearchesKey = 'recent_searches';
  static const int _maxRecentSearches = 10;
  static const int _pageSize = 10;

  final SearchRepo _searchRepo;
  final List<Future> _pendingOperations = [];
  String _currentQuery = '';
  bool _isClosed = false;

  final TextEditingController searchController = TextEditingController();

  // Default filter values
  static const Map<String, dynamic> defaultFilters = {
    'sort': null,
    'minStickers': 5.0,
    'searchBy': 'all',
    'stickerType': 'both',
  };

  Map<String, dynamic> _currentFilters = Map.from(defaultFilters);
  Map<String, dynamic> get currentFilters => Map.from(_currentFilters);

  SearchCubit(this._searchRepo) : super(const SearchState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadRecentSearches();
    await fetchTrendingSearches();
  }

  @override
  Future<void> close() async {
    _isClosed = true;
    searchController.dispose();
    if (_pendingOperations.isNotEmpty) {
      await Future.wait(_pendingOperations);
    }
    return super.close();
  }

  Future<void> _loadRecentSearches() async {
    if (_isClosed) return;

    try {
      final searchesString =
          await SharedPrefHelper.getString(_recentSearchesKey);
      final List<String> savedSearches =
          searchesString.isEmpty ? [] : searchesString.split(',');

      if (!_isClosed) {
        emit(state.copyWith(recentSearches: savedSearches));
      }
    } catch (e) {
      if (!_isClosed) {
        emit(state.copyWith(recentSearches: []));
      }
    }
  }

  Future<void> addSearch(String search) async {
    if (_isClosed || search.trim().isEmpty) return;

    try {
      final currentSearches = List<String>.from(state.recentSearches);
      currentSearches.remove(search);
      currentSearches.insert(0, search);

      if (currentSearches.length > _maxRecentSearches) {
        currentSearches.removeLast();
      }

      await SharedPrefHelper.setString(
          _recentSearchesKey, currentSearches.join(','));

      if (!_isClosed) {
        emit(state.copyWith(recentSearches: currentSearches));
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> removeSearch(String search) async {
    if (_isClosed) return;

    try {
      final currentSearches = List<String>.from(state.recentSearches);
      currentSearches.remove(search);

      await SharedPrefHelper.setString(
          _recentSearchesKey, currentSearches.join(','));

      if (!_isClosed) {
        emit(state.copyWith(recentSearches: currentSearches));
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> clearAllSearches() async {
    if (_isClosed) return;

    try {
      await SharedPrefHelper.removeData(_recentSearchesKey);
      if (!_isClosed) {
        emit(state.copyWith(recentSearches: []));
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> fetchTrendingSearches() async {
    if (_isClosed || state.isLoadingTrendingSearches) return;

    emit(state.copyWith(
      isLoadingTrendingSearches: true,
      hasErrorTrendingSearches: false,
      error: null,
    ));

    try {
      final operation = _searchRepo.getTrendingSearches();
      _pendingOperations.add(operation);

      final result = await operation;

      if (!_isClosed) {
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
      }

      _pendingOperations.remove(operation);
    } catch (e) {
      if (!_isClosed) {
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

  Future<void> submitSearch(String query) async {
    if (_isClosed || query.isEmpty) return;

    _currentQuery = query;

    emit(state.copyWith(
      isLoadingSearch: true,
      hasErrorSearch: false,
      searchResults: const SearchData(),
      currentPage: 1,
      hasReachedMax: false,
    ));

    try {
      final operation = _searchRepo.getSearchResults(
        _currentFilters['searchBy'] == 'creator' ? '' : query,
        page: 1,
        limit: _pageSize,
        sortBy: _currentFilters['sort']?.toString().toLowerCase(),
        minStickers: _currentFilters['minStickers']?.round(),
        packType: _currentFilters['stickerType'],
        creatorName: _currentFilters['searchBy'] == 'creator' ? query : null,
      );

      _pendingOperations.add(operation);
      final result = await operation;

      if (!_isClosed) {
        await result.when(
          success: (response) async {
            final searchData = response.searchData;
            emit(state.copyWith(
              isLoadingSearch: false,
              searchResults: searchData ?? const SearchData(packs: []),
              hasErrorSearch: false,
              currentPage: 1,
              hasReachedMax: searchData?.pagination?.hasNextPage == false,
            ));

            if (searchData != null && (searchData.packs?.isNotEmpty ?? false)) {
              await addSearch(query);
            }
          },
          failure: (error) {
            emit(state.copyWith(
              isLoadingSearch: false,
              hasErrorSearch: true,
              error: error.apiErrorModel,
              searchResults: const SearchData(packs: []),
            ));
          },
        );
      }

      _pendingOperations.remove(operation);
    } catch (e) {
      if (!_isClosed) {
        emit(state.copyWith(
          isLoadingSearch: false,
          hasErrorSearch: true,
          error: GeneralResponse(
            success: false,
            status: 500,
            message: e.toString(),
          ),
          searchResults: const SearchData(packs: []),
        ));
      }
    }
  }

  Future<void> updateFilters(Map<String, dynamic> newFilters) async {
    if (_isClosed) return;

    final bool hasChanges = !mapEquals(_currentFilters, newFilters);
    if (!hasChanges) return;

    _currentFilters = Map.from(newFilters);
    emit(state.copyWith(
      activeFilters: newFilters,
      isFiltersApplied: !_areFiltersDefault(newFilters),
    ));

    if (_currentQuery.isNotEmpty) {
      await submitSearch(_currentQuery);
    }
  }

  bool _areFiltersDefault(Map<String, dynamic> filters) {
    return filters['sort'] == defaultFilters['sort'] &&
        filters['minStickers'] == defaultFilters['minStickers'] &&
        filters['searchBy'] == defaultFilters['searchBy'] &&
        filters['stickerType'] == defaultFilters['stickerType'];
  }

  Future<void> loadMore() async {
    if (_isClosed ||
        state.isLoadingSearch ||
        state.hasReachedMax ||
        _currentQuery.isEmpty) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    try {
      final operation = _searchRepo.getSearchResults(
        _currentFilters['searchBy'] == 'creator' ? '' : _currentQuery,
        page: state.currentPage + 1,
        limit: _pageSize,
        sortBy: _currentFilters['sort']?.toString().toLowerCase(),
        minStickers: _currentFilters['minStickers']?.round(),
        packType: _currentFilters['stickerType'],
        creatorName:
            _currentFilters['searchBy'] == 'creator' ? _currentQuery : null,
      );

      _pendingOperations.add(operation);
      final result = await operation;

      if (!_isClosed) {
        result.when(
          success: (response) {
            if (response.searchData != null) {
              final newPacks = response.searchData!.packs ?? [];
              final currentPacks = state.searchResults?.packs ?? [];

              emit(state.copyWith(
                isLoadingMore: false,
                searchResults: SearchData(
                  packs: [...currentPacks, ...newPacks],
                  pagination: response.searchData!.pagination,
                ),
                hasErrorSearch: false,
                currentPage: state.currentPage + 1,
                hasReachedMax:
                    response.searchData!.pagination?.hasNextPage == false,
              ));
            }
          },
          failure: (error) {
            emit(state.copyWith(
              isLoadingMore: false,
              hasErrorSearch: true,
              error: error.apiErrorModel,
            ));
          },
        );
      }

      _pendingOperations.remove(operation);
    } catch (e) {
      if (!_isClosed) {
        emit(state.copyWith(
          isLoadingMore: false,
          hasErrorSearch: true,
          error: GeneralResponse(
            success: false,
            status: 500,
            message: e.toString(),
          ),
        ));
      }
    }
  }

  Future<void> refresh() async {
    if (_isClosed || state.isLoadingSearch || _currentQuery.isEmpty) return;

    emit(state.copyWith(
      isLoadingSearch: true,
      hasErrorSearch: false,
      searchResults: const SearchData(),
      currentPage: 1,
      hasReachedMax: false,
    ));

    try {
      final operation = _searchRepo.getSearchResults(
        _currentFilters['searchBy'] == 'creator' ? '' : _currentQuery,
        page: 1,
        limit: _pageSize,
        sortBy: _currentFilters['sort']?.toString().toLowerCase(),
        minStickers: _currentFilters['minStickers']?.round(),
        packType: _currentFilters['stickerType'],
        creatorName:
            _currentFilters['searchBy'] == 'creator' ? _currentQuery : null,
      );

      _pendingOperations.add(operation);
      final result = await operation;

      if (!_isClosed) {
        result.when(
          success: (response) {
            if (response.searchData != null) {
              emit(state.copyWith(
                isLoadingSearch: false,
                searchResults: response.searchData,
                hasErrorSearch: false,
                currentPage: 1,
                hasReachedMax:
                    response.searchData!.pagination?.hasNextPage == false,
              ));
            }
          },
          failure: (error) {
            emit(state.copyWith(
              isLoadingSearch: false,
              hasErrorSearch: true,
              error: error.apiErrorModel,
            ));
          },
        );
      }

      _pendingOperations.remove(operation);
    } catch (e) {
      if (!_isClosed) {
        emit(state.copyWith(
          isLoadingSearch: false,
          hasErrorSearch: true,
          error: GeneralResponse(
            success: false,
            status: 500,
            message: e.toString(),
          ),
        ));
      }
    }
  }

  void setSearchResultsScreenShowing(bool value) {
    if (!_isClosed) {
      emit(state.copyWith(isSearchResultsScreenShowing: value));
    }
  }
}
