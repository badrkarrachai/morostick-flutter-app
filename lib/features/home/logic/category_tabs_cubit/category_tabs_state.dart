import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morostick/core/data/models/pack_model.dart';

part 'category_tabs_state.freezed.dart';

@freezed
class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    @Default(false) bool isLoading,
    @Default([]) List<Category> categories,
    @Default([]) List<StickerPack> stickerPacks,
    @Default(false) bool hasError,
    String? errorMessage,
  }) = _CategoriesState;
}
