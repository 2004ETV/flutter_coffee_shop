import 'package:flutter_coffee_shop/src/network/api_client/api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
String baseUrl(BaseUrlRef ref) {
  return dotenv.env['API_BASE_URL']!;
}

@riverpod
ApiClient apiClient(ApiClientRef ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  return ApiClient(baseUrl: baseUrl);
}
