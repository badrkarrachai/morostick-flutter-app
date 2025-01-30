import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/features/home/data/models/foryou_tab_response.dart';

part 'foryou_tab_state.freezed.dart';

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
    @Default(CarouselState()) CarouselState carouselState,
  }) = _ForYouState;
}

@freezed
class CarouselState with _$CarouselState {
  const factory CarouselState({
    @Default(0) int currentPage,
    @Default([]) List<Color> colors,
    @Default(CarouselStatus.initial) CarouselStatus status,
  }) = _CarouselState;

  const CarouselState._();

  Color get activeColor =>
      colors.isEmpty ? Colors.grey : colors[currentPage % colors.length];
}

enum CarouselStatus { initial, loading, loaded, error }
