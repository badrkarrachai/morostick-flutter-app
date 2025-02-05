import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/services/user_service.dart';
import 'package:morostick/features/top_menu/data/models/update_user_pref_response.dart';
import 'package:morostick/features/top_menu/data/repos/top_menu_repo.dart';
import 'package:morostick/core/services/facebook_auth_service.dart';
import 'package:morostick/core/services/google_auth_service.dart';

part 'top_menu_state.dart';
part 'top_menu_cubit.freezed.dart';

class TopMenuCubit extends Cubit<TopMenuState> {
  final TopMenuRepo _topMenuRepo;
  final FacebookAuthService _facebookAuthService;
  final GoogleAuthService _googleAuthService;
  final UserService _userService;

  TopMenuCubit(
    this._topMenuRepo,
    this._facebookAuthService,
    this._googleAuthService,
    this._userService,
  ) : super(_initialState()) {
    _userService.addListener(_userChanged);
  }

  static TopMenuState _initialState() {
    final prefs = getIt<UserService>().userPreferences;
    return TopMenuState.initial(
      isGoogleAuthEnabled: prefs?.isGoogleAuthEnabled ?? false,
      isFacebookAuthEnabled: prefs?.isFacebookAuthEnabled ?? false,
    );
  }

  void _userChanged() {
    final prefs = _userService.userPreferences;
    final newState = TopMenuState.success(
      isGoogleAuthEnabled: prefs?.isGoogleAuthEnabled ?? false,
      isFacebookAuthEnabled: prefs?.isFacebookAuthEnabled ?? false,
    );

    if (newState != state) {
      emit(newState);
    }
  }

  Future<void> toggleFacebookAuth(bool isEnabled) async {
    try {
      emit(TopMenuState.loading(
        isGoogleAuthEnabled: state.isGoogleAuthEnabled,
        isFacebookAuthEnabled: state.isFacebookAuthEnabled,
      ));

      if (isEnabled) {
        final String? accessToken = await _facebookAuthService.getIdToken();
        if (accessToken == null) {
          emit(TopMenuState.error(
            error: GeneralResponse(
              success: false,
              message: 'Failed to get Facebook access token',
              status: 400,
            ),
            isGoogleAuthEnabled: state.isGoogleAuthEnabled,
            isFacebookAuthEnabled: state.isFacebookAuthEnabled,
          ));
          return;
        }
      }

      final result = await _topMenuRepo.updateUserPreferences(
        state.isGoogleAuthEnabled,
        isEnabled,
      );

      result.when(
        success: (response) {
          if (response.preferencesData != null) {
            _updateUserPreferences(response.preferencesData!);
          }
          emit(TopMenuState.success(
            isGoogleAuthEnabled: state.isGoogleAuthEnabled,
            isFacebookAuthEnabled: isEnabled,
          ));
        },
        failure: (error) {
          emit(TopMenuState.error(
            error: error.apiErrorModel,
            isGoogleAuthEnabled: state.isGoogleAuthEnabled,
            isFacebookAuthEnabled: state.isFacebookAuthEnabled,
          ));
        },
      );
    } catch (e) {
      emit(TopMenuState.error(
        error: GeneralResponse(
          success: false,
          message: 'Failed to toggle Facebook authentication',
          status: 500,
        ),
        isGoogleAuthEnabled: state.isGoogleAuthEnabled,
        isFacebookAuthEnabled: state.isFacebookAuthEnabled,
      ));
    }
  }

  Future<void> toggleGoogleAuth(bool isEnabled) async {
    try {
      emit(TopMenuState.loading(
        isGoogleAuthEnabled: state.isGoogleAuthEnabled,
        isFacebookAuthEnabled: state.isFacebookAuthEnabled,
      ));

      if (isEnabled) {
        final String? accessToken = await _googleAuthService.getAccessToken();
        if (accessToken == null) {
          emit(TopMenuState.error(
            error: GeneralResponse(
              success: false,
              message: 'Failed to get Google access token',
              status: 400,
            ),
            isGoogleAuthEnabled: state.isGoogleAuthEnabled,
            isFacebookAuthEnabled: state.isFacebookAuthEnabled,
          ));
          return;
        }
      }

      final result = await _topMenuRepo.updateUserPreferences(
        isEnabled,
        state.isFacebookAuthEnabled,
      );

      result.when(
        success: (response) {
          if (response.preferencesData != null) {
            _updateUserPreferences(response.preferencesData!);
          }
          emit(TopMenuState.success(
            isGoogleAuthEnabled: isEnabled,
            isFacebookAuthEnabled: state.isFacebookAuthEnabled,
          ));
        },
        failure: (error) {
          emit(TopMenuState.error(
            error: error.apiErrorModel,
            isGoogleAuthEnabled: state.isGoogleAuthEnabled,
            isFacebookAuthEnabled: state.isFacebookAuthEnabled,
          ));
        },
      );
    } catch (e) {
      emit(TopMenuState.error(
        error: GeneralResponse(
          success: false,
          message: 'Failed to toggle Google authentication',
          status: 500,
        ),
        isGoogleAuthEnabled: state.isGoogleAuthEnabled,
        isFacebookAuthEnabled: state.isFacebookAuthEnabled,
      ));
    }
  }

  void _updateUserPreferences(PreferencesData preferencesData) {
    final currentUser = _userService.currentUser;
    if (currentUser != null) {
      final currentPrefs = currentUser.preferences.toJson();
      final updatedPrefs = {
        ...currentPrefs,
        if (preferencesData.isFacebookAuthEnabled != null)
          'isFacebookAuthEnabled': preferencesData.isFacebookAuthEnabled,
        if (preferencesData.isGoogleAuthEnabled != null)
          'isGoogleAuthEnabled': preferencesData.isGoogleAuthEnabled,
      };
      _userService.updateUser({
        'preferences': updatedPrefs,
      });
    }
  }

  @override
  Future<void> close() {
    _userService.removeListener(_userChanged);
    return super.close();
  }
}
