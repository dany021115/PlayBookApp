import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playbook/app/bloc/auth/auth_bloc.dart';
import 'package:playbook/app/router.dart';
import 'package:playbook/app/shared/widgets/app_button.dart';
import 'package:playbook/app/shared/widgets/app_logo.dart';
import 'package:playbook/app/shared/widgets/app_text_field.dart';
import 'package:playbook/app/shared/widgets/auth_marketing_pane.dart';
import 'package:playbook/device/helpers/app_toast.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/spacing.dart';
import 'package:playbook/device/theme/typography.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Mirrors Pencil:
///   - mobile  → `EKCP7 / 6.1 Splash / Splash - Mobile (zj3Wg)`
///   - desktop → `EKCP7 / 6.1 Splash / Splash - Desktop (eAyk5)` (split-pane)
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtl = TextEditingController();
  final _passCtl = TextEditingController();
  bool _passVisible = false;

  @override
  void dispose() {
    _emailCtl.dispose();
    _passCtl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(AuthEvent.loggedInWithPassword(
          username: _emailCtl.text.trim(),
          password: _passCtl.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop ||
        ResponsiveBreakpoints.of(context).largerThan(DESKTOP);
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (p, n) => n is AuthStateError,
      listener: (context, state) {
        if (state is AuthStateError) {
          AppToast.error(context, state.error.displayMessage);
        }
      },
      builder: (context, state) {
        final loading = state is AuthStateLoading;
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: isDesktop
                  ? _DesktopSplit(
                      form: _FormColumn(
                        loading: loading,
                        emailCtl: _emailCtl,
                        passCtl: _passCtl,
                        passVisible: _passVisible,
                        onTogglePass: () =>
                            setState(() => _passVisible = !_passVisible),
                        onSubmit: _submit,
                      ),
                    )
                  : _MobileLayout(
                      loading: loading,
                      emailCtl: _emailCtl,
                      passCtl: _passCtl,
                      passVisible: _passVisible,
                      onTogglePass: () =>
                          setState(() => _passVisible = !_passVisible),
                      onSubmit: _submit,
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _DesktopSplit extends StatelessWidget {
  final Widget form;
  const _DesktopSplit({required this.form});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: AuthMarketingPane.signIn()),
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s32, vertical: AppSpacing.s48),
                child: form,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final bool loading;
  final TextEditingController emailCtl;
  final TextEditingController passCtl;
  final bool passVisible;
  final VoidCallback onTogglePass;
  final VoidCallback onSubmit;

  const _MobileLayout({
    required this.loading,
    required this.emailCtl,
    required this.passCtl,
    required this.passVisible,
    required this.onTogglePass,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // Hero — gradient surface→canvas, brand centered
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.s24, 40, AppSpacing.s24, AppSpacing.s32),
          decoration: const BoxDecoration(
            gradient: AppColor.heroDarkGradient,
          ),
          child: const Column(
            children: [
              AppLogo(iconSize: 64, fontSize: 24),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.s24, AppSpacing.s16, AppSpacing.s24, 0),
          child: _FormColumn(
            loading: loading,
            emailCtl: emailCtl,
            passCtl: passCtl,
            passVisible: passVisible,
            onTogglePass: onTogglePass,
            onSubmit: onSubmit,
          ),
        ),
        const SizedBox(height: AppSpacing.s24),
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.s24, AppSpacing.s16,
              AppSpacing.s24, AppSpacing.s32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('¿No tienes cuenta?', style: styles.authFootPrompt),
              const SizedBox(width: 6),
              InkWell(
                onTap: loading
                    ? null
                    : () => context.goNamed(AppRoute.signUp.name),
                child: Text('Crear cuenta', style: styles.authFootLink),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FormColumn extends StatelessWidget {
  final bool loading;
  final TextEditingController emailCtl;
  final TextEditingController passCtl;
  final bool passVisible;
  final VoidCallback onTogglePass;
  final VoidCallback onSubmit;

  const _FormColumn({
    required this.loading,
    required this.emailCtl,
    required this.passCtl,
    required this.passVisible,
    required this.onTogglePass,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop ||
        ResponsiveBreakpoints.of(context).largerThan(DESKTOP);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Iniciar sesión',
          style: isDesktop
              ? styles.authTitle?.copyWith(fontSize: 36, letterSpacing: -0.8)
              : styles.authTitle,
        ),
        if (isDesktop) ...[
          const SizedBox(height: AppSpacing.s4),
          Text('Bienvenido de vuelta', style: styles.authSubtitle),
        ],
        const SizedBox(height: AppSpacing.s16),
        AppTextField(
          label: 'Email',
          hint: 'tu@email.com',
          controller: emailCtl,
          enabled: !loading,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [
            AutofillHints.email,
            AutofillHints.username,
          ],
          textInputAction: TextInputAction.next,
          validator: (v) {
            final value = (v ?? '').trim();
            if (value.isEmpty) return 'Requerido';
            if (!value.contains('@')) return 'Email inválido';
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.s12),
        AppTextField(
          label: 'Contraseña',
          hint: '••••••••',
          controller: passCtl,
          enabled: !loading,
          obscureText: !passVisible,
          prefixIcon: Icons.lock_outline,
          suffix: IconButton(
            icon: Icon(
              passVisible
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 18,
            ),
            onPressed: loading ? null : onTogglePass,
          ),
          autofillHints: const [AutofillHints.password],
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => onSubmit(),
          validator: (v) =>
              (v == null || v.length < 6) ? 'Mínimo 6 caracteres' : null,
        ),
        const SizedBox(height: AppSpacing.s8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: loading
                ? null
                : () => context.pushNamed(AppRoute.forgotPassword.name),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 32),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text('¿Olvidaste tu contraseña?', style: styles.authLink),
          ),
        ),
        const SizedBox(height: AppSpacing.s16),
        AppButton.primary(
          label: 'Entrar',
          loading: loading,
          onPressed: loading ? null : onSubmit,
        ),
        const SizedBox(height: AppSpacing.s16),
        const _Divider(),
        const SizedBox(height: AppSpacing.s16),
        AppButton.outlined(
          label: 'Continuar con Google',
          leadingIcon: Icons.g_mobiledata,
          tall: true,
          onPressed: loading
              ? null
              : () => context
                  .read<AuthBloc>()
                  .add(const AuthEvent.loggedInWithGoogle()),
        ),
        if (isDesktop) ...[
          const SizedBox(height: AppSpacing.s24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('¿No tienes cuenta?', style: styles.authFootPrompt),
              const SizedBox(width: 6),
              InkWell(
                onTap: loading
                    ? null
                    : () => context.goNamed(AppRoute.signUp.name),
                child: Text('Crear cuenta', style: styles.authFootLink),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(child: Divider(color: colors.outline.withValues(alpha: 0.6))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
          child: Text('o continúa con',
              style: styles.caption?.copyWith(color: colors.onSurfaceVariant)),
        ),
        Expanded(child: Divider(color: colors.outline.withValues(alpha: 0.6))),
      ],
    );
  }
}
