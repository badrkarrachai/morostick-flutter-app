import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';

part 'for_you_tab_response.g.dart';

@JsonSerializable()
class ForYouResponse extends GeneralResponse {
  ForYouData? get forYouData =>
      data != null ? ForYouData.fromJson(data as Map<String, dynamic>) : null;

  const ForYouResponse({
    required super.status,
    required super.success,
    required super.message,
    super.data,
    required this.metadata,
  });

  final Metadata metadata;

  factory ForYouResponse.fromJson(Map<String, dynamic> json) {
    return ForYouResponse(
      status: json['status'] as int,
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] as Map<String, dynamic>?,
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );
  }
}

@JsonSerializable()
class ForYouData {
  final List<StickerPack> recommended;
  final List<StickerPack> trending;
  final SuggestedData suggested;

  ForYouData({
    required this.recommended,
    required this.trending,
    required this.suggested,
  });

  factory ForYouData.fromJson(Map<String, dynamic> json) =>
      _$ForYouDataFromJson(json);
  Map<String, dynamic> toJson() => _$ForYouDataToJson(this);
}

@JsonSerializable()
class SuggestedData {
  final List<StickerPack> packs;
  final PaginationData pagination;

  SuggestedData({
    required this.packs,
    required this.pagination,
  });

  factory SuggestedData.fromJson(Map<String, dynamic> json) =>
      _$SuggestedDataFromJson(json);
  Map<String, dynamic> toJson() => _$SuggestedDataToJson(this);
}

@JsonSerializable()
class StickerPack {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String description;
  final Creator creator;
  final List<Sticker> previewStickers;
  final int totalStickers;
  final bool isAnimatedPack;
  final PackStats stats;

  @JsonKey(name: '_id')
  String get packId => id;

  StickerPack({
    required this.id,
    required this.name,
    required this.description,
    required this.creator,
    required this.previewStickers,
    required this.totalStickers,
    required this.isAnimatedPack,
    required this.stats,
  });

  factory StickerPack.fromJson(Map<String, dynamic> json) =>
      _$StickerPackFromJson(json);
  Map<String, dynamic> toJson() => _$StickerPackToJson(this);
}

@JsonSerializable()
class Creator {
  @JsonKey(name: '_id')
  final String id;
  final String username;
  final String? avatarUrl;

  @JsonKey(name: '_id')
  String get creatorId => id;

  Creator({
    required this.id,
    required this.username,
    this.avatarUrl,
  });

  factory Creator.fromJson(Map<String, dynamic> json) =>
      _$CreatorFromJson(json);
  Map<String, dynamic> toJson() => _$CreatorToJson(this);
}

@JsonSerializable()
class Sticker {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String webpUrl;
  final String thumbnailUrl;
  final int fileSize;
  final Dimensions dimensions;
  final int position;
  final DateTime createdAt;
  final DateTime updatedAt;

  @JsonKey(name: '_id')
  String get stickerId => id;

  Sticker({
    required this.id,
    required this.name,
    required this.webpUrl,
    required this.thumbnailUrl,
    required this.fileSize,
    required this.dimensions,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sticker.fromJson(Map<String, dynamic> json) =>
      _$StickerFromJson(json);
  Map<String, dynamic> toJson() => _$StickerToJson(this);
}

@JsonSerializable()
class Dimensions {
  final int width;
  final int height;

  Dimensions({
    required this.width,
    required this.height,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) =>
      _$DimensionsFromJson(json);
  Map<String, dynamic> toJson() => _$DimensionsToJson(this);
}

@JsonSerializable()
class PackStats {
  final int downloads;
  final int views;
  final int favorites;

  PackStats({
    required this.downloads,
    required this.views,
    required this.favorites,
  });

  factory PackStats.fromJson(Map<String, dynamic> json) =>
      _$PackStatsFromJson(json);
  Map<String, dynamic> toJson() => _$PackStatsToJson(this);
}

@JsonSerializable()
class PaginationData {
  final int currentPage;
  final int pageSize;
  final int totalPages;
  final int totalItems;
  final bool hasNextPage;
  final bool hasPrevPage;

  PaginationData({
    required this.currentPage,
    required this.pageSize,
    required this.totalPages,
    required this.totalItems,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) =>
      _$PaginationDataFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationDataToJson(this);
}
