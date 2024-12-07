import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/features/auth/forget_password/verify_code/data/models/verify_code_request_body.dart';
import 'package:morostick/features/auth/forget_password/verify_code/data/repos/verify_code_repo.dart';
import 'package:morostick/features/auth/forget_password/verify_code/logic/verify_code_state.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  final VerifyCodeRepo _verifyCodeRepo;
  VerifyCodeCubit(this._verifyCodeRepo)
      : super(const VerifyCodeState.initial());

  final TextEditingController codeController = TextEditingController();
  final FocusNode pinPutFocusNode = FocusNode();
  Timer? countdownTimer;
  String? errorText;
  late String email;

  void startTimer() {
    stopTimer();
    emit(const VerifyCodeState.initial());

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentData = state.statesData;
      if (currentData.timerCount > 0) {
        emit(VerifyCodeState.initial(
          statesData: VerifyCodeData(
            timerCount: currentData.timerCount - 1,
            hasCodeInputError: currentData.hasCodeInputError,
            errorText: currentData.errorText,
          ),
        ));
      } else {
        timer.cancel();
        emit(VerifyCodeState.initial(
          statesData: VerifyCodeData(
            timerCount: 0,
            hasCodeInputError: currentData.hasCodeInputError,
            errorText: currentData.errorText,
          ),
        ));
      }
    });
  }

  bool validateCode() {
    final isValid = codeController.text.length == 5;
    if (!isValid) {
      updateCodeInputError(true, null);
    }
    return isValid;
  }

  void updateCodeInputError(bool hasError, String? errorText) {
    final currentData = state.statesData;
    final newData = VerifyCodeData(
      timerCount: currentData.timerCount,
      hasCodeInputError: hasError,
      errorText: errorText ?? 'Please enter a valid 5 digit code',
    );

    // Only emit initial state when updating error
    emit(VerifyCodeState.initial(statesData: newData));
  }

  void stopTimer() {
    countdownTimer?.cancel();
  }

  void emitVerifyCodeStates() async {
    if (!validateCode()) return;

    try {
      // Reset error state before loading
      final currentData = state.statesData;
      emit(VerifyCodeState.loading(
        datstatesDataa: VerifyCodeData(
          timerCount: currentData.timerCount,
          hasCodeInputError: false,
        ),
      ));

      final response = await _verifyCodeRepo.verifyCode(
        VerifyCodeRequestBody(
          email: email,
          otp: codeController.text,
        ),
      );

      response.when(
        success: (verifyCodeResponse) {
          emit(VerifyCodeState.success(
            verifyCodeResponse,
            statesData: VerifyCodeData(
              timerCount: state.statesData.timerCount,
              hasCodeInputError: false,
            ),
          ));
        },
        failure: (error) {
          emit(VerifyCodeState.error(
            error: error.apiErrorModel,
            statesData: VerifyCodeData(
              timerCount: state.statesData.timerCount,
              hasCodeInputError: true, // Set error state directly here
            ),
          ));
        },
      );
    } catch (e) {
      emit(VerifyCodeState.error(
        error: GeneralResponse(
          success: false,
          status: 500,
          message: e.toString(),
        ),
        statesData: VerifyCodeData(
          timerCount: state.statesData.timerCount,
          hasCodeInputError: true, // Set error state directly here
        ),
      ));
    }
  }

  @override
  Future<void> close() {
    stopTimer();
    codeController.dispose();
    pinPutFocusNode.dispose();
    return super.close();
  }
}

// Extension to easily access statesData regardless of state
extension VerifyCodeStateX on VerifyCodeState {
  VerifyCodeData get statesData => when(
        initial: (data) => data,
        loading: (data) => data,
        success: (_, data) => data,
        error: (_, data) => data,
      );
}
