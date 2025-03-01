// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_avatar_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAvatarResponse _$UpdateAvatarResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateAvatarResponse(
      status: (json['status'] as num).toInt(),
      success: json['success'] as bool,
      message: json['message'] as String,
      error: json['error'] == null
          ? null
          : ErrorDetails.fromJson(json['error'] as Map<String, dynamic>),
      updatedAvatarData: json['data'] == null
          ? null
          : UpdatedAvatarData.fromJson(json['data'] as Map<String, dynamic>),
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateAvatarResponseToJson(
        UpdateAvatarResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'error': instance.error,
      'metadata': instance.metadata,
      'data': instance.updatedAvatarData,
    };

UpdatedAvatarData _$UpdatedAvatarDataFromJson(Map<String, dynamic> json) =>
    UpdatedAvatarData(
      avatarId: json['avatarId'] as String,
      avatarUrl: json['avatarUrl'] as String,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      format: json['format'] as String,
      fileSize: (json['fileSize'] as num).toInt(),
    );

Map<String, dynamic> _$UpdatedAvatarDataToJson(UpdatedAvatarData instance) =>
    <String, dynamic>{
      'avatarId': instance.avatarId,
      'avatarUrl': instance.avatarUrl,
      'width': instance.width,
      'height': instance.height,
      'format': instance.format,
      'fileSize': instance.fileSize,
    };
