import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/data/models/pack_model.dart';

part 'foryou_tab_response.g.dart';

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
    super.metadata,
  });

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
