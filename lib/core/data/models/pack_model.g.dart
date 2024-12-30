// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pack_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StickerPack _$StickerPackFromJson(Map<String, dynamic> json) => StickerPack(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      trayIcon: json['trayIcon'] as String?,
      creator: Creator.fromJson(json['creator'] as Map<String, dynamic>),
      stickers: (json['stickers'] as List<dynamic>?)
          ?.map((e) => Sticker.fromJson(e as Map<String, dynamic>))
          .toList(),
      isPrivate: json['isPrivate'] as bool?,
      isAuthorized: json['isAuthorized'] as bool?,
      isAnimatedPack: json['isAnimatedPack'] as bool?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalStickers: (json['totalStickers'] as num?)?.toInt(),
      stats: json['stats'] == null
          ? null
          : PackStats.fromJson(json['stats'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$StickerPackToJson(StickerPack instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'trayIcon': instance.trayIcon,
      'creator': instance.creator,
      'stickers': instance.stickers,
      'isPrivate': instance.isPrivate,
      'isAuthorized': instance.isAuthorized,
      'isAnimatedPack': instance.isAnimatedPack,
      'categories': instance.categories,
      'totalStickers': instance.totalStickers,
      'stats': instance.stats,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

Creator _$CreatorFromJson(Map<String, dynamic> json) => Creator(
      id: json['id'] as String,
      name: json['name'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$CreatorToJson(Creator instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
    };

Sticker _$StickerFromJson(Map<String, dynamic> json) => Sticker(
      id: json['id'] as String,
      packId: json['packId'] as String?,
      name: json['name'] as String?,
      emojis:
          (json['emojis'] as List<dynamic>?)?.map((e) => e as String).toList(),
      thumbnailUrl: json['thumbnailUrl'] as String?,
      webpUrl: json['webpUrl'] as String?,
      isAnimated: json['isAnimated'] as bool?,
      fileSize: (json['fileSize'] as num?)?.toInt(),
      creator: json['creator'] == null
          ? null
          : Creator.fromJson(json['creator'] as Map<String, dynamic>),
      dimensions: json['dimensions'] == null
          ? null
          : Dimensions.fromJson(json['dimensions'] as Map<String, dynamic>),
      format: json['format'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      position: (json['position'] as num?)?.toInt(),
      stats: json['stats'] == null
          ? null
          : StickerStats.fromJson(json['stats'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$StickerToJson(Sticker instance) => <String, dynamic>{
      'id': instance.id,
      'packId': instance.packId,
      'name': instance.name,
      'emojis': instance.emojis,
      'thumbnailUrl': instance.thumbnailUrl,
      'webpUrl': instance.webpUrl,
      'isAnimated': instance.isAnimated,
      'fileSize': instance.fileSize,
      'creator': instance.creator,
      'dimensions': instance.dimensions,
      'format': instance.format,
      'categories': instance.categories,
      'position': instance.position,
      'stats': instance.stats,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as String,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      emoji:
          (json['emoji'] as List<dynamic>?)?.map((e) => e as String).toList(),
      trayIcon: json['trayIcon'] as String?,
      isActive: json['isActive'] as bool?,
      order: (json['order'] as num?)?.toInt(),
      isGenerated: json['isGenerated'] as bool?,
      tabindex: (json['tabindex'] as num?)?.toInt(),
      stats: json['stats'] == null
          ? null
          : CategoryStats.fromJson(json['stats'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isStatic: json['isStatic'] as bool? ?? false,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'emoji': instance.emoji,
      'trayIcon': instance.trayIcon,
      'isActive': instance.isActive,
      'order': instance.order,
      'isGenerated': instance.isGenerated,
      'tabindex': instance.tabindex,
      'stats': instance.stats,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isStatic': instance.isStatic,
    };

Dimensions _$DimensionsFromJson(Map<String, dynamic> json) => Dimensions(
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DimensionsToJson(Dimensions instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };

CategoryStats _$CategoryStatsFromJson(Map<String, dynamic> json) =>
    CategoryStats(
      packCount: (json['packCount'] as num?)?.toInt(),
      stickerCount: (json['stickerCount'] as num?)?.toInt(),
      totalViews: (json['totalViews'] as num?)?.toInt(),
      totalDownloads: (json['totalDownloads'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategoryStatsToJson(CategoryStats instance) =>
    <String, dynamic>{
      'packCount': instance.packCount,
      'stickerCount': instance.stickerCount,
      'totalViews': instance.totalViews,
      'totalDownloads': instance.totalDownloads,
    };

PackStats _$PackStatsFromJson(Map<String, dynamic> json) => PackStats(
      downloads: (json['downloads'] as num?)?.toInt(),
      views: (json['views'] as num?)?.toInt(),
      favorites: (json['favorites'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PackStatsToJson(PackStats instance) => <String, dynamic>{
      'downloads': instance.downloads,
      'views': instance.views,
      'favorites': instance.favorites,
    };

StickerStats _$StickerStatsFromJson(Map<String, dynamic> json) => StickerStats(
      downloads: (json['downloads'] as num?)?.toInt(),
      views: (json['views'] as num?)?.toInt(),
      favorites: (json['favorites'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StickerStatsToJson(StickerStats instance) =>
    <String, dynamic>{
      'downloads': instance.downloads,
      'views': instance.views,
      'favorites': instance.favorites,
    };
