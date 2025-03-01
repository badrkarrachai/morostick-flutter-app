part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial({
    required String name,
    required String email,
    required String? avatarUrl,
    required String? coverImageUrl,
  }) = _Initial;

  const factory ProfileState.loading({
    required String name,
    required String email,
    required String? avatarUrl,
    required String? coverImageUrl,
  }) = _Loading;

  const factory ProfileState.success({
    required String name,
    required String email,
    required String? avatarUrl,
    required String? coverImageUrl,
  }) = _Success;

  const factory ProfileState.error({
    required GeneralResponse error,
    required String name,
    required String email,
    required String? avatarUrl,
    required String? coverImageUrl,
  }) = _Error;
}
