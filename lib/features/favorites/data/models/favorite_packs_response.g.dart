// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_packs_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritePacksResponse _$FavoritePacksResponseFromJson(
        Map<String, dynamic> json) =>
    FavoritePacksResponse(
      status: (json['status'] as num).toInt(),
      success: json['success'] as bool,
      message: json['message'] as String,
      error: json['error'] == null
          ? null
          : ErrorDetails.fromJson(json['error'] as Map<String, dynamic>),
      favoritePacksData: (json['data'] as List<dynamic>?)
          ?.map((e) => Pack.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      pagination: json['pagination'] == null
          ? null
          : PaginationData.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoritePacksResponseToJson(
        FavoritePacksResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'error': instance.error,
      'metadata': instance.metadata,
      'data': instance.favoritePacksData,
      'pagination': instance.pagination,
    };
