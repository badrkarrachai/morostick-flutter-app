import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/data/models/pack_model.dart';

part 'view_pack_details_state.freezed.dart';

@freezed
class ViewPackDetailsState with _$ViewPackDetailsState {
  const factory ViewPackDetailsState({
    @Default(false) bool isLoadingPack,
    @Default(false) bool isLoadingFavorite,
    @Default(false) bool isLoadingHide,
    @Default(0) int downloadCount,
    @Default(0) int favoriteCount,
    @Default(false) bool hasError,
    @Default(false) bool isMessageBoxError,
    @Default(false) bool isFavorite,
    GeneralResponse? error,
    Pack? pack,
  }) = _ViewPackDetailsState;
}
