// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foryou_tab_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForYouResponse _$ForYouResponseFromJson(Map<String, dynamic> json) =>
    ForYouResponse(
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

Map<String, dynamic> _$ForYouResponseToJson(ForYouResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
      'metadata': instance.metadata,
    };

ForYouData _$ForYouDataFromJson(Map<String, dynamic> json) => ForYouData(
      recommended: (json['recommended'] as List<dynamic>?)
          ?.map((e) => Pack.fromJson(e as Map<String, dynamic>))
          .toList(),
      trending: (json['trending'] as List<dynamic>?)
          ?.map((e) => Pack.fromJson(e as Map<String, dynamic>))
          .toList(),
      suggested: json['suggested'] == null
          ? null
          : SuggestedData.fromJson(json['suggested'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ForYouDataToJson(ForYouData instance) =>
    <String, dynamic>{
      'recommended': instance.recommended,
      'trending': instance.trending,
      'suggested': instance.suggested,
    };

SuggestedData _$SuggestedDataFromJson(Map<String, dynamic> json) =>
    SuggestedData(
      packs: (json['packs'] as List<dynamic>?)
          ?.map((e) => Pack.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : PaginationData.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SuggestedDataToJson(SuggestedData instance) =>
    <String, dynamic>{
      'packs': instance.packs,
      'pagination': instance.pagination,
    };
