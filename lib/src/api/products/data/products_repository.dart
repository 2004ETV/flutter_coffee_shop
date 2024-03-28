import 'package:flutter_coffee_shop/src/api/products/data/products_repository_impl.dart';
import 'package:flutter_coffee_shop/src/api/products/data/remote/products_api_data_source.dart';
import 'package:flutter_coffee_shop/src/api/products/domain/models/category_domain.dart';
import 'package:flutter_coffee_shop/src/api/products/domain/models/product_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_repository.g.dart';

abstract interface class ProductsRepository {
  Future<List<CategoryDomain>> getCategories();

  Future<List<ProductDomain>> getProducts();
}

@riverpod
ProductsRepository productsRepository(ProductsRepositoryRef ref) {
  final dataSource = ref.watch(productApiDataSourceProvider);

  return ProductsRepositoryImpl(dataSource: dataSource);
}
