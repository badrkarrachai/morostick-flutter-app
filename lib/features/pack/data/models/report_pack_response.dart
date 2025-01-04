import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';

part 'report_pack_response.g.dart';

@JsonSerializable()
class ReportPackResponse extends GeneralResponse {
  const ReportPackResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    super.data,
    super.metadata,
  });

  factory ReportPackResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportPackResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReportPackResponseToJson(this);
}
