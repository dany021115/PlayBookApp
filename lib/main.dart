import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playbook/app/bloc/auth/auth_bloc.dart';
import 'package:playbook/app/router.dart';
import 'package:playbook/app/shared/widgets/auth_session_listener.dart';
import 'package:playbook/device/theme/theme.dart';
import 'package:playbook/di.dart';
import 'package:playbook/env.dart';
import 'package:playbook/phoenix.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  if (Env.sentryDsn.isNotEmpty) {
    SentryWidgetsFlutterBinding.ensureInitialized();
    await SentryFlutter.init(
      (options) {
        options.dsn = Env.sentryDsn;
        options.environment = kReleaseMode ? 'production' : 'development';
        options.tracesSampleRate = kReleaseMode ? 0.2 : 1.0;
        options.attachScreenshot = true;
        options.sendDefaultPii = false;
      },
      appRunner: _bootstrap,
    );
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await _bootstrap();
  }
}

Future<void> _bootstrap() async {
  await configureDependencies();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  final app = Phoenix(
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthBloc>()..add(const AuthEvent.bootstrap()),
        ),
      ],
      child: const PlayBookApp(),
    ),
  );

  runApp(Env.sentryDsn.isNotEmpty ? SentryWidget(child: app) : app);
}

class PlayBookApp extends StatefulWidget {
  const PlayBookApp({super.key});

  @override
  State<PlayBookApp> createState() => _PlayBookAppState();
}

class _PlayBookAppState extends State<PlayBookApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = RouterController.createRouter(
      context,
      authBloc: context.read<AuthBloc>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: wire ThemeBloc when we add theme switching. For now: dark mode.
    const themeMode = ThemeMode.dark;
    final isDark = themeMode == ThemeMode.dark;
    return ToastificationWrapper(
      child: AuthSessionListener(
        child: MaterialApp.router(
          builder: (ctx, child) => AnnotatedRegion<SystemUiOverlayStyle>(
            value: isDark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            child: ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: const [
                Breakpoint(start: 0, end: 450, name: MOBILE),
                Breakpoint(start: 451, end: 800, name: TABLET),
                Breakpoint(start: 801, end: 1920, name: DESKTOP),
                Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ),
          ),
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: AppTheme.getLightTheme(),
          darkTheme: AppTheme.getDarkTheme(),
          routerConfig: _router,
        ),
      ),
    );
  }
}
