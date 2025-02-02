import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/data/models/pack_model.dart';

part 'favorite_stickers_state.freezed.dart';

enum StickerType { all, regular, animated }

@freezed
class FavoriteStickersState with _$FavoriteStickersState {
  const factory FavoriteStickersState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasError,
    @Default(false) bool hasReachedMax,
    @Default(1) int currentPage,
    @Default(StickerType.all) StickerType selectedFilter,
    @Default([]) List<Sticker> regularStickers,
    @Default([]) List<Sticker> animatedStickers,
    PaginationData? pagination,
    @Default(false) bool isFavorite,
    @Default(false) bool isLoadingFavoriteSticker,
    @Default(false) bool isMessageBoxError,
    GeneralResponse? error,
  }) = _FavoriteStickersState;

  const FavoriteStickersState._();

  List<Sticker> get filteredStickers {
    switch (selectedFilter) {
      case StickerType.regular:
        return regularStickers;
      case StickerType.animated:
        return animatedStickers;
      case StickerType.all:
        return [...regularStickers, ...animatedStickers];
    }
  }

  bool get isEmpty => regularStickers.isEmpty && animatedStickers.isEmpty;
}
