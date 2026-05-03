import 'package:fpdart/fpdart.dart';

import '../../data/api/app_error.dart';
import '../entities/user.dart';

/// Authentication contract. Implementations live in `data/repository/`.
abstract class IAuthRepository {
  /// True if there's a valid session loaded in memory after [bootstrap].
  bool get isAuthenticated;

  /// Hydrate any persisted session at app start. Called once from `main.dart`.
  Future<void> bootstrap();

  /// Email + password login.
  Future<Either<AppError, User>> loginWithPassword({
    required String username,
    required String password,
  });

  /// Google sign-in: caller obtains a Google access token via `google_sign_in`,
  /// hands it to the backend which validates and issues our own JWTs.
  /// `googleEmail` is sent as the JWT serializer's `username` field (it requires
  /// a non-blank value before our custom validate() can bypass it for Google).
  Future<Either<AppError, User>> loginWithGoogle({
    required String googleAccessToken,
    required String platform,
    String googleEmail,
  });

  /// Register a new account. Auto-login NOT performed — caller decides.
  Future<Either<AppError, User>> register({
    required String username,
    required String email,
    required String password,
    String firstName,
    String lastName,
  });

  /// Pull `/api/v1/auth/account/me/`.
  Future<Either<AppError, User>> me();

  /// Request a password-reset email. Backend POSTs `{email}` and emails a
  /// confirmation link with a token (handled out of band).
  Future<Either<AppError, Unit>> requestPasswordReset({required String email});

  /// Wipe in-memory + persisted session.
  Future<void> logout();

  /// Stream of session changes; emits [User] when logged in, `null` otherwise.
  Stream<User?> get userChanges;

  /// Last known user without hitting the network. May be null.
  User? get currentUser;
}
