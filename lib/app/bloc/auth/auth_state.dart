part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.initial() = AuthStateInitial;
  const factory AuthState.loading() = AuthStateLoading;
  const factory AuthState.authenticated(User user) = AuthStateAuthenticated;
  const factory AuthState.unauthenticated() = AuthStateUnauthenticated;
  const factory AuthState.error(AppError error) = AuthStateError;

  bool get isAuthenticated => this is AuthStateAuthenticated;
  bool get isResolved =>
      this is AuthStateAuthenticated ||
      this is AuthStateUnauthenticated ||
      this is AuthStateError;
}
