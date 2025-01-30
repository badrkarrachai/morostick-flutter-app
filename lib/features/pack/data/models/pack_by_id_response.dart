import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/data/models/pack_model.dart';

part 'pack_by_id_response.g.dart';

@JsonSerializable()
class PackByIdResponse extends GeneralResponse {
  Pack? get pack {
    if (data == null) return null;
    return Pack.fromJson(data as Map<String, dynamic>);
  }

  final PaginationData? pagination;

  const PackByIdResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    super.data,
    super.metadata,
    this.pagination,
  });

  factory PackByIdResponse.fromJson(Map<String, dynamic> json) =>
      _$PackByIdResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PackByIdResponseToJson(this);
}
