import 'package:flutter_coffee_shop/src/api/products/data/products_repository.dart';
import 'package:flutter_coffee_shop/src/api/products/data/remote/models/mappers/category_domain_mapper.dart';
import 'package:flutter_coffee_shop/src/api/products/data/remote/models/mappers/product_domain_mapper.dart';
import 'package:flutter_coffee_shop/src/api/products/data/remote/products_api_data_source.dart';
import 'package:flutter_coffee_shop/src/api/products/domain/models/category_domain.dart';
import 'package:flutter_coffee_shop/src/api/products/domain/models/product_domain.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  const ProductsRepositoryImpl({
    required this.dataSource,
  });

  final ProductApiDataSource dataSource;

  @override
  Future<List<CategoryDomain>> getCategories() async {
    try {
      final categories = await dataSource.getCategories();

      return categories.data.map((e) => e.toDomain()).toList();
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<ProductDomain>> getProducts() async {
    try {
      final products = await dataSource.getProducts();

      return products.data.map((e) => e.toDomain()).toList();
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}
