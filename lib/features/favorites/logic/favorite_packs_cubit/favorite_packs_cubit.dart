import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/features/favorites/data/repos/favorite_repo.dart';
import 'package:morostick/features/favorites/logic/favorite_packs_cubit/favorite_packs_state.dart';

class FavoritePacksCubit extends Cubit<FavoritePacksState> {
  final FavoriteRepo _favoriteRepo;
  static const int _pageSize = 10;
  bool _isClosed = false;
  final List<Future> _pendingOperations = [];

  FavoritePacksCubit(this._favoriteRepo) : super(const FavoritePacksState()) {
    getFavoritePacks();
  }

  @override
  Future<void> close() async {
    _isClosed = true;
    if (_pendingOperations.isNotEmpty) {
      await Future.wait(_pendingOperations);
    }
    return super.close();
  }

  Future<void> setFilter(String filter) async {
    emit(state.copyWith(selectedFilter: filter.toLowerCase()));
    await getFavoritePacks(type: filter.toLowerCase());
  }

  Future<void> getFavoritePacks({String? type}) async {
    if (_isClosed || state.isLoading) return;

    // Use the type from the parameter or the stored state filter
    final filterType = (type ?? state.selectedFilter).toLowerCase();

    emit(state.copyWith(
      isLoading: true,
      hasError: false,
      currentPage: 1,
      hasReachedMax: false,
      selectedFilter: filterType,
    ));

    try {
      final operation = _favoriteRepo.getFavoritePacks(
        1,
        limit: _pageSize,
        type: filterType,
      );
      _pendingOperations.add(operation);
      final result = await operation;

      if (!_isClosed) {
        result.when(
          success: (response) {
            final favoritePacksData = response.favoritePacksData;

            emit(state.copyWith(
              isLoading: false,
              hasError: false,
              favoritePacks: favoritePacksData,
              hasReachedMax: response.pagination?.hasNextPage == false,
            ));
          },
          failure: (error) {
            emit(state.copyWith(
              isLoading: false,
              hasError: true,
              favoritePacks: null,
            ));
          },
        );
      }
      _pendingOperations.remove(operation);
    } catch (e) {
      if (!_isClosed) {
        emit(state.copyWith(
          isLoading: false,
          hasError: true,
          favoritePacks: null,
        ));
      }
    }
  }

  Future<void> loadMore() async {
    if (_isClosed ||
        state.isLoadingMore ||
        state.isLoading ||
        state.hasReachedMax) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.currentPage + 1;
      final operation = _favoriteRepo.getFavoritePacks(
        nextPage,
        limit: _pageSize,
        type: state.selectedFilter,
      );

      _pendingOperations.add(operation);
      final result = await operation;

      if (!_isClosed) {
        result.when(
          success: (response) {
            if (response.favoritePacksData != null &&
                state.favoritePacks != null) {
              final currentPacks = state.favoritePacks ?? [];
              final newPacks = response.favoritePacksData ?? [];

              emit(state.copyWith(
                isLoadingMore: false,
                currentPage: nextPage,
                hasReachedMax: response.pagination?.hasNextPage == false,
                favoritePacks: [...currentPacks, ...newPacks],
                pagination: response.pagination,
              ));
            } else {
              emit(state.copyWith(
                isLoadingMore: false,
                hasReachedMax: true,
              ));
            }
          },
          failure: (error) {
            emit(state.copyWith(
              isLoadingMore: false,
              hasError: true,
            ));
          },
        );
      }
      _pendingOperations.remove(operation);
    } catch (e) {
      if (!_isClosed) {
        emit(state.copyWith(
          isLoadingMore: false,
          hasError: true,
        ));
      }
    }
  }

  Future<void> refresh() async {
    // Refresh using the currently selected filter
    await getFavoritePacks(type: state.selectedFilter);
  }

  void removePackFromList(String packId) {
    if (state.favoritePacks == null) return;

    final currentPacks = [...?state.favoritePacks];
    currentPacks.removeWhere((pack) => pack.id == packId);

    emit(state.copyWith(
      favoritePacks: currentPacks,
      pagination: state.pagination,
    ));
  }
}
