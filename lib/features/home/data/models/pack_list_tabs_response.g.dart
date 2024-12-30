// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pack_list_tabs_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PacksListResponse _$PacksListResponseFromJson(Map<String, dynamic> json) =>
    PacksListResponse(
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
      pagination: json['pagination'] == null
          ? null
          : PaginationData.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PacksListResponseToJson(PacksListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
      'metadata': instance.metadata,
      'pagination': instance.pagination,
    };
