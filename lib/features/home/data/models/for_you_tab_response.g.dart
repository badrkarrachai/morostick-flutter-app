// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'for_you_tab_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForYouResponse _$ForYouResponseFromJson(Map<String, dynamic> json) =>
    ForYouResponse(
      status: (json['status'] as num).toInt(),
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'],
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ForYouResponseToJson(ForYouResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'metadata': instance.metadata,
    };

ForYouData _$ForYouDataFromJson(Map<String, dynamic> json) => ForYouData(
      recommended: (json['recommended'] as List<dynamic>)
          .map((e) => StickerPack.fromJson(e as Map<String, dynamic>))
          .toList(),
      trending: (json['trending'] as List<dynamic>)
          .map((e) => StickerPack.fromJson(e as Map<String, dynamic>))
          .toList(),
      suggested:
          SuggestedData.fromJson(json['suggested'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ForYouDataToJson(ForYouData instance) =>
    <String, dynamic>{
      'recommended': instance.recommended,
      'trending': instance.trending,
      'suggested': instance.suggested,
    };

SuggestedData _$SuggestedDataFromJson(Map<String, dynamic> json) =>
    SuggestedData(
      packs: (json['packs'] as List<dynamic>)
          .map((e) => StickerPack.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
          PaginationData.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SuggestedDataToJson(SuggestedData instance) =>
    <String, dynamic>{
      'packs': instance.packs,
      'pagination': instance.pagination,
    };

StickerPack _$StickerPackFromJson(Map<String, dynamic> json) => StickerPack(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      creator: Creator.fromJson(json['creator'] as Map<String, dynamic>),
      previewStickers: (json['previewStickers'] as List<dynamic>)
          .map((e) => Sticker.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalStickers: (json['totalStickers'] as num).toInt(),
      isAnimatedPack: json['isAnimatedPack'] as bool,
      stats: PackStats.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StickerPackToJson(StickerPack instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'creator': instance.creator,
      'previewStickers': instance.previewStickers,
      'totalStickers': instance.totalStickers,
      'isAnimatedPack': instance.isAnimatedPack,
      'stats': instance.stats,
    };

Creator _$CreatorFromJson(Map<String, dynamic> json) => Creator(
      id: json['_id'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$CreatorToJson(Creator instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
    };

Sticker _$StickerFromJson(Map<String, dynamic> json) => Sticker(
      id: json['_id'] as String,
      name: json['name'] as String,
      webpUrl: json['webpUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      fileSize: (json['fileSize'] as num).toInt(),
      dimensions:
          Dimensions.fromJson(json['dimensions'] as Map<String, dynamic>),
      position: (json['position'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$StickerToJson(Sticker instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'webpUrl': instance.webpUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'fileSize': instance.fileSize,
      'dimensions': instance.dimensions,
      'position': instance.position,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

Dimensions _$DimensionsFromJson(Map<String, dynamic> json) => Dimensions(
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
    );

Map<String, dynamic> _$DimensionsToJson(Dimensions instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };

PackStats _$PackStatsFromJson(Map<String, dynamic> json) => PackStats(
      downloads: (json['downloads'] as num).toInt(),
      views: (json['views'] as num).toInt(),
      favorites: (json['favorites'] as num).toInt(),
    );

Map<String, dynamic> _$PackStatsToJson(PackStats instance) => <String, dynamic>{
      'downloads': instance.downloads,
      'views': instance.views,
      'favorites': instance.favorites,
    };

PaginationData _$PaginationDataFromJson(Map<String, dynamic> json) =>
    PaginationData(
      currentPage: (json['currentPage'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      totalItems: (json['totalItems'] as num).toInt(),
      hasNextPage: json['hasNextPage'] as bool,
      hasPrevPage: json['hasPrevPage'] as bool,
    );

Map<String, dynamic> _$PaginationDataToJson(PaginationData instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'pageSize': instance.pageSize,
      'totalPages': instance.totalPages,
      'totalItems': instance.totalItems,
      'hasNextPage': instance.hasNextPage,
      'hasPrevPage': instance.hasPrevPage,
    };
