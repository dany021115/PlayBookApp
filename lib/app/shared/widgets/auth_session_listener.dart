import 'package:flutter/material.dart';

/// Hook for global auth-state side effects.
///
/// The previous version called `Phoenix.rebirth()` on logout, which rebuilt
/// the subtree and triggered `BlocProvider`'s `close()` on the get_it
/// singleton AuthBloc — leaving a dead singleton that swallowed every
/// subsequent event (splash hang). Logout now relies on:
///   1. `AuthRepository.logout()` clearing tokens + currentUser
///   2. `AuthBloc` emitting `AuthState.unauthenticated`
///   3. `RouterRefreshListenable` redirecting to `/auth`
class AuthSessionListener extends StatelessWidget {
  final Widget child;
  const AuthSessionListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) => child;
}
