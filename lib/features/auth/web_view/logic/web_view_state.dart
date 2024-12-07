import 'package:freezed_annotation/freezed_annotation.dart';

part 'web_view_state.freezed.dart';

@freezed
class WebViewState with _$WebViewState {
  const factory WebViewState({
    @Default('') String url,
    @Default('') String title,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default(0.0) double progress,
  }) = _WebViewState;
}
