import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user.dart';
import '../../domain/repository/i_auth_repository.dart';
import '../api/app_error.dart';
import '../api/rest_client.dart';
import '../entities/auth_responses.dart';
import '../service/auth_token_storage.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final RestClient _api;
  final AuthTokenStorage _tokens;
  final GoogleSignIn _google;
  final _userController = StreamController<User?>.broadcast();
  User? _currentUser;

  AuthRepository(this._api, this._tokens)
      : _google = GoogleSignIn(scopes: const ['email', 'profile', 'openid']);

  @override
  bool get isAuthenticated => _tokens.hasSession;

  @override
  User? get currentUser => _currentUser;

  @override
  Stream<User?> get userChanges => _userController.stream;

  @override
  Future<void> bootstrap() async {
    await _tokens.hydrate();
    if (!_tokens.hasSession) return;
    final result = await me();
    result.fold((_) async => await logout(), (u) {});
  }

  @override
  Future<Either<AppError, User>> loginWithPassword({
    required String username,
    required String password,
  }) =>
      _runTokenObtain(TokenObtainRequest(
        username: username,
        password: password,
        provider: 'password',
      ));

  @override
  Future<Either<AppError, User>> loginWithGoogle({
    required String googleAccessToken,
    required String platform,
    String googleEmail = 'google-user',
  }) =>
      _runTokenObtain(TokenObtainRequest(
        username: googleEmail,
        password: googleAccessToken,
        provider: 'google',
        platform: platform,
      ));

  @override
  Future<Either<AppError, User>> register({
    required String username,
    required String email,
    required String password,
    String firstName = '',
    String lastName = '',
  }) async {
    try {
      final dto = await _api.accountCreate(AccountCreateRequest(
        username: username,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      ).toJson());
      return Right(dto.toEntity());
    } on DioException catch (e) {
      return Left(AppError.fromDio(e));
    }
  }

  @override
  Future<Either<AppError, User>> me() async {
    try {
      final dto = await _api.accountMe();
      _currentUser = dto.toEntity();
      _userController.add(_currentUser);
      return Right(_currentUser!);
    } on DioException catch (e) {
      return Left(AppError.fromDio(e));
    }
  }

  @override
  Future<Either<AppError, Unit>> requestPasswordReset({
    required String email,
  }) async {
    try {
      await _api.passwordReset({'email': email});
      return const Right(unit);
    } on DioException catch (e) {
      return Left(AppError.fromDio(e));
    }
  }

  @override
  Future<void> logout() async {
    try {
      if (_google.currentUser != null) {
        await _google.signOut();
      }
    } catch (_) {}
    await _tokens.clear();
    _currentUser = null;
    _userController.add(null);
  }

  Future<GoogleSignInAccount?> beginGoogleFlow() async {
    final account = await _google.signIn();
    return account;
  }

  Future<String?> obtainGoogleAccessToken(GoogleSignInAccount account) async {
    final auth = await account.authentication;
    return auth.accessToken;
  }

  // ── internals ──

  Future<Either<AppError, User>> _runTokenObtain(TokenObtainRequest req) async {
    try {
      final resp = await _api.tokenObtain(req.toJson());
      await _tokens.save(access: resp.access, refresh: resp.refresh);
      User? user;
      if (resp.user != null) {
        user = resp.user!.toEntity();
      } else {
        final dto = await _api.accountMe();
        user = dto.toEntity();
      }
      _currentUser = user;
      _userController.add(user);
      return Right(user);
    } on DioException catch (e) {
      return Left(AppError.fromDio(e));
    }
  }
}
