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
    return ProfileState.initial(
      name: userData?.name ?? '',
      email: userData?.email ?? '',
      avatarUrl: userData?.avatar?.url ?? '',
      coverImageUrl: userData?.coverImage?.url ?? '',
    );
  }

  // Update name locally (without API call)
  void updateNameLocally(String name) {
    final currentState = state;
    emit(ProfileState.initial(
      name: name,
      email: currentState.email,
      avatarUrl: currentState.avatarUrl,
      coverImageUrl: currentState.coverImageUrl,
    ));
  }

  // Update email locally (without API call)
  void updateEmailLocally(String email) {
    final currentState = state;
    emit(ProfileState.initial(
      name: currentState.name,
      email: email,
      avatarUrl: currentState.avatarUrl,
      coverImageUrl: currentState.coverImageUrl,
    ));
  }

  // Submit name update to backend
  Future<void> updateUserProfile() async {
    // Get current values from state
    final currentState = state;
    final name = currentState.name;
    final email = currentState.email;
    final avatarUrl = currentState.avatarUrl;
    final coverUrl = currentState.coverImageUrl;

    // Emit loading state
    emit(ProfileState.loading(
      name: name,
      email: email,
      avatarUrl: avatarUrl,
      coverImageUrl: coverUrl,
    ));

    // Call the repository to update the name
    final result = await _profileRepo.updateUserName(name, email);

    // Handle the result
    result.when(
      success: (response) {
        // Update the UserService with the new data
        _userService.updateUser({
          'name': name,
          'email': email,
        });

        // Emit success state
        emit(ProfileState.success(
          name: name,
          email: email,
          avatarUrl: avatarUrl,
          coverImageUrl: coverUrl,
        ));
      },
      failure: (error) {
        print(error);
        // Emit error state
        emit(ProfileState.error(
          error: error.apiErrorModel,
          name: name,
          email: email,
          avatarUrl: avatarUrl,
          coverImageUrl: coverUrl,
        ));
      },
    );
  }

  // Upload avatar image
  Future<void> updateUserAvatar(File avatarImage) async {
    // Get current values from state
    final currentState = state;
    final name = currentState.name;
    final email = currentState.email;
    final avatarUrl = currentState.avatarUrl;
    final coverUrl = currentState.coverImageUrl;

    // Emit loading state
    emit(ProfileState.loading(
      name: name,
      email: email,
      avatarUrl: avatarUrl,
      coverImageUrl: coverUrl,
    ));

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
        emit(ProfileState.success(
          name: name,
          email: email,
          avatarUrl: newAvatarUrl,
          coverImageUrl: coverUrl,
        ));
      },
      failure: (error) {
        // Emit error state
        emit(ProfileState.error(
          error: error.apiErrorModel,
          name: name,
          email: email,
          avatarUrl: avatarUrl,
          coverImageUrl: coverUrl,
        ));
      },
    );
  }
}
