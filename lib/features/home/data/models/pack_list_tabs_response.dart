import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/data/models/pack_model.dart';

part 'pack_list_tabs_response.g.dart';

@JsonSerializable()
class PacksListResponse extends GeneralResponse {
  List<Pack>? get packs {
    if (data == null) return null;
    if (data is! List) return null;
    return (data as List)
        .map((e) => Pack.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  final PaginationData? pagination;

  const PacksListResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    super.data,
    super.metadata,
    this.pagination,
  });

  factory PacksListResponse.fromJson(Map<String, dynamic> json) =>
      _$PacksListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PacksListResponseToJson(this);
}
