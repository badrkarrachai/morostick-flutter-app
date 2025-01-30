// search_response.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/data/models/pack_model.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse extends GeneralResponse {
  SearchData? get searchData {
    if (data == null) return null;
    return SearchData.fromJson(data as Map<String, dynamic>);
  }

  const SearchResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    super.data,
    super.metadata,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}

@JsonSerializable()
class SearchData {
  final List<Pack>? packs;
  final PaginationData? pagination;

  const SearchData({
    this.packs,
    this.pagination,
  });

  factory SearchData.fromJson(Map<String, dynamic> json) =>
      _$SearchDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDataToJson(this);
}
