import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';

part 'new_password_state.freezed.dart';

@freezed
class NewPasswordState<T> with _$NewPasswordState<T> {
  const factory NewPasswordState.initial() = _Initial;
  const factory NewPasswordState.newPasswordLoading() = NewPasswordLoading;
  const factory NewPasswordState.newPasswordSuccess(T data) =
      NewPasswordSuccess<T>;
  const factory NewPasswordState.newPasswordError(
      {required GeneralResponse error}) = NewPasswordError;
}
