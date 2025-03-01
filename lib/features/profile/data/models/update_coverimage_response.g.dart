// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_coverimage_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCoverimageResponse _$UpdateCoverimageResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateCoverimageResponse(
      status: (json['status'] as num).toInt(),
      success: json['success'] as bool,
      message: json['message'] as String,
      error: json['error'] == null
          ? null
          : ErrorDetails.fromJson(json['error'] as Map<String, dynamic>),
      updatedAvatarData: json['data'] == null
          ? null
          : UpdatedCoverData.fromJson(json['data'] as Map<String, dynamic>),
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateCoverimageResponseToJson(
        UpdateCoverimageResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'error': instance.error,
      'metadata': instance.metadata,
      'data': instance.updatedAvatarData,
    };

UpdatedCoverData _$UpdatedCoverDataFromJson(Map<String, dynamic> json) =>
    UpdatedCoverData(
      coverImageId: json['coverImageId'] as String,
      coverImageUrl: json['coverImageUrl'] as String,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      format: json['format'] as String,
      fileSize: (json['fileSize'] as num).toInt(),
    );

Map<String, dynamic> _$UpdatedCoverDataToJson(UpdatedCoverData instance) =>
    <String, dynamic>{
      'coverImageId': instance.coverImageId,
      'coverImageUrl': instance.coverImageUrl,
      'width': instance.width,
      'height': instance.height,
      'format': instance.format,
      'fileSize': instance.fileSize,
    };
