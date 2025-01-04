import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morostick/core/data/models/pack_model.dart';

part 'category_packs_state.freezed.dart';

@freezed
class CategoryPacksState with _$CategoryPacksState {
  const factory CategoryPacksState({
    @Default(false) bool isLoading,
    String? categoryKey,
    @Default([]) List<Pack> packs,
    @Default(false) bool hasError,
    String? errorMessage,
    String? errorDetails,
    @Default(false) bool hasReachedMax,
    @Default(false) bool isLoadingMore,
    @Default(1) int currentPage,
  }) = _CategoryPacksState;
}
