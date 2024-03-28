import 'package:flutter_coffee_shop/src/api/products/data/remote/models/category_response.dart';
import 'package:flutter_coffee_shop/src/api/products/domain/models/category_domain.dart';

extension CategoryDomainMapper on CategoryResponse {
  CategoryDomain toDomain() {
    return CategoryDomain(
      id: id,
      slug: slug,
    );
  }
}
