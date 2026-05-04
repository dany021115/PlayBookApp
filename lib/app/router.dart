import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playbook/app/bloc/auth/auth_bloc.dart';
import 'package:playbook/app/presentation/auth/forgot_password/forgot_password_page.dart';
import 'package:playbook/app/presentation/auth/sign_in/sign_in_page.dart';
import 'package:playbook/app/presentation/auth/sign_up/sign_up_page.dart';
import 'package:playbook/app/presentation/error/connection_error_page.dart';
import 'package:playbook/app/presentation/home/follows_page.dart';
import 'package:playbook/app/presentation/home/matches_page.dart';
import 'package:playbook/app/presentation/home/predictions_page.dart';
import 'package:playbook/app/presentation/home/profile_page.dart';
import 'package:playbook/app/presentation/match_detail/match_detail_page.dart';
import 'package:playbook/app/presentation/splash/splash_page.dart';
import 'package:playbook/app/shared/widgets/main_shell.dart';
import 'package:playbook/device/router/manager.dart';
import 'package:playbook/device/router/transitions.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

enum AppRoute {
  splash,
  auth,
  signUp,
  forgotPassword,
  welcome,
  home,
  matches,
  predictions,
  follows,
  profile,
  matchDetail,
  predictionDetail,
  connectionError,
}

class RouterRefreshListenable extends ChangeNotifier {
  late final StreamSubscription _authSub;

  RouterRefreshListenable({required AuthBloc authBloc}) {
    _authSub = authBloc.stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _authSub.cancel();
    super.dispose();
  }
}

class RouterController {
  static GoRouter createRouter(
    BuildContext context, {
    required AuthBloc authBloc,
  }) {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/',
      refreshListenable: RouterRefreshListenable(authBloc: authBloc),
      redirect: (context, state) {
        final auth = authBloc.state;
        final currentPath = state.matchedLocation;

        // Still resolving — stay on splash
        if (auth is AuthStateInitial || auth is AuthStateLoading) {
          return currentPath == '/' ? null : '/';
        }

        final isLoggedIn = auth.isAuthenticated;
        final atAuth = currentPath.startsWith(RouterManager.baseAuth);
        final atSplash = currentPath == '/';

        if (!isLoggedIn && !atAuth) return RouterManager.baseAuth;
        if (isLoggedIn && (atAuth || atSplash)) {
          return '${RouterManager.baseHome}/matches';
        }
        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          name: AppRoute.splash.name,
          pageBuilder: (context, state) => PageTransitions.fadeTransition(
            child: const SplashPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: '/auth',
          name: AppRoute.auth.name,
          pageBuilder: (context, state) => PageTransitions.fadeTransition(
            child: const SignInPage(),
            state: state,
          ),
          routes: [
            GoRoute(
              path: 'sign-up',
              name: AppRoute.signUp.name,
              pageBuilder: (context, state) =>
                  PageTransitions.platformTransition(
                child: const SignUpPage(),
                state: state,
              ),
            ),
            GoRoute(
              path: 'forgot-password',
              name: AppRoute.forgotPassword.name,
              pageBuilder: (context, state) =>
                  PageTransitions.platformTransition(
                child: const ForgotPasswordPage(),
                state: state,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/connection-error',
          name: AppRoute.connectionError.name,
          pageBuilder: (context, state) => PageTransitions.fadeTransition(
            child: const ConnectionErrorPage(),
            state: state,
          ),
        ),
        // /home redirects to /home/matches
        GoRoute(
          path: RouterManager.baseHome,
          redirect: (ctx, st) => '${RouterManager.baseHome}/matches',
        ),
        // Shell with bottom navigation
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          pageBuilder: (context, state, child) {
            return PageTransitions.fadeTransition(
              child: MainShell(child: child),
              state: state,
            );
          },
          routes: [
            GoRoute(
              path: '${RouterManager.baseHome}/matches',
              name: AppRoute.matches.name,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const MatchesPage(),
              ),
              routes: [
                GoRoute(
                  path: ':id',
                  name: AppRoute.matchDetail.name,
                  pageBuilder: (context, state) =>
                      PageTransitions.platformTransition(
                    child: MatchDetailPage(
                      matchId: state.pathParameters['id'],
                    ),
                    state: state,
                  ),
                ),
              ],
            ),
            GoRoute(
              path: '${RouterManager.baseHome}/predictions',
              name: AppRoute.predictions.name,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const PredictionsPage(),
              ),
            ),
            GoRoute(
              path: '${RouterManager.baseHome}/follows',
              name: AppRoute.follows.name,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const FollowsPage(),
              ),
            ),
            GoRoute(
              path: '${RouterManager.baseHome}/profile',
              name: AppRoute.profile.name,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ProfilePage(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

