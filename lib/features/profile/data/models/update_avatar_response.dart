import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';

part 'update_avatar_response.g.dart';

@JsonSerializable()
class UpdateAvatarResponse extends GeneralResponse {
  @JsonKey(name: 'data')
  final UpdatedAvatarData? updatedAvatarData;

  const UpdateAvatarResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    this.updatedAvatarData,
    super.metadata,
  });

  factory UpdateAvatarResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateAvatarResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UpdateAvatarResponseToJson(this);
}

@JsonSerializable()
class UpdatedAvatarData {
  final String avatarId;
  final String avatarUrl;
  final int width;
  final int height;
  final String format;
  final int fileSize;

  const UpdatedAvatarData({
    required this.avatarId,
    required this.avatarUrl,
    required this.width,
    required this.height,
    required this.format,
    required this.fileSize,
  });

  factory UpdatedAvatarData.fromJson(Map<String, dynamic> json) =>
      _$UpdatedAvatarDataFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatedAvatarDataToJson(this);
}
