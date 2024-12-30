// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_tab_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingResponse _$TrendingResponseFromJson(Map<String, dynamic> json) =>
    TrendingResponse(
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

Map<String, dynamic> _$TrendingResponseToJson(TrendingResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
      'metadata': instance.metadata,
    };

TrendingData _$TrendingDataFromJson(Map<String, dynamic> json) => TrendingData(
      topCategories: (json['topCategories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      trending: json['trending'] == null
          ? null
          : TrendingContent.fromJson(json['trending'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrendingDataToJson(TrendingData instance) =>
    <String, dynamic>{
      'topCategories': instance.topCategories,
      'trending': instance.trending,
    };

TrendingContent _$TrendingContentFromJson(Map<String, dynamic> json) =>
    TrendingContent(
      packs: (json['packs'] as List<dynamic>?)
          ?.map((e) => StickerPack.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : PaginationData.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrendingContentToJson(TrendingContent instance) =>
    <String, dynamic>{
      'packs': instance.packs,
      'pagination': instance.pagination,
    };
