import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playbook/app/router.dart';

class RouterManager {
  static final List<AppRoute> _history = [];
  static final String baseAuth = '/auth';
  static final String baseHome = '/home';

  static void clearHistory() {
    _history.clear();
  }

  static final Map<AppRoute, String Function(Map<String, String>)>
      _routeBuilders = {
    AppRoute.splash: (_) => '/',
    AppRoute.auth: (_) => baseAuth,
    AppRoute.signUp: (_) => '$baseAuth/sign-up',
    AppRoute.forgotPassword: (_) => '$baseAuth/forgot-password',
    AppRoute.welcome: (_) => '/welcome',
    AppRoute.home: (_) => baseHome,
    AppRoute.matches: (_) => '$baseHome/matches',
    AppRoute.predictions: (_) => '$baseHome/predictions',
    AppRoute.follows: (_) => '$baseHome/follows',
    AppRoute.profile: (_) => '$baseHome/profile',
    AppRoute.matchDetail: (p) => '$baseHome/matches/${p['id']}',
    AppRoute.predictionDetail: (p) => '$baseHome/predictions/${p['id']}',
    AppRoute.connectionError: (_) => '/connection-error',
  };

  static AppRoute? getRouteFromPath(String path) {
    for (final entry in _routeBuilders.entries) {
      final expectedPath = entry.value({});
      if (path == expectedPath) {
        return entry.key;
      }
    }
    return null;
  }

  static void go(AppRoute route,
      {Map<String, String> params = const {}, BuildContext? context}) {
    final ctx = context ?? rootNavigatorKey.currentContext;
    final pathBuilder = _routeBuilders[route];
    if (ctx == null || pathBuilder == null) return;

    final path = pathBuilder(params);
    ctx.go(path);
  }

  static void push(AppRoute route,
      {Map<String, String> params = const {}, BuildContext? context}) {
    final ctx = context ?? rootNavigatorKey.currentContext;
    final pathBuilder = _routeBuilders[route];
    if (ctx == null || pathBuilder == null) return;
    final path = pathBuilder(params);
    ctx.push(path);
  }

  static AppRoute? get previousRoute =>
      _history.length > 1 ? _history[_history.length - 2] : null;

  static AppRoute? get currentRoute => _history.isNotEmpty ? _history.last : null;

  static List<AppRoute> get fullHistory => _history;

  static void pushRoute(AppRoute route) => _history.add(route);
}
