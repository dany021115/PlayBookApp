// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'app/bloc/auth/auth_bloc.dart' as _i429;
import 'data/api/rest_client.dart' as _i334;
import 'data/repository/auth_repository.dart' as _i691;
import 'data/service/auth_token_storage.dart' as _i322;
import 'domain/repository/i_auth_repository.dart' as _i1044;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i322.AuthTokenStorage>(() => _i322.AuthTokenStorage());
    gh.lazySingleton<_i1044.IAuthRepository>(
      () => _i691.AuthRepository(
        gh<_i334.RestClient>(),
        gh<_i322.AuthTokenStorage>(),
      ),
    );
    gh.singleton<_i429.AuthBloc>(
      () => _i429.AuthBloc(gh<_i1044.IAuthRepository>()),
    );
    return this;
  }
}
