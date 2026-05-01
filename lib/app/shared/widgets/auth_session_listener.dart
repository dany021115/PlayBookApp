import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playbook/app/bloc/auth/auth_bloc.dart';
import 'package:playbook/phoenix.dart';

/// Wraps the app to react to global auth state transitions (e.g. force restart on logout
/// to wipe DI singletons + BLoC state).
class AuthSessionListener extends StatelessWidget {
  final Widget child;
  const AuthSessionListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (p, n) =>
          p is AuthStateAuthenticated && n is AuthStateUnauthenticated,
      listener: (context, _) => Phoenix.rebirth(context),
      child: child,
    );
  }
}
