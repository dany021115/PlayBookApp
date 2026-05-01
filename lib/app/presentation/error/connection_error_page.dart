import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playbook/app/bloc/auth/auth_bloc.dart';
import 'package:playbook/device/theme/spacing.dart';
import 'package:playbook/device/theme/typography.dart';

class ConnectionErrorPage extends StatelessWidget {
  const ConnectionErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cloud_off, size: 72, color: colors.error),
                const SizedBox(height: AppSpacing.lg),
                Text('Sin conexión', style: styles.sectionTitle),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'No se pudo contactar al servidor. Verifica tu conexión e inténtalo de nuevo.',
                  textAlign: TextAlign.center,
                  style: styles.bodyText,
                ),
                const SizedBox(height: AppSpacing.xxl),
                FilledButton.icon(
                  onPressed: () => context
                      .read<AuthBloc>()
                      .add(const AuthEvent.bootstrap()),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
