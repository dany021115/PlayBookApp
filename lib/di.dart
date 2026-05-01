import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'data/api/api_key_interceptor.dart';
import 'data/api/auth_interceptor.dart';
import 'data/api/rest_client.dart';
import 'data/service/auth_token_storage.dart';
import 'di.config.dart';
import 'env.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies({void Function()? onLogout}) async {
  // 1. Dio + RestClient (consumed by injectable-registered repos).
  //    The "refresh" Dio is bare so AuthInterceptor can refresh the token
  //    via /token/refresh/ without recursing into itself.
  final apiKey = ApiKeyInterceptor(Env.internalApiKey);

  final refreshDio = Dio(BaseOptions(
    baseUrl: Env.apiBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 30),
    headers: {'Content-Type': 'application/json'},
  ))
    ..interceptors.add(apiKey);

  final dio = Dio(BaseOptions(
    baseUrl: Env.apiBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 30),
    headers: {'Content-Type': 'application/json'},
  ));

  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<RestClient>(() => RestClient(getIt<Dio>()));

  // 2. Generated registrations (AuthTokenStorage @lazySingleton,
  //    AuthRepository @LazySingleton(as: IAuthRepository), AuthBloc @singleton).
  getIt.init();

  // 3. Wire interceptors using the now-registered AuthTokenStorage.
  dio.interceptors.addAll([
    apiKey,
    AuthInterceptor(
      storage: getIt<AuthTokenStorage>(),
      refreshDio: refreshDio,
      onLogout: onLogout ?? () {},
    ),
  ]);
}
