import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/data/models/pack_model.dart';

part 'favorite_packs_response.g.dart';

@JsonSerializable()
class FavoritePacksResponse extends GeneralResponse {
  @JsonKey(name: 'data')
  final List<Pack>? favoritePacksData;

  @JsonKey(name: 'pagination')
  final PaginationData? pagination;

  const FavoritePacksResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    this.favoritePacksData,
    super.metadata,
    this.pagination,
  });

  factory FavoritePacksResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoritePacksResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FavoritePacksResponseToJson(this);
}
