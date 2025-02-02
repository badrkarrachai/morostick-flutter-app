import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/data/models/pack_model.dart';

part 'favorite_packs_state.freezed.dart';

@freezed
class FavoritePacksState with _$FavoritePacksState {
  const factory FavoritePacksState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasError,
    @Default(false) bool hasReachedMax,
    @Default(1) int currentPage,
    @Default('all') String selectedFilter,
    List<Pack>? favoritePacks,
    PaginationData? pagination,
  }) = _FavoritePacksState;
}
