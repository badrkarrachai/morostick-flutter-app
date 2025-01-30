import 'package:json_annotation/json_annotation.dart';
part 'report_pack_request_body.g.dart';

@JsonSerializable()
class ReportPackRequestBody {
  final String reason;

  ReportPackRequestBody({required this.reason});

  Map<String, dynamic> toJson() => _$ReportPackRequestBodyToJson(this);
}
