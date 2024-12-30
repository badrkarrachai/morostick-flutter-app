import 'package:json_annotation/json_annotation.dart';

part 'general_response_model.g.dart';

@JsonSerializable()
class GeneralResponse {
  final int status;
  final bool success;
  final String message;
  final ErrorDetails? error;
  final dynamic data; // Changed from dynamic to Map<String, dynamic>?
  final Metadata? metadata;

  const GeneralResponse({
    required this.status,
    required this.success,
    required this.message,
    this.error,
    this.data,
    this.metadata,
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

@JsonSerializable()
class PaginationData {
  final int? currentPage;
  final int? pageSize;
  final int? totalPages;
  final int? totalItems;
  final bool? hasNextPage;
  final bool? hasPrevPage;

  PaginationData({
    this.currentPage,
    this.pageSize,
    this.totalPages,
    this.totalItems,
    this.hasNextPage,
    this.hasPrevPage,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) =>
      _$PaginationDataFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationDataToJson(this);
}
