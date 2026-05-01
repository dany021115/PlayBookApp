import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playbook/app/router.dart';
import 'package:playbook/app/shared/widgets/app_button.dart';
import 'package:playbook/app/shared/widgets/app_text_field.dart';
import 'package:playbook/app/shared/widgets/auth_marketing_pane.dart';
import 'package:playbook/device/helpers/app_toast.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/radius.dart';
import 'package:playbook/device/theme/spacing.dart';
import 'package:playbook/device/theme/typography.dart';
import 'package:playbook/di.dart';
import 'package:playbook/domain/repository/i_auth_repository.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Mirrors Pencil:
///   - request mobile  → `EKCP7 / 6.4 Olvidé / Forgot Password - Mobile (uHoZh)`
///   - success mobile  → `EKCP7 / 6.4 Olvidé / Forgot Password - Success (b7uP9)`
///   - request desktop → `EKCP7 / 6.4 Olvidé / Forgot Password - Desktop (m5IqD)`
///   - success desktop → `EKCP7 / 6.4 Olvidé / Forgot Password Success - Desktop (XlaOv)`
///
/// Submits to `POST /api/v1/auth/password_reset/` (django_rest_passwordreset).
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtl = TextEditingController();
  final _repo = getIt<IAuthRepository>();
  bool _submitting = false;
  bool _sent = false;
  String _sentEmail = '';

  @override
  void dispose() {
    _emailCtl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailCtl.text.trim();
    setState(() => _submitting = true);
    final result = await _repo.requestPasswordReset(email: email);
    if (!mounted) return;
    setState(() => _submitting = false);
    result.fold(
      (e) => AppToast.error(context, e.displayMessage),
      (_) => setState(() {
        _sent = true;
        _sentEmail = email;
      }),
    );
  }

  Future<void> _resend() async {
    setState(() => _submitting = true);
    final result = await _repo.requestPasswordReset(email: _sentEmail);
    if (!mounted) return;
    setState(() => _submitting = false);
    result.fold(
      (e) => AppToast.error(context, e.displayMessage),
      (_) => AppToast.success(context, 'Enlace reenviado a $_sentEmail'),
    );
  }

  void _changeEmail() {
    setState(() {
      _sent = false;
      _sentEmail = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop ||
        ResponsiveBreakpoints.of(context).largerThan(DESKTOP);
    final styles = AppTextStyle(context);

    final body = _sent
        ? _SuccessBody(
            email: _sentEmail,
            isDesktop: isDesktop,
            submitting: _submitting,
            onOpenMail: () =>
                AppToast.info(context, 'Abriendo cliente de correo…'),
            onResend: _resend,
            onChangeEmail: _changeEmail,
          )
        : _RequestBody(
            formKey: _formKey,
            emailCtl: _emailCtl,
            isDesktop: isDesktop,
            submitting: _submitting,
            onSubmit: _submit,
          );

    if (isDesktop) {
      return Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: _sent
                    ? AuthMarketingPane.forgotSuccess()
                    : AuthMarketingPane.forgot(),
              ),
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 460),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s32,
                          vertical: AppSpacing.s48),
                      child: body,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => _sent ? _changeEmail() : context.pop(),
        ),
        title: Text(
          _sent ? 'Enlace enviado' : 'Recuperar contraseña',
          style: styles.cardTitle
              ?.copyWith(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.s24, AppSpacing.s8, AppSpacing.s24, AppSpacing.s24),
          child: body,
        ),
      ),
    );
  }
}

class _RequestBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtl;
  final bool isDesktop;
  final bool submitting;
  final VoidCallback onSubmit;

  const _RequestBody({
    required this.formKey,
    required this.emailCtl,
    required this.isDesktop,
    required this.submitting,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isDesktop) ...[
            _HeroBadge(
              icon: Icons.vpn_key_outlined,
              color: AppColor.primary,
            ),
            const SizedBox(height: AppSpacing.s16),
          ],
          Text(
            isDesktop ? 'Recuperar contraseña' : '¿Olvidaste tu contraseña?',
            style: isDesktop
                ? styles.authTitle
                    ?.copyWith(fontSize: 36, letterSpacing: -0.8)
                : styles.authTitle,
          ),
          const SizedBox(height: AppSpacing.s4),
          Text(
            isDesktop
                ? 'Ingresa tu correo y te enviaremos un enlace'
                : 'Ingresa tu correo y te enviaremos un enlace para '
                    'restablecer tu contraseña.',
            style: styles.authSubtitle,
          ),
          const SizedBox(height: AppSpacing.s24),
          AppTextField(
            label: 'Correo electrónico',
            hint: 'tu@email.com',
            controller: emailCtl,
            enabled: !submitting,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => onSubmit(),
            validator: (v) {
              final value = (v ?? '').trim();
              if (value.isEmpty) return 'Requerido';
              if (!value.contains('@')) return 'Email inválido';
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.s16),
          AppButton.primary(
            label: 'Enviar enlace',
            loading: submitting,
            onPressed: submitting ? null : onSubmit,
          ),
          const SizedBox(height: AppSpacing.s16),
          const _InfoCard(
            text:
                'Revisa tu carpeta de spam si no ves el correo en unos minutos.',
          ),
          const SizedBox(height: AppSpacing.s24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('¿Recordaste tu contraseña?', style: styles.authFootPrompt),
              const SizedBox(width: 6),
              InkWell(
                onTap: submitting
                    ? null
                    : () => context.goNamed(AppRoute.auth.name),
                child: Text('Iniciar sesión', style: styles.authFootLink),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SuccessBody extends StatelessWidget {
  final String email;
  final bool isDesktop;
  final bool submitting;
  final VoidCallback onOpenMail;
  final VoidCallback onResend;
  final VoidCallback onChangeEmail;

  const _SuccessBody({
    required this.email,
    required this.isDesktop,
    required this.submitting,
    required this.onOpenMail,
    required this.onResend,
    required this.onChangeEmail,
  });

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _HeroBadge(
          icon: Icons.mark_email_read_outlined,
          color: AppColor.success,
          size: isDesktop ? 96 : 80,
        ),
        const SizedBox(height: AppSpacing.s16),
        Text(
          'Revisa tu correo',
          style: isDesktop
              ? styles.authTitle?.copyWith(fontSize: 36, letterSpacing: -0.8)
              : styles.authTitle,
        ),
        const SizedBox(height: AppSpacing.s4),
        Text(
          isDesktop
              ? 'Hemos enviado un enlace para restablecer tu contraseña. '
                  'Sigue las instrucciones del correo.'
              : 'Hemos enviado un enlace a $email. Sigue las instrucciones '
                  'para restablecer tu contraseña.',
          style: styles.authSubtitle,
        ),
        const SizedBox(height: AppSpacing.s24),
        _EmailCard(email: email),
        const SizedBox(height: AppSpacing.s16),
        AppButton.primary(
          label: 'Abrir correo',
          leadingIcon: Icons.open_in_new,
          onPressed: submitting ? null : onOpenMail,
        ),
        const SizedBox(height: AppSpacing.s8),
        AppButton.outlined(
          label: 'Reenviar enlace',
          leadingIcon: Icons.refresh,
          loading: submitting,
          tall: true,
          onPressed: submitting ? null : onResend,
        ),
        const SizedBox(height: AppSpacing.s16),
        const _HelpCard(
          icon: Icons.shield_outlined,
          color: AppColor.success,
          text: 'El enlace expira en 30 minutos por tu seguridad.',
        ),
        const SizedBox(height: AppSpacing.s24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¿No recibiste nada?', style: styles.authFootPrompt),
            const SizedBox(width: 6),
            InkWell(
              onTap: submitting ? null : onChangeEmail,
              child: Text('Cambiar correo', style: styles.authFootLink),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroBadge extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  const _HeroBadge({
    required this.icon,
    required this.color,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: AppRadius.sheetBorder,
        ),
        child: Icon(
          icon,
          color: AppColor.onPrimary,
          size: size * 0.45,
        ),
      ),
    );
  }
}

class _EmailCard extends StatelessWidget {
  final String email;
  const _EmailCard({required this.email});

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: AppRadius.cardBorder,
        border: Border.all(color: colors.outline, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.mail_outline,
                color: AppColor.onPrimary, size: 18),
          ),
          const SizedBox(width: AppSpacing.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ENVIADO A',
                  style: styles.caption?.copyWith(
                    color: colors.onSurfaceVariant.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  email,
                  style: styles.bodyText
                      ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String text;
  const _InfoCard({required this.text});

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: AppRadius.cardBorder,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: AppColor.info, size: 16),
          const SizedBox(width: AppSpacing.s8),
          Expanded(
            child: Text(
              text,
              style: styles.bodySecondary?.copyWith(fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  const _HelpCard({
    required this.icon,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: AppRadius.cardBorder,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: AppSpacing.s8),
          Expanded(
            child: Text(
              text,
              style: styles.bodySecondary?.copyWith(fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
