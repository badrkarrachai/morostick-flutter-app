import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/features/auth/forget_password/send_code/data/models/send_code_request_body.dart';
import 'package:morostick/features/auth/forget_password/send_code/logic/send_code_state.dart';
import 'package:morostick/features/auth/forget_password/send_code/data/repos/forget_password_repo.dart';

class SendCodeCubit extends Cubit<SendCodeState> {
  final SendCodeRepo _forgetPasswordRepo;
  SendCodeCubit(this._forgetPasswordRepo)
      : super(const SendCodeState.initial());

  // Text Controllers
  TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void emitSendCodeStates({String? email}) async {
    try {
      emit(const SendCodeState.loading());
      final response = await _forgetPasswordRepo.sendCode(
        SendCodeRequestBody(
          email: email ?? emailController.text,
        ),
      );
      response.when(success: (forgetPasswordResponse) {
        emit(SendCodeState.success(forgetPasswordResponse));
      }, failure: (error) {
        emit(SendCodeState.error(error: error.apiErrorModel));
      });
    } catch (e) {
      emit(SendCodeState.error(
          error: GeneralResponse(
        success: false,
        status: 500,
        message: e.toString(),
      )));
    }
  }
}
