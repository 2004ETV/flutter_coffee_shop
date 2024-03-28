import 'package:flutter_coffee_shop/src/api/products/data/remote/models/product_response.dart';
import 'package:flutter_coffee_shop/src/api/products/domain/models/product_domain.dart';

extension ProductDomainMapper on ProductResponse {
  ProductDomain toDomain() {
    return ProductDomain(
      id: id,
      name: name,
      description: description,
      category: category.toDomain(),
      imageUrl: imageUrl,
      prices: prices.map((e) => e.toDomain()).toList(),
    );
  }
}

extension ProductCategoryDomainMapper on ProductCategoryResponse {
  ProductCategoryDomain toDomain() {
    return ProductCategoryDomain(
      id: id,
      slug: slug,
    );
  }
}

extension ProductPriceDomainMapper on ProductPriceResponse {
  ProductPriceDomain toDomain() {
    return ProductPriceDomain(
      price: price,
      currency: currency,
    );
  }
}
