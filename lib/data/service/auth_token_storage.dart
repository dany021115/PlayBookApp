import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// Persists access + refresh JWTs across app restarts.
///
/// Access token also kept in-memory for sync access by the [AuthInterceptor]
/// without hitting flash storage on every request.
@lazySingleton
class AuthTokenStorage {
  static const _kAccess = 'jwt_access';
  static const _kRefresh = 'jwt_refresh';

  final FlutterSecureStorage _storage;
  String? _accessCache;
  String? _refreshCache;

  AuthTokenStorage()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        );

  Future<void> save({required String access, required String refresh}) async {
    _accessCache = access;
    _refreshCache = refresh;
    await _storage.write(key: _kAccess, value: access);
    await _storage.write(key: _kRefresh, value: refresh);
  }

  Future<void> hydrate() async {
    _accessCache = await _storage.read(key: _kAccess);
    _refreshCache = await _storage.read(key: _kRefresh);
  }

  Future<void> clear() async {
    _accessCache = null;
    _refreshCache = null;
    await _storage.delete(key: _kAccess);
    await _storage.delete(key: _kRefresh);
  }

  String? get accessSync => _accessCache;
  String? get refreshSync => _refreshCache;
  bool get hasSession => (_accessCache?.isNotEmpty ?? false);
}
