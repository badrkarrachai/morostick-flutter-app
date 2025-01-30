import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/data/models/pack_model.dart';

part 'trending_tab_response.g.dart';

@JsonSerializable()
class TrendingResponse extends GeneralResponse {
  TrendingData? get trendingData =>
      data != null ? TrendingData.fromJson(data!) : null;

  const TrendingResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    super.data,
    super.metadata,
  });

  factory TrendingResponse.fromJson(Map<String, dynamic> json) =>
      _$TrendingResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TrendingResponseToJson(this);
}

@JsonSerializable()
class TrendingData {
  final List<Category>? topCategories;
  final TrendingContent? trending;

  TrendingData({
    this.topCategories,
    this.trending,
  });

  factory TrendingData.fromJson(Map<String, dynamic> json) =>
      _$TrendingDataFromJson(json);
  Map<String, dynamic> toJson() => _$TrendingDataToJson(this);
}

@JsonSerializable()
class TrendingContent {
  final List<Pack>? packs;
  final PaginationData? pagination;

  TrendingContent({
    this.packs,
    this.pagination,
  });

  factory TrendingContent.fromJson(Map<String, dynamic> json) =>
      _$TrendingContentFromJson(json);
  Map<String, dynamic> toJson() => _$TrendingContentToJson(this);
}
