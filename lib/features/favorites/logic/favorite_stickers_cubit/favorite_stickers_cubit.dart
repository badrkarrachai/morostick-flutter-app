import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/features/favorites/data/repos/favorite_repo.dart';
import 'package:morostick/features/favorites/logic/favorite_stickers_cubit/favorite_stickers_state.dart';

class FavoriteStickersCubit extends Cubit<FavoriteStickersState> {
  final FavoriteRepo _favoriteRepo;
  static const int _pageSize = 30;
  bool _isClosed = false;
  final List<Future> _pendingOperations = [];
  final AuthNavigationService _authService;

  FavoriteStickersCubit(this._favoriteRepo, this._authService)
      : super(const FavoriteStickersState()) {
    getFavoriteStickers();
  }

  @override
  Future<void> close() async {
    _isClosed = true;
    if (_pendingOperations.isNotEmpty) {
      await Future.wait(_pendingOperations);
    }
    return super.close();
  }

  Future<void> setFilter(StickerType filter) async {
    if (state.selectedFilter == filter) return;

    emit(state.copyWith(selectedFilter: filter));
    await getFavoriteStickers();
  }

  Future<void> getFavoriteStickers() async {
    if (_isClosed || state.isLoading) return;

    emit(state.copyWith(
      isLoading: true,
      hasError: false,
      currentPage: 1,
      hasReachedMax: false,
    ));

    try {
      final operation = _favoriteRepo.getFavoriteStickers(
        1,
        limit: _pageSize,
        type: state.selectedFilter.name,
      );
      _pendingOperations.add(operation);
      final result = await operation;

      if (!_isClosed) {
        result.when(
          success: (response) {
            final stickers = response.favoriteStickersData ?? [];
            final regularStickers =
                stickers.where((s) => !s.isAnimated!).toList();
            final animatedStickers =
                stickers.where((s) => s.isAnimated!).toList();

            emit(state.copyWith(
              isLoading: false,
              hasError: false,
              regularStickers: regularStickers,
              animatedStickers: animatedStickers,
              hasReachedMax: response.pagination?.hasNextPage == false,
              pagination: response.pagination,
            ));
          },
          failure: (error) {
            emit(state.copyWith(
              isLoading: false,
              hasError: true,
              regularStickers: [],
              animatedStickers: [],
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
          regularStickers: [],
          animatedStickers: [],
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
      final operation = _favoriteRepo.getFavoriteStickers(
        nextPage,
        limit: _pageSize,
        type: state.selectedFilter.name,
      );

      _pendingOperations.add(operation);
      final result = await operation;

      if (!_isClosed) {
        result.when(
          success: (response) {
            final newStickers = response.favoriteStickersData ?? [];
            if (newStickers.isNotEmpty) {
              final regularStickers = [
                ...state.regularStickers,
                ...newStickers.where((s) => !s.isAnimated!)
              ];
              final animatedStickers = [
                ...state.animatedStickers,
                ...newStickers.where((s) => s.isAnimated!)
              ];

              emit(state.copyWith(
                isLoadingMore: false,
                currentPage: nextPage,
                hasReachedMax: response.pagination?.hasNextPage == false,
                regularStickers: regularStickers,
                animatedStickers: animatedStickers,
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
    await getFavoriteStickers();
  }

  void removeStickerFromList(String stickerId) {
    final regularStickers = [...state.regularStickers];
    final animatedStickers = [...state.animatedStickers];

    regularStickers.removeWhere((sticker) => sticker.id == stickerId);
    animatedStickers.removeWhere((sticker) => sticker.id == stickerId);

    emit(state.copyWith(
      regularStickers: regularStickers,
      animatedStickers: animatedStickers,
    ));
  }

  bool isStickerAnimated(String stickerId) {
    return state.animatedStickers.any((sticker) => sticker.id == stickerId);
  }

  // TOGGLE FAVORITE STICKER LOGIC
  Future<void> toggleStickerFavorite({
    required String stickerId,
  }) async {
    // check if the user is not in guest mode
    if (_authService.isGuestMode) {
      GuestDialogService.showGuestRestriction(
          message: 'Please login to add this pack to your favourites');
      return;
    }
    if (state.isLoadingFavoriteSticker) return;
    emit(state.copyWith(
      isLoadingFavoriteSticker: true,
    ));
    final operation = _favoriteRepo.toggleStickerFavorite(stickerId).then(
      (response) {
        response.when(
          success: (togglePackFavoriteResponse) {
            emit(state.copyWith(
              isLoadingFavoriteSticker: false,
              isMessageBoxError: false,
              hasError: false,
              error: null,
            ));
            removeStickerFromList(stickerId);
          },
          failure: (error) async {
            if (!await _authService.checkConnectivity()) {
              emit(state.copyWith(
                isLoadingFavoriteSticker: false,
                isMessageBoxError: false,
                hasError: true,
                error: const GeneralResponse(
                  success: false,
                  status: -6,
                  message: 'No Internet Connection',
                ),
              ));
              return;
            }
            emit(state.copyWith(
              isLoadingFavoriteSticker: false,
              isMessageBoxError: true,
              hasError: true,
              error: error.apiErrorModel,
            ));
          },
        );
      },
      onError: (e) {
        emit(state.copyWith(
          isLoadingFavoriteSticker: false,
          isMessageBoxError: true,
          hasError: true,
          error: GeneralResponse(
            success: false,
            status: 500,
            message: "Something went wrong. Please try again later.",
          ),
        ));
      },
    );

    _pendingOperations.add(operation);
    await operation;
    _pendingOperations.remove(operation);
  }
}
