import 'package:equatable/equatable.dart';
import 'package:flutter_coffee_shop/src/api/products/data/remote/models/product_response.dart';

class ProductDomain extends Equatable {
  const ProductDomain({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.prices,
  });

  final int id;
  final String name;
  final String description;
  final ProductCategoryDomain category;
  final String imageUrl;
  final List<ProductPriceDomain> prices;

  @override
  List<Object?> get props => [name, description, category, imageUrl];
}

class ProductCategoryDomain extends Equatable {
  const ProductCategoryDomain({
    required this.id,
    required this.slug,
  });

  final int id;
  final String slug;

  @override
  List<Object?> get props => [id, slug];
}

class ProductPriceDomain extends Equatable {
  const ProductPriceDomain({
    required this.price,
    required this.currency,
  });

  final String price;
  final Currency currency;

  @override
  List<Object?> get props => [price];
}
