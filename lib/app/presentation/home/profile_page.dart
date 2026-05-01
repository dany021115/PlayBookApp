import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playbook/app/bloc/auth/auth_bloc.dart';
import 'package:playbook/device/theme/spacing.dart';
import 'package:playbook/device/theme/typography.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state is AuthStateAuthenticated ? state.user : null;
        final name = (user?.firstName.isNotEmpty ?? false)
            ? user!.firstName
            : (user?.username ?? 'Usuario');
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () =>
                    context.read<AuthBloc>().add(const AuthEvent.loggedOut()),
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hola, $name', style: styles.sectionTitle),
                  const SizedBox(height: AppSpacing.sm),
                  Text(user?.email ?? '', style: styles.bodySecondary),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
