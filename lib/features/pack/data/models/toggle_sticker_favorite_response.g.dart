// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_sticker_favorite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToggleStickerFavoriteResponse _$ToggleStickerFavoriteResponseFromJson(
        Map<String, dynamic> json) =>
    ToggleStickerFavoriteResponse(
      status: (json['status'] as num).toInt(),
      success: json['success'] as bool,
      message: json['message'] as String,
      error: json['error'] == null
          ? null
          : ErrorDetails.fromJson(json['error'] as Map<String, dynamic>),
      favoriteData: json['data'] == null
          ? null
          : ToggleStickerFavoriteData.fromJson(
              json['data'] as Map<String, dynamic>),
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ToggleStickerFavoriteResponseToJson(
        ToggleStickerFavoriteResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'error': instance.error,
      'metadata': instance.metadata,
      'data': instance.favoriteData,
    };

ToggleStickerFavoriteData _$ToggleStickerFavoriteDataFromJson(
        Map<String, dynamic> json) =>
    ToggleStickerFavoriteData(
      isFavorite: json['isFavorite'] as bool,
      favoritesCount: (json['favoritesCount'] as num).toInt(),
      pack: json['pack'] == null
          ? null
          : Pack.fromJson(json['pack'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ToggleStickerFavoriteDataToJson(
        ToggleStickerFavoriteData instance) =>
    <String, dynamic>{
      'isFavorite': instance.isFavorite,
      'favoritesCount': instance.favoritesCount,
      'pack': instance.pack,
    };
