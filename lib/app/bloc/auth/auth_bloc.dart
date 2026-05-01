import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/api/app_error.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repository/i_auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repo;
  StreamSubscription<User?>? _sub;

  AuthBloc(this._repo) : super(const AuthState.initial()) {
    on<_Bootstrap>(_onBootstrap);
    on<_LoggedInWithPassword>(_onLoggedInWithPassword);
    on<_LoggedInWithGoogle>(_onLoggedInWithGoogle);
    on<_Registered>(_onRegistered);
    on<_LoggedOut>(_onLoggedOut);
    on<_UserPushed>((event, emit) {
      emit(event.user == null
          ? const AuthState.unauthenticated()
          : AuthState.authenticated(event.user!));
    });

    _sub = _repo.userChanges.listen((u) => add(AuthEvent.userPushed(u)));
  }

  Future<void> _onBootstrap(_Bootstrap event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    await _repo.bootstrap();
    final u = _repo.currentUser;
    emit(u == null ? const AuthState.unauthenticated() : AuthState.authenticated(u));
  }

  Future<void> _onLoggedInWithPassword(
    _LoggedInWithPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _repo.loginWithPassword(
      username: event.username, password: event.password,
    );
    result.fold(
      (e) => emit(AuthState.error(e)),
      (u) => emit(AuthState.authenticated(u)),
    );
  }

  Future<void> _onLoggedInWithGoogle(
    _LoggedInWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final repo = _repo as AuthRepository;
    final account = await repo.beginGoogleFlow();
    if (account == null) {
      emit(const AuthState.unauthenticated());
      return;
    }
    final accessToken = await repo.obtainGoogleAccessToken(account);
    if (accessToken == null) {
      emit(AuthState.error(const AppError.unknown(message: 'No Google access token')));
      return;
    }
    final result = await repo.loginWithGoogle(
      googleAccessToken: accessToken,
      platform: defaultTargetPlatform == TargetPlatform.iOS ? 'IOS' : 'ANDROID',
    );
    result.fold(
      (e) => emit(AuthState.error(e)),
      (u) => emit(AuthState.authenticated(u)),
    );
  }

  Future<void> _onRegistered(_Registered event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final reg = await _repo.register(
      username: event.username,
      email: event.email,
      password: event.password,
      firstName: event.firstName,
      lastName: event.lastName,
    );
    final fail = reg.fold<AppError?>((e) => e, (_) => null);
    if (fail != null) {
      emit(AuthState.error(fail));
      return;
    }
    final loginResult = await _repo.loginWithPassword(
      username: event.username, password: event.password,
    );
    loginResult.fold(
      (e) => emit(AuthState.error(e)),
      (u) => emit(AuthState.authenticated(u)),
    );
  }

  Future<void> _onLoggedOut(_LoggedOut event, Emitter<AuthState> emit) async {
    await _repo.logout();
    emit(const AuthState.unauthenticated());
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
