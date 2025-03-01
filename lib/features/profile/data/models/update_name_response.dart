// search_response.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';

part 'update_name_response.g.dart';

@JsonSerializable()
class UpdateNameResponse extends GeneralResponse {
  String? get userName {
    if (data == null) return null;
    return data['name'] as String;
  }

  const UpdateNameResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    super.data,
    super.metadata,
  });

  factory UpdateNameResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateNameResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UpdateNameResponseToJson(this);
}
