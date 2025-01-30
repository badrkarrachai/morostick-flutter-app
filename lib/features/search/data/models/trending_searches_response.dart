import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';

part 'trending_searches_response.g.dart';

@JsonSerializable()
class TrendingSearchesResponse extends GeneralResponse {
  TrendingSearchData? get trendingData {
    if (data == null) return null;
    return TrendingSearchData.fromJson(data as Map<String, dynamic>);
  }

  const TrendingSearchesResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    super.data,
    super.metadata,
  });

  factory TrendingSearchesResponse.fromJson(Map<String, dynamic> json) =>
      _$TrendingSearchesResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TrendingSearchesResponseToJson(this);
}

@JsonSerializable()
class TrendingSearchData {
  final List<TrendingSearchItem> trending;
  final String lastUpdated;
  final bool fromCache;

  const TrendingSearchData({
    required this.trending,
    required this.lastUpdated,
    required this.fromCache,
  });

  factory TrendingSearchData.fromJson(Map<String, dynamic> json) =>
      _$TrendingSearchDataFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingSearchDataToJson(this);
}

@JsonSerializable()
class TrendingSearchItem {
  final String name;
  final bool isHot;
  final int searchCount;
  final PreviewSticker previewSticker;

  const TrendingSearchItem({
    required this.name,
    required this.isHot,
    required this.searchCount,
    required this.previewSticker,
  });

  factory TrendingSearchItem.fromJson(Map<String, dynamic> json) =>
      _$TrendingSearchItemFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingSearchItemToJson(this);
}

@JsonSerializable()
class PreviewSticker {
  final String id;
  final String webpUrl;
  final String name;
  final String packId;

  const PreviewSticker({
    required this.id,
    required this.webpUrl,
    required this.name,
    required this.packId,
  });

  factory PreviewSticker.fromJson(Map<String, dynamic> json) =>
      _$PreviewStickerFromJson(json);

  Map<String, dynamic> toJson() => _$PreviewStickerToJson(this);
}
