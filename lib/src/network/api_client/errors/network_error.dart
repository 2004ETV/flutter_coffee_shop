import 'package:dio/dio.dart';

class NetworkError implements DioException {
  NetworkError(DioException exception)
      : requestOptions = exception.requestOptions,
        response = exception.response,
        type = exception.type,
        error = exception.error,
        stackTrace = exception.stackTrace {
    final response = this.response;
    if (response is Response) {
      final data = response.data;
      if (data is Map) {
        final message = data['detail'];
        if (message is String) {
          _message = message;
        }
      }
    }
    _message ??= exception.message;
  }

  @override
  Object? error;

  @override
  String? get message => _message;

  @override
  RequestOptions requestOptions;

  @override
  Response? response;

  @override
  DioExceptionType type;

  String? _message;

  @override
  StackTrace stackTrace;

  @override
  DioException copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioExceptionType? type,
    Object? error,
    StackTrace? stackTrace,
    String? message,
  }) {
    return NetworkError(
      DioException(
        requestOptions: requestOptions ?? this.requestOptions,
        response: response ?? this.response,
        type: type ?? this.type,
        error: error ?? this.error,
        stackTrace: stackTrace ?? this.stackTrace,
        message: message ?? this.message,
      ),
    );
  }

  @override
  String toString() {
    return message.toString();
  }
}
