import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';

part 'for_you_tab_response.g.dart';

@JsonSerializable()
class ForYouResponse extends GeneralResponse {
  ForYouData? get forYouData =>
      data != null ? ForYouData.fromJson(data!) : null;

  const ForYouResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    super.data,
    required this.metadata,
  });

  final Metadata metadata;

  factory ForYouResponse.fromJson(Map<String, dynamic> json) =>
      _$ForYouResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ForYouResponseToJson(this);
}

@JsonSerializable()
class ForYouData {
  final List<StickerPack>? recommended;
  final List<StickerPack>? trending;
  final SuggestedData? suggested;

  ForYouData({
    this.recommended,
    this.trending,
    this.suggested,
  });

  factory ForYouData.fromJson(Map<String, dynamic> json) =>
      _$ForYouDataFromJson(json);
  Map<String, dynamic> toJson() => _$ForYouDataToJson(this);
}

@JsonSerializable()
class SuggestedData {
  final List<StickerPack>? packs;
  final PaginationData? pagination;

  SuggestedData({
    this.packs,
    this.pagination,
  });

  factory SuggestedData.fromJson(Map<String, dynamic> json) =>
      _$SuggestedDataFromJson(json);
  Map<String, dynamic> toJson() => _$SuggestedDataToJson(this);
}

@JsonSerializable()
class StickerPack {
  @JsonKey(name: 'id')
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

  @JsonKey(name: 'id')
  String get packId => id;

  StickerPack({
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
  @JsonKey(name: 'id')
  final String id;
  final String? name;
  final String? avatarUrl;

  @JsonKey(name: 'id')
  String get creatorId => id;

  Creator({
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
  @JsonKey(name: 'id')
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

  @JsonKey(name: 'id')
  String get stickerId => id;

  Sticker({
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
class Dimensions {
  final int? width;
  final int? height;

  Dimensions({
    this.width,
    this.height,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) =>
      _$DimensionsFromJson(json);
  Map<String, dynamic> toJson() => _$DimensionsToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: 'id')
  final String id;
  final String? name;
  final String? slug;
  final String? description;
  final List<String>? emoji;
  final bool? isActive;
  final int? order;
  final bool? isGenerated;
  final CategoryStats? stats;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category({
    required this.id,
    this.name,
    this.slug,
    this.description,
    this.emoji,
    this.isActive,
    this.order,
    this.isGenerated,
    this.stats,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class CategoryStats {
  final int? packCount;
  final int? stickerCount;
  final int? totalViews;
  final int? totalDownloads;

  CategoryStats({
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

  PackStats({
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

  StickerStats({
    this.downloads,
    this.views,
    this.favorites,
  });

  factory StickerStats.fromJson(Map<String, dynamic> json) =>
      _$StickerStatsFromJson(json);
  Map<String, dynamic> toJson() => _$StickerStatsToJson(this);
}

@JsonSerializable()
class PaginationData {
  final int? currentPage;
  final int? pageSize;
  final int? totalPages;
  final int? totalItems;
  final bool? hasNextPage;
  final bool? hasPrevPage;

  PaginationData({
    this.currentPage,
    this.pageSize,
    this.totalPages,
    this.totalItems,
    this.hasNextPage,
    this.hasPrevPage,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) =>
      _$PaginationDataFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationDataToJson(this);
}

@JsonSerializable()
class Metadata {
  final DateTime? timestamp;
  final String? version;

  Metadata({
    this.timestamp,
    this.version,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);
  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
