import 'package:json_annotation/json_annotation.dart';
import 'general_response_model.dart';

part 'refresh_token_response_model.g.dart';

@JsonSerializable()
class RefreshTokenData {
  final String accessToken;

  const RefreshTokenData({
    required this.accessToken,
  });

  factory RefreshTokenData.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenDataFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenDataToJson(this);
}

class RefreshTokenResponse extends GeneralResponse {
  RefreshTokenData? get tokenData => data != null
      ? RefreshTokenData.fromJson(data as Map<String, dynamic>)
      : null;

  const RefreshTokenResponse({
    required super.status,
    required super.success,
    required super.message,
    super.data,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      status: json['status'] as int,
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] as Map<String, dynamic>?,
    );
  }
}
