import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/features/home/data/models/trending_tab_response.dart';
part 'trending_tab_state.freezed.dart';

@freezed
class TrendingState with _$TrendingState {
  const factory TrendingState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasError,
    GeneralResponse? error,
    TrendingResponse? data,
    @Default(1) int currentPage,
    @Default(false) bool hasReachedMax,
    @Default([]) List<Color> categoriesColors,
  }) = _TrendingState;
}
