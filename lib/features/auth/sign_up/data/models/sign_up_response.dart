import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/user_model.dart';
import 'package:morostick/core/data/models/general_response_model.dart';

part 'sign_up_response.g.dart';

@JsonSerializable()
class SignUpData {
  final String accessToken;
  final String refreshToken;
  final User user;

  SignUpData({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) =>
      _$SignUpDataFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpDataToJson(this);
}

class SignUpResponse extends GeneralResponse {
  SignUpData? get signUpData =>
      data != null ? SignUpData.fromJson(data as Map<String, dynamic>) : null;
  final Metadata metadata;

  const SignUpResponse({
    required super.status,
    required super.success,
    required super.message,
    super.data,
    required this.metadata,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      status: json['status'] as int,
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] as Map<String, dynamic>?,
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );
  }
}
