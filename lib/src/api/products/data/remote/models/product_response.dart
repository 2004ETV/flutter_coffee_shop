import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductsResponse {
  const ProductsResponse({
    required this.data,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);

  final List<ProductResponse> data;
}

@JsonSerializable()
class ProductResponse {
  const ProductResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.prices,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'category')
  final ProductCategoryResponse category;

  @JsonKey(name: 'imageUrl')
  final String imageUrl;

  @JsonKey(name: 'prices')
  final List<ProductPriceResponse> prices;
}

@JsonSerializable()
class ProductCategoryResponse {
  const ProductCategoryResponse({
    required this.id,
    required this.slug,
  });

  factory ProductCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryResponseFromJson(json);

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'slug')
  final String slug;
}

@JsonSerializable()
class ProductPriceResponse {
  const ProductPriceResponse({
    required this.price,
    required this.currency,
  });

  factory ProductPriceResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductPriceResponseFromJson(json);

  @JsonKey(name: 'value')
  final String price;

  @JsonKey(name: 'currency')
  final Currency currency;
}

@JsonEnum()
enum Currency {
  @JsonValue('USD')
  usd,
  @JsonValue('RUB')
  rub,
}
