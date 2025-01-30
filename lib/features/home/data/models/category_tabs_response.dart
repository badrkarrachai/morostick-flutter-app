// category_tabs_response.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/data/models/pack_model.dart';

part 'category_tabs_response.g.dart';

@JsonSerializable()
class CategoryResponse extends GeneralResponse {
  List<Category>? get topCategoryTabs => data != null
      ? (data!['topCategoryTabs'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList()
      : null;

  const CategoryResponse({
    required super.status,
    required super.success,
    required super.message,
    super.error,
    super.data,
    super.metadata,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
