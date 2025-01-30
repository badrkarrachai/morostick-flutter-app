// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_searches_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingSearchesResponse _$TrendingSearchesResponseFromJson(
        Map<String, dynamic> json) =>
    TrendingSearchesResponse(
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

Map<String, dynamic> _$TrendingSearchesResponseToJson(
        TrendingSearchesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
      'metadata': instance.metadata,
    };

TrendingSearchData _$TrendingSearchDataFromJson(Map<String, dynamic> json) =>
    TrendingSearchData(
      trending: (json['trending'] as List<dynamic>)
          .map((e) => TrendingSearchItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdated: json['lastUpdated'] as String,
      fromCache: json['fromCache'] as bool,
    );

Map<String, dynamic> _$TrendingSearchDataToJson(TrendingSearchData instance) =>
    <String, dynamic>{
      'trending': instance.trending,
      'lastUpdated': instance.lastUpdated,
      'fromCache': instance.fromCache,
    };

TrendingSearchItem _$TrendingSearchItemFromJson(Map<String, dynamic> json) =>
    TrendingSearchItem(
      name: json['name'] as String,
      isHot: json['isHot'] as bool,
      searchCount: (json['searchCount'] as num).toInt(),
      previewSticker: PreviewSticker.fromJson(
          json['previewSticker'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrendingSearchItemToJson(TrendingSearchItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isHot': instance.isHot,
      'searchCount': instance.searchCount,
      'previewSticker': instance.previewSticker,
    };

PreviewSticker _$PreviewStickerFromJson(Map<String, dynamic> json) =>
    PreviewSticker(
      id: json['id'] as String,
      webpUrl: json['webpUrl'] as String,
      name: json['name'] as String,
      packId: json['packId'] as String,
    );

Map<String, dynamic> _$PreviewStickerToJson(PreviewSticker instance) =>
    <String, dynamic>{
      'id': instance.id,
      'webpUrl': instance.webpUrl,
      'name': instance.name,
      'packId': instance.packId,
    };
