import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_navigation_state.freezed.dart';

@freezed
class MainNavigationState with _$MainNavigationState {
  const factory MainNavigationState({
    @Default(0) int selectedIndex,
  }) = _MainNavigationState;
}
