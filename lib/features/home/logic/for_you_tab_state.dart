import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/features/home/data/models/for_you_tab_response.dart';

part 'for_you_tab_state.freezed.dart';

@freezed
class ForYouState with _$ForYouState {
  const factory ForYouState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasError,
    GeneralResponse? error,
    ForYouResponse? data,
    @Default(1) int currentPage,
    @Default(false) bool hasReachedMax,
  }) = _ForYouState;
}
