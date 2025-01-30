import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';

part 'hide_pack_response.g.dart';

@JsonSerializable()
class HidePackResponse extends GeneralResponse {
  const HidePackResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    super.data,
    super.metadata,
  });

  factory HidePackResponse.fromJson(Map<String, dynamic> json) =>
      _$HidePackResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HidePackResponseToJson(this);
}
