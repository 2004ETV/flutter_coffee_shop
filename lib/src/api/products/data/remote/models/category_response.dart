import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoriesResponse {
  const CategoriesResponse({
    required this.data,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  @JsonKey(name: 'data')
  final List<CategoryResponse> data;
}

@JsonSerializable()
class CategoryResponse {
  const CategoryResponse({
    required this.id,
    required this.slug,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'slug')
  final String slug;
}
