import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/user_model.dart';
import 'package:morostick/core/data/models/general_response_model.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginData {
  final String accessToken;
  final String refreshToken;
  final User user;

  LoginData({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

class LoginResponse extends GeneralResponse {
  LoginData? get loginData =>
      data != null ? LoginData.fromJson(data as Map<String, dynamic>) : null;

  const LoginResponse({
    required super.status,
    required super.success,
    required super.message,
    super.data,
    super.metadata,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] as int,
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] as Map<String, dynamic>?,
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );
  }
}
