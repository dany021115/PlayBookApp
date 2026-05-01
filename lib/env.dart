import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: false)
abstract class Env {
  @EnviedField(varName: 'API_BASE_URL', defaultValue: 'http://10.0.2.2:18002')
  static const String apiBaseUrl = _Env.apiBaseUrl;

  @EnviedField(varName: 'WS_BASE_URL', defaultValue: 'ws://10.0.2.2:18002')
  static const String wsBaseUrl = _Env.wsBaseUrl;

  @EnviedField(varName: 'INTERNAL_API_KEY', defaultValue: '')
  static const String internalApiKey = _Env.internalApiKey;

  @EnviedField(varName: 'SENTRY_DSN', defaultValue: '')
  static const String sentryDsn = _Env.sentryDsn;
}
