import 'dart:async';

import 'package:dio/dio.dart';

import '../constants/api.dart';
import '../service/auth_token_storage.dart';

/// Adds `Authorization: Bearer <access>` and refreshes once on 401.
///
/// Uses a single in-flight refresh future so concurrent 401s don't trigger
/// multiple refresh roundtrips.
class AuthInterceptor extends Interceptor {
  final AuthTokenStorage storage;
  final Dio refreshDio;
  final void Function() onLogout;

  Future<bool>? _refreshing;

  AuthInterceptor({
    required this.storage,
    required this.refreshDio,
    required this.onLogout,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = storage.accessSync;
    if (token != null && token.isNotEmpty && !_isRefreshCall(options.path)) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    final shouldRefresh =
        response?.statusCode == 401 && !_isRefreshCall(err.requestOptions.path);
    if (!shouldRefresh) {
      handler.next(err);
      return;
    }
    final ok = await (_refreshing ??= _runRefresh());
    _refreshing = null;
    if (!ok) {
      onLogout();
      handler.next(err);
      return;
    }
    // Retry original request with new token
    final retried = await _retry(err.requestOptions);
    handler.resolve(retried);
  }

  bool _isRefreshCall(String path) =>
      path.endsWith(ApiConstants.tokenRefresh);

  Future<bool> _runRefresh() async {
    final refresh = storage.refreshSync;
    if (refresh == null || refresh.isEmpty) return false;
    try {
      final resp = await refreshDio.post(
        ApiConstants.tokenRefresh,
        data: {'refresh': refresh},
      );
      final data = resp.data as Map<String, dynamic>;
      await storage.save(
        access: data['access'] as String,
        refresh: (data['refresh'] as String?) ?? refresh,
      );
      return true;
    } on DioException {
      return false;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions options) async {
    final dio = Dio(BaseOptions(
      baseUrl: options.baseUrl,
      headers: Map.of(options.headers)..['Authorization'] = 'Bearer ${storage.accessSync}',
    ));
    return dio.fetch(options);
  }
}
