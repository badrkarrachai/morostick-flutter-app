import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/features/auth/forget_password/new_password/data/models/new_password_request_body.dart';
import 'package:morostick/features/auth/forget_password/new_password/data/repos/new_password_repo.dart';
import 'package:morostick/features/auth/forget_password/new_password/logic/new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  final NewPasswordRepo _newPasswordRepo;
  final AuthNavigationService _authService;

  NewPasswordCubit(this._newPasswordRepo, this._authService)
      : super(const NewPasswordState.initial());

  late String email;
  late String code;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void resetError() {
    emit(const NewPasswordState.initial());
  }

  void emitNewPasswordStates() async {
    try {
      emit(const NewPasswordState.newPasswordLoading());
      final response = await _newPasswordRepo.resetPassword(
        NewPasswordRequestBody(
          newPassword: newPasswordController.text,
          confirmNewPassword: confirmPasswordController.text,
          otp: code,
          email: email,
        ),
      );

      response.when(
        success: (newPasswordResponse) async {
          // Using AuthNavigationService to handle token and auth state
          if (newPasswordResponse.newPasswordData?.accessToken != null) {
            await _authService.login(
                newPasswordResponse.newPasswordData?.accessToken ?? '',
                refreshToken:
                    newPasswordResponse.newPasswordData?.refreshToken);
          }
          emit(NewPasswordState.newPasswordSuccess(newPasswordResponse));
        },
        failure: (error) {
          emit(NewPasswordState.newPasswordError(error: error.apiErrorModel));
        },
      );
    } catch (e) {
      emit(NewPasswordState.newPasswordError(
        error: GeneralResponse(
          success: false,
          status: 500,
          message: e.toString(),
        ),
      ));
    }
  }
}
