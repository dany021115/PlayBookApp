import 'package:envied/envied.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

part 'env.g.dart';

@Envied(path: '.env', obfuscate: false)
abstract class Env {
  @EnviedField(varName: 'API_BASE_URL', defaultValue: 'http://10.0.2.2:18002')
  static const String _rawApiBaseUrl = _Env._rawApiBaseUrl;

  @EnviedField(varName: 'WS_BASE_URL', defaultValue: 'ws://10.0.2.2:18002')
  static const String _rawWsBaseUrl = _Env._rawWsBaseUrl;

  @EnviedField(varName: 'INTERNAL_API_KEY', defaultValue: '')
  static const String internalApiKey = _Env.internalApiKey;

  @EnviedField(varName: 'SENTRY_DSN', defaultValue: '')
  static const String sentryDsn = _Env.sentryDsn;

  /// Adaptive API base URL.
  ///
  /// `10.0.2.2` is the Android emulator's loopback to the host. It does NOT
  /// resolve in Chrome, iOS simulator, or desktop builds, so we rewrite it
  /// to `localhost` everywhere except Android. The `.env` keeps the
  /// emulator-friendly default; this getter does the rewrite at runtime.
  static String get apiBaseUrl => _adaptHost(_rawApiBaseUrl);
  static String get wsBaseUrl => _adaptHost(_rawWsBaseUrl);

  static String _adaptHost(String url) {
    if (defaultTargetPlatform == TargetPlatform.android && !kIsWeb) {
      return url;
    }
    return url.replaceFirst('10.0.2.2', 'localhost');
  }
}
