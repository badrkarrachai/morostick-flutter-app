import 'package:json_annotation/json_annotation.dart';

part 'new_password_request_body.g.dart';

@JsonSerializable()
class NewPasswordRequestBody {
  final String newPassword;
  final String confirmNewPassword;
  final String otp;
  final String email;

  NewPasswordRequestBody({
    required this.newPassword,
    required this.confirmNewPassword,
    required this.otp,
    required this.email,
  });

  Map<String, dynamic> toJson() => _$NewPasswordRequestBodyToJson(this);
}
