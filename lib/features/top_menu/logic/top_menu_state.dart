part of 'top_menu_cubit.dart';

@freezed
class TopMenuState with _$TopMenuState {
  const factory TopMenuState.initial({
    required bool isGoogleAuthEnabled,
    required bool isFacebookAuthEnabled,
  }) = _Initial;

  const factory TopMenuState.loading({
    required bool isGoogleAuthEnabled,
    required bool isFacebookAuthEnabled,
  }) = _Loading;

  const factory TopMenuState.success({
    required bool isGoogleAuthEnabled,
    required bool isFacebookAuthEnabled,
  }) = _Success;

  const factory TopMenuState.error({
    required GeneralResponse error,
    required bool isGoogleAuthEnabled,
    required bool isFacebookAuthEnabled,
  }) = _Error;
}
