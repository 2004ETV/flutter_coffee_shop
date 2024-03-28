import 'package:dio/dio.dart';
import 'package:flutter_coffee_shop/src/api/products/data/remote/models/category_response.dart';
import 'package:flutter_coffee_shop/src/api/products/data/remote/models/product_response.dart';
import 'package:flutter_coffee_shop/src/common/providers/dio/dio_provider.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_api_data_source.g.dart';

@riverpod
ProductApiDataSource productApiDataSource(ProductApiDataSourceRef ref) {
  final apiClient = ref.watch(apiClientProvider);

  final dataSource = ProductApiDataSource(apiClient.dio);

  return dataSource;
}

@RestApi()
abstract interface class ProductApiDataSource {
  factory ProductApiDataSource(Dio dio, {String baseUrl}) =
      _ProductApiDataSource;

  @GET('v1/products/categories')
  Future<CategoriesResponse> getCategories();

  @GET('v1/products')
  Future<ProductsResponse> getProducts();
}
