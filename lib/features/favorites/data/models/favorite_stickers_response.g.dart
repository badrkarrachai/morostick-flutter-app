// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_stickers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteStickersResponse _$FavoriteStickersResponseFromJson(
        Map<String, dynamic> json) =>
    FavoriteStickersResponse(
      status: (json['status'] as num).toInt(),
      success: json['success'] as bool,
      message: json['message'] as String,
      error: json['error'] == null
          ? null
          : ErrorDetails.fromJson(json['error'] as Map<String, dynamic>),
      favoriteStickersData: (json['data'] as List<dynamic>?)
          ?.map((e) => Sticker.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      pagination: json['pagination'] == null
          ? null
          : PaginationData.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoriteStickersResponseToJson(
        FavoriteStickersResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'error': instance.error,
      'metadata': instance.metadata,
      'data': instance.favoriteStickersData,
      'pagination': instance.pagination,
    };
