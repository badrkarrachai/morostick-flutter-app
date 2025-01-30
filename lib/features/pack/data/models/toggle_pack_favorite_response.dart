import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/data/models/pack_model.dart';

part 'toggle_pack_favorite_response.g.dart';

@JsonSerializable()
class TogglePackFavoriteResponse extends GeneralResponse {
  @JsonKey(name: 'data')
  final TogglePackFavoriteData? favoriteData;

  const TogglePackFavoriteResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    this.favoriteData,
    super.metadata,
  });

  factory TogglePackFavoriteResponse.fromJson(Map<String, dynamic> json) =>
      _$TogglePackFavoriteResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TogglePackFavoriteResponseToJson(this);
}

@JsonSerializable()
class TogglePackFavoriteData {
  final bool isFavorite;
  final int favoritesCount;
  final Pack? pack;

  const TogglePackFavoriteData({
    required this.isFavorite,
    required this.favoritesCount,
    this.pack,
  });

  factory TogglePackFavoriteData.fromJson(Map<String, dynamic> json) =>
      _$TogglePackFavoriteDataFromJson(json);

  Map<String, dynamic> toJson() => _$TogglePackFavoriteDataToJson(this);
}
