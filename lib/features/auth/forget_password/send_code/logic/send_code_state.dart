import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';

part 'send_code_state.freezed.dart';

@freezed
class SendCodeState<T> with _$SendCodeState<T> {
  const factory SendCodeState.initial() = _Initial;

  const factory SendCodeState.loading() = Loading;
  const factory SendCodeState.success(T data) = Success<T>;
  const factory SendCodeState.error({required GeneralResponse error}) = Error;
}
