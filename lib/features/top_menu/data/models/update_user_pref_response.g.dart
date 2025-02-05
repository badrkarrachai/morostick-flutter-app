// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_pref_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserPrefResponse _$UpdateUserPrefResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateUserPrefResponse(
      status: (json['status'] as num).toInt(),
      success: json['success'] as bool,
      message: json['message'] as String,
      error: json['error'] == null
          ? null
          : ErrorDetails.fromJson(json['error'] as Map<String, dynamic>),
      data: json['data'],
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateUserPrefResponseToJson(
        UpdateUserPrefResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
      'metadata': instance.metadata,
    };

PreferencesData _$PreferencesDataFromJson(Map<String, dynamic> json) =>
    PreferencesData(
      currency: json['currency'] as String?,
      language: json['language'] as String?,
      theme: json['theme'] as String?,
      isFacebookAuthEnabled: json['isFacebookAuthEnabled'] as bool?,
      isGoogleAuthEnabled: json['isGoogleAuthEnabled'] as bool?,
    );

Map<String, dynamic> _$PreferencesDataToJson(PreferencesData instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'language': instance.language,
      'theme': instance.theme,
      'isFacebookAuthEnabled': instance.isFacebookAuthEnabled,
      'isGoogleAuthEnabled': instance.isGoogleAuthEnabled,
    };
