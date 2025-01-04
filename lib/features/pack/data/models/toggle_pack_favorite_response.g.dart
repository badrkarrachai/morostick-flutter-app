// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_pack_favorite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TogglePackFavoriteResponse _$TogglePackFavoriteResponseFromJson(
        Map<String, dynamic> json) =>
    TogglePackFavoriteResponse(
      status: (json['status'] as num).toInt(),
      success: json['success'] as bool,
      message: json['message'] as String,
      error: json['error'] == null
          ? null
          : ErrorDetails.fromJson(json['error'] as Map<String, dynamic>),
      favoriteData: json['data'] == null
          ? null
          : TogglePackFavoriteData.fromJson(
              json['data'] as Map<String, dynamic>),
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TogglePackFavoriteResponseToJson(
        TogglePackFavoriteResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'error': instance.error,
      'metadata': instance.metadata,
      'data': instance.favoriteData,
    };

TogglePackFavoriteData _$TogglePackFavoriteDataFromJson(
        Map<String, dynamic> json) =>
    TogglePackFavoriteData(
      isFavorite: json['isFavorite'] as bool,
      favoritesCount: (json['favoritesCount'] as num).toInt(),
      pack: json['pack'] == null
          ? null
          : Pack.fromJson(json['pack'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TogglePackFavoriteDataToJson(
        TogglePackFavoriteData instance) =>
    <String, dynamic>{
      'isFavorite': instance.isFavorite,
      'favoritesCount': instance.favoritesCount,
      'pack': instance.pack,
    };
