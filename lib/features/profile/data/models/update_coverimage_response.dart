import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';

part 'update_coverimage_response.g.dart';

@JsonSerializable()
class UpdateCoverimageResponse extends GeneralResponse {
  @JsonKey(name: 'data')
  final UpdatedCoverData? updatedAvatarData;

  const UpdateCoverimageResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    this.updatedAvatarData,
    super.metadata,
  });

  factory UpdateCoverimageResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateCoverimageResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UpdateCoverimageResponseToJson(this);
}

@JsonSerializable()
class UpdatedCoverData {
  final String coverImageId;
  final String coverImageUrl;
  final int width;
  final int height;
  final String format;
  final int fileSize;

  const UpdatedCoverData({
    required this.coverImageId,
    required this.coverImageUrl,
    required this.width,
    required this.height,
    required this.format,
    required this.fileSize,
  });

  factory UpdatedCoverData.fromJson(Map<String, dynamic> json) =>
      _$UpdatedCoverDataFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatedCoverDataToJson(this);
}
