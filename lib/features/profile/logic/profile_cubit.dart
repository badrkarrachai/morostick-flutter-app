import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/services/user_service.dart';
import 'package:morostick/features/profile/data/repos/profile_repo.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;
  final UserService _userService;

  ProfileCubit(
    this._profileRepo,
    this._userService,
  ) : super(_initialState());

  static ProfileState _initialState() {
    final userData = getIt<UserService>().currentUser;
    return ProfileState(
      name: userData?.name ?? '',
      email: userData?.email ?? '',
      avatarUrl: userData?.avatar?.url,
      coverImageUrl: userData?.coverImage?.url,
    );
  }

  // Update name locally (without API call)
  void updateNameLocally(String name) {
    emit(state.copyWith(name: name));
  }

  // Update email locally (without API call)
  void updateEmailLocally(String email) {
    emit(state.copyWith(email: email));
  }

  // Submit name update to backend
  Future<void> updateUserProfile() async {
    // Set loading state
    emit(state.copyWith(isUpdatingProfile: true, error: null));

    // Call the repository to update the name
    final result = await _profileRepo.updateUserName(state.name, state.email);

    // Handle the result
    result.when(
      success: (response) {
        // Update the UserService with the new data
        _userService.updateUser({
          'name': state.name,
          'email': state.email,
        });

        // Emit success state
        emit(state.copyWith(
          isUpdatingProfile: false,
          didUpdateSuccessfully: true,
        ));
      },
      failure: (error) {
        // Emit error state
        emit(state.copyWith(
          isUpdatingProfile: false,
          error: error.apiErrorModel,
        ));
      },
    );
  }

  void resetUpdateFlag() {
    emit(state.copyWith(didUpdateSuccessfully: false));
  }

  // Upload avatar image
  Future<void> updateUserAvatar(File avatarImage) async {
    // Set loading state
    emit(state.copyWith(isUpdatingAvatar: true, error: null));

    // Call the repository to update the avatar
    final result = await _profileRepo.updateUserAvatar(avatarImage);

    // Handle the result
    result.when(
      success: (response) {
        final newAvatarUrl = response.updatedAvatarData?.avatarUrl;

        // Update the UserService with the new avatar URL
        _userService.updateUser({
          'avatar': newAvatarUrl,
        });

        // Emit success state
        emit(state.copyWith(
          isUpdatingAvatar: false,
          avatarUrl: newAvatarUrl,
        ));
      },
      failure: (error) {
        // Emit error state
        emit(state.copyWith(
          isUpdatingAvatar: false,
          error: error.apiErrorModel,
        ));
      },
    );
  }

  Future<void> updateUserCoverImage(File coverImage) async {
    // Set loading state
    emit(state.copyWith(isUploadingCoverImage: true, error: null));

    // Call the repository to update the cover image
    final result = await _profileRepo.updateUserCoverImage(coverImage);

    // Handle the result
    result.when(
      success: (response) {
        final newCoverImageUrl = response.updatedCoverData?.coverImageUrl;

        // Update the UserService with the new cover image URL
        _userService.updateUser({
          'coverImage': newCoverImageUrl,
        });

        // Emit success state
        emit(state.copyWith(
          isUploadingCoverImage: false,
          coverImageUrl: newCoverImageUrl,
        ));
      },
      failure: (error) {
        // Emit error state
        emit(state.copyWith(
          isUploadingCoverImage: false,
          error: error.apiErrorModel,
        ));
      },
    );
  }

  // Delete user avatar
  Future<void> deleteUserAvatar() async {
    // Set loading state
    emit(state.copyWith(isUpdatingAvatar: true, error: null));

    // Call the repository to delete the avatar
    final result = await _profileRepo.deleteUserAvatar();

    // Handle the result
    result.when(
      success: (response) {
        // Update the UserService with the new avatar URL
        _userService.updateUser({
          'avatar': null,
        });

        // Emit success state
        emit(state.copyWith(
          isUpdatingAvatar: false,
          avatarUrl: null,
        ));
      },
      failure: (error) {
        // Emit error state
        emit(state.copyWith(
          isUpdatingAvatar: false,
          error: error.apiErrorModel,
        ));
      },
    );
  }

  Future<void> deleteUserCoverImage() async {
    emit(state.copyWith(isUploadingCoverImage: true, error: null));

    final result = await _profileRepo.deleteUserCoverImage();

    result.when(
      success: (response) {
        // Update the UserService with the new avatar URL
        _userService.updateUser({
          'cover': null,
        });

        // Emit success state
        emit(state.copyWith(
          isUploadingCoverImage: false,
          coverImageUrl: null,
        ));
      },
      failure: (error) {
        // Emit error state
        emit(state.copyWith(
          isUploadingCoverImage: false,
          error: error.apiErrorModel,
        ));
      },
    );
  }
}
