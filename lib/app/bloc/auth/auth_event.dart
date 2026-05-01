part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.bootstrap() = _Bootstrap;

  const factory AuthEvent.loggedInWithPassword({
    required String username,
    required String password,
  }) = _LoggedInWithPassword;

  const factory AuthEvent.loggedInWithGoogle() = _LoggedInWithGoogle;

  const factory AuthEvent.registered({
    required String username,
    required String email,
    required String password,
    @Default('') String firstName,
    @Default('') String lastName,
  }) = _Registered;

  const factory AuthEvent.loggedOut() = _LoggedOut;

  const factory AuthEvent.userPushed(User? user) = _UserPushed;
}
