// sticker_pack_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'pack_model.g.dart';

@JsonSerializable()
class StickerPack {
  final String id;
  final String? name;
  final String? description;
  final String? trayIcon;
  final Creator creator;
  final List<Sticker>? stickers;
  final bool? isPrivate;
  final bool? isAuthorized;
  final bool? isAnimatedPack;
  final List<Category>? categories;
  final int? totalStickers;
  final PackStats? stats;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  String get packId => id;

  const StickerPack({
    required this.id,
    this.name,
    this.description,
    this.trayIcon,
    required this.creator,
    this.stickers,
    this.isPrivate,
    this.isAuthorized,
    this.isAnimatedPack,
    this.categories,
    this.totalStickers,
    this.stats,
    this.createdAt,
    this.updatedAt,
  });

  factory StickerPack.fromJson(Map<String, dynamic> json) =>
      _$StickerPackFromJson(json);
  Map<String, dynamic> toJson() => _$StickerPackToJson(this);
}

@JsonSerializable()
class Creator {
  final String id;
  final String? name;
  final String? avatarUrl;

  String get creatorId => id;

  const Creator({
    required this.id,
    this.name,
    this.avatarUrl,
  });

  factory Creator.fromJson(Map<String, dynamic> json) =>
      _$CreatorFromJson(json);
  Map<String, dynamic> toJson() => _$CreatorToJson(this);
}

@JsonSerializable()
class Sticker {
  final String id;
  final String? packId;
  final String? name;
  final List<String>? emojis;
  final String? thumbnailUrl;
  final String? webpUrl;
  final bool? isAnimated;
  final int? fileSize;
  final Creator? creator;
  final Dimensions? dimensions;
  final String? format;
  final List<Category>? categories;
  final int? position;
  final StickerStats? stats;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  String get stickerId => id;

  const Sticker({
    required this.id,
    this.packId,
    this.name,
    this.emojis,
    this.thumbnailUrl,
    this.webpUrl,
    this.isAnimated,
    this.fileSize,
    this.creator,
    this.dimensions,
    this.format,
    this.categories,
    this.position,
    this.stats,
    this.createdAt,
    this.updatedAt,
  });

  factory Sticker.fromJson(Map<String, dynamic> json) =>
      _$StickerFromJson(json);
  Map<String, dynamic> toJson() => _$StickerToJson(this);
}

@JsonSerializable()
class Category {
  final String id;
  final String? name;
  final String? slug;
  final String? description;
  final List<String>? emoji;
  final String? trayIcon;
  final bool? isActive;
  final int? order;
  final bool? isGenerated;
  final int? tabindex;
  final CategoryStats? stats;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isStatic;

  const Category({
    required this.id,
    this.name,
    this.slug,
    this.description,
    this.emoji,
    this.trayIcon,
    this.isActive,
    this.order,
    this.isGenerated,
    this.tabindex,
    this.stats,
    this.createdAt,
    this.updatedAt,
    this.isStatic = false,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Dimensions {
  final int? width;
  final int? height;

  const Dimensions({
    this.width,
    this.height,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) =>
      _$DimensionsFromJson(json);
  Map<String, dynamic> toJson() => _$DimensionsToJson(this);
}

@JsonSerializable()
class CategoryStats {
  final int? packCount;
  final int? stickerCount;
  final int? totalViews;
  final int? totalDownloads;

  const CategoryStats({
    this.packCount,
    this.stickerCount,
    this.totalViews,
    this.totalDownloads,
  });

  factory CategoryStats.fromJson(Map<String, dynamic> json) =>
      _$CategoryStatsFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryStatsToJson(this);
}

@JsonSerializable()
class PackStats {
  final int? downloads;
  final int? views;
  final int? favorites;

  const PackStats({
    this.downloads,
    this.views,
    this.favorites,
  });

  factory PackStats.fromJson(Map<String, dynamic> json) =>
      _$PackStatsFromJson(json);
  Map<String, dynamic> toJson() => _$PackStatsToJson(this);
}

@JsonSerializable()
class StickerStats {
  final int? downloads;
  final int? views;
  final int? favorites;

  const StickerStats({
    this.downloads,
    this.views,
    this.favorites,
  });

  factory StickerStats.fromJson(Map<String, dynamic> json) =>
      _$StickerStatsFromJson(json);
  Map<String, dynamic> toJson() => _$StickerStatsToJson(this);
}
