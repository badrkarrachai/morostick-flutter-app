import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/data/models/user_model.dart';

part 'new_password_response.g.dart';

@JsonSerializable()
class NewPasswordData {
  final String accessToken;
  final String refreshToken;
  final User user;

  NewPasswordData({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory NewPasswordData.fromJson(Map<String, dynamic> json) =>
      _$NewPasswordDataFromJson(json);
  Map<String, dynamic> toJson() => _$NewPasswordDataToJson(this);
}

class NewPasswordResponse extends GeneralResponse {
  NewPasswordData? get newPasswordData => data != null
      ? NewPasswordData.fromJson(data as Map<String, dynamic>)
      : null;

  const NewPasswordResponse({
    required super.status,
    required super.success,
    required super.message,
    super.data,
    super.metadata,
  });

  factory NewPasswordResponse.fromJson(Map<String, dynamic> json) {
    return NewPasswordResponse(
      status: json['status'] as int,
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] as Map<String, dynamic>?,
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );
  }
}
