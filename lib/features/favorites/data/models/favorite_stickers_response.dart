import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/data/models/pack_model.dart';

part 'favorite_stickers_response.g.dart';

@JsonSerializable()
class FavoriteStickersResponse extends GeneralResponse {
  @JsonKey(name: 'data')
  final List<Sticker>? favoriteStickersData;

  @JsonKey(name: 'pagination')
  final PaginationData? pagination;

  const FavoriteStickersResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    this.favoriteStickersData,
    super.metadata,
    this.pagination,
  });

  factory FavoriteStickersResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteStickersResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FavoriteStickersResponseToJson(this);
}
