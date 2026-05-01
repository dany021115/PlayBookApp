import 'package:dio/dio.dart';

/// Adds the static `X-Api-Key` header to every outbound request.
class ApiKeyInterceptor extends Interceptor {
  final String apiKey;
  ApiKeyInterceptor(this.apiKey);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (apiKey.isNotEmpty) {
      options.headers['X-Api-Key'] = apiKey;
    }
    handler.next(options);
  }
}
