import 'package:dio/dio.dart';
import 'package:flutter_coffee_shop/src/network/api_client/errors/network_error.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient implements Interceptor {
  ApiClient({required String baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (status) {
          return status != null && status >= 200 && status < 300 ||
              status == 304;
        },
      ),
    )..interceptors.addAll([
        this,
        PrettyDioLogger(),
      ]);
  }

  late final Dio _dio;

  Dio get dio => _dio;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final networkError = NetworkError(err);
    handler.next(networkError);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}
