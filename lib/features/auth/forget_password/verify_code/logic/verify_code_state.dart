import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';

part 'verify_code_state.freezed.dart';

@freezed
class VerifyCodeData with _$VerifyCodeData {
  const factory VerifyCodeData({
    @Default(30) int timerCount,
    @Default(false) bool hasCodeInputError,
    @Default('Please enter a valid 5 digit code') String errorText,
  }) = _VerifyCodeData;
}

@freezed
class VerifyCodeState<T> with _$VerifyCodeState<T> {
  const factory VerifyCodeState.initial({
    @Default(VerifyCodeData()) VerifyCodeData statesData,
  }) = Initial;

  const factory VerifyCodeState.loading({
    required VerifyCodeData datstatesDataa,
  }) = Loading;

  const factory VerifyCodeState.success(T data,
      {required VerifyCodeData statesData}) = Success<T>;

  const factory VerifyCodeState.error({
    required GeneralResponse error,
    required VerifyCodeData statesData,
  }) = Error;
}
