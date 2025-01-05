import 'package:morostick/core/data/models/general_response_model.dart';

class SendCodeResponse extends GeneralResponse {
  const SendCodeResponse({
    required super.status,
    required super.success,
    required super.message,
    super.metadata,
  });

  factory SendCodeResponse.fromJson(Map<String, dynamic> json) {
    return SendCodeResponse(
      status: json['status'] as int,
      success: json['success'] as bool,
      message: json['message'] as String,
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );
  }
}
