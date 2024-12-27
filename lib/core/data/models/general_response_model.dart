import 'package:json_annotation/json_annotation.dart';

part 'general_response_model.g.dart';

@JsonSerializable()
class GeneralResponse {
  final int status;
  final bool success;
  final String message;
  final ErrorDetails? error;
  final Map<String, dynamic>?
      data; // Changed from dynamic to Map<String, dynamic>?

  const GeneralResponse({
    required this.status,
    required this.success,
    required this.message,
    this.error,
    this.data,
  });

  factory GeneralResponse.fromJson(Map<String, dynamic> json) =>
      _$GeneralResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralResponseToJson(this);
}

@JsonSerializable()
class ErrorDetails {
  final String code;
  final String details;
  final List<String>? errorFields;

  const ErrorDetails({
    required this.code,
    required this.details,
    this.errorFields,
  });

  factory ErrorDetails.fromJson(Map<String, dynamic> json) =>
      _$ErrorDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDetailsToJson(this);
}

@JsonSerializable()
class Metadata {
  final String? timestamp;
  final String? version;

  const Metadata({
    // Added const
    this.timestamp, // Removed required since they're nullable
    this.version,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);
  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
