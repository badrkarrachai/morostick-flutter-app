part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    required String name,
    required String email,
    String? avatarUrl,
    String? coverImageUrl,
    @Default(false) bool isUpdatingProfile,
    @Default(false) bool isUpdatingAvatar,
    @Default(false) bool isUploadingCoverImage,
    @Default(false) bool didUpdateSuccessfully,
    GeneralResponse? error,
  }) = _ProfileState;
}
