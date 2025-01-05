import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/data/models/pack_model.dart';

part 'toggle_sticker_favorite_response.g.dart';

@JsonSerializable()
class ToggleStickerFavoriteResponse extends GeneralResponse {
  @JsonKey(name: 'data')
  final ToggleStickerFavoriteData? favoriteData;

  const ToggleStickerFavoriteResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    this.favoriteData,
    super.metadata,
  });

  factory ToggleStickerFavoriteResponse.fromJson(Map<String, dynamic> json) =>
      _$ToggleStickerFavoriteResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ToggleStickerFavoriteResponseToJson(this);
}

@JsonSerializable()
class ToggleStickerFavoriteData {
  final bool isFavorite;
  final int favoritesCount;
  final Pack? pack;

  const ToggleStickerFavoriteData({
    required this.isFavorite,
    required this.favoritesCount,
    this.pack,
  });

  factory ToggleStickerFavoriteData.fromJson(Map<String, dynamic> json) =>
      _$ToggleStickerFavoriteDataFromJson(json);

  Map<String, dynamic> toJson() => _$ToggleStickerFavoriteDataToJson(this);
}
