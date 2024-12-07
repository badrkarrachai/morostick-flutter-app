import 'package:morostick/core/data/models/general_response_model.dart';

class VerifyCodeResponse extends GeneralResponse {
  final Metadata metadata;

  const VerifyCodeResponse({
    required super.status,
    required super.success,
    required super.message,
    required this.metadata,
  });

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) {
    return VerifyCodeResponse(
      status: json['status'] as int,
      success: json['success'] as bool,
      message: json['message'] as String,
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );
  }
}
