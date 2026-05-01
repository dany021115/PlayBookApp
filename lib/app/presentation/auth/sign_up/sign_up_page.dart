import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playbook/app/bloc/auth/auth_bloc.dart';
import 'package:playbook/app/router.dart';
import 'package:playbook/app/shared/widgets/app_button.dart';
import 'package:playbook/app/shared/widgets/app_text_field.dart';
import 'package:playbook/app/shared/widgets/auth_marketing_pane.dart';
import 'package:playbook/device/helpers/app_toast.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/radius.dart';
import 'package:playbook/device/theme/spacing.dart';
import 'package:playbook/device/theme/typography.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Mirrors Pencil:
///   - mobile  → `EKCP7 / 6.2 Login / Login - Mobile (Ww7Da)`
///   - desktop → `EKCP7 / 6.2 Login / Login - Desktop (x05yU)` (split-pane)
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _userCtl = TextEditingController();
  final _emailCtl = TextEditingController();
  final _passCtl = TextEditingController();
  final _firstNameCtl = TextEditingController();
  final _lastNameCtl = TextEditingController();
  bool _passVisible = false;
  bool _termsAccepted = false;

  @override
  void dispose() {
    _userCtl.dispose();
    _emailCtl.dispose();
    _passCtl.dispose();
    _firstNameCtl.dispose();
    _lastNameCtl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (!_termsAccepted) {
      AppToast.warning(context, 'Debes aceptar los términos y condiciones');
      return;
    }
    context.read<AuthBloc>().add(AuthEvent.registered(
          username: _userCtl.text.trim(),
          email: _emailCtl.text.trim(),
          password: _passCtl.text,
          firstName: _firstNameCtl.text.trim(),
          lastName: _lastNameCtl.text.trim(),
        ));
  }

  int _passwordStrength(String value) {
    if (value.length < 6) return 0;
    int score = 0;
    if (value.length >= 8) score++;
    if (RegExp(r'[A-Z]').hasMatch(value) &&
        RegExp(r'[a-z]').hasMatch(value)) {
      score++;
    }
    if (RegExp(r'[0-9]').hasMatch(value)) score++;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(value)) score++;
    return score.clamp(0, 3);
  }

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop ||
        ResponsiveBreakpoints.of(context).largerThan(DESKTOP);

    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (p, n) =>
          n is AuthStateError || n is AuthStateAuthenticated,
      listener: (context, state) {
        if (state is AuthStateError) {
          AppToast.error(context, state.error.displayMessage);
        } else if (state is AuthStateAuthenticated) {
          AppToast.success(context, '¡Cuenta creada! Bienvenido.');
        }
      },
      builder: (context, state) {
        final loading = state is AuthStateLoading;
        final form = _FormColumn(
          loading: loading,
          isDesktop: isDesktop,
          userCtl: _userCtl,
          emailCtl: _emailCtl,
          passCtl: _passCtl,
          firstNameCtl: _firstNameCtl,
          lastNameCtl: _lastNameCtl,
          passVisible: _passVisible,
          termsAccepted: _termsAccepted,
          passwordScore: _passwordStrength(_passCtl.text),
          onTogglePass: () => setState(() => _passVisible = !_passVisible),
          onTogglePassObserver: () => setState(() {}),
          onTermsChanged: (v) => setState(() => _termsAccepted = v ?? false),
          onSubmit: _submit,
        );

        if (isDesktop) {
          return Scaffold(
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(child: AuthMarketingPane.signUp()),
                    Expanded(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 460),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.s32,
                                vertical: AppSpacing.s48),
                            child: form,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Crear cuenta',
              style: styles.cardTitle
                  ?.copyWith(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
          body: SafeArea(
            top: false,
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.s24, AppSpacing.s8, AppSpacing.s24, 0),
                children: [
                  Text('Únete a PlayBook',
                      style: styles.authTitle?.copyWith(fontSize: 24)),
                  const SizedBox(height: 6),
                  Text(
                    'Crea tu cuenta para recibir picks personalizados',
                    style: styles.authSubtitle,
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  form,
                  const SizedBox(height: AppSpacing.s24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('¿Ya tienes cuenta?',
                          style: styles.authFootPrompt),
                      const SizedBox(width: 6),
                      InkWell(
                        onTap: loading
                            ? null
                            : () => context.goNamed(AppRoute.auth.name),
                        child: Text('Iniciar sesión',
                            style: styles.authFootLink),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FormColumn extends StatelessWidget {
  final bool loading;
  final bool isDesktop;
  final TextEditingController userCtl;
  final TextEditingController emailCtl;
  final TextEditingController passCtl;
  final TextEditingController firstNameCtl;
  final TextEditingController lastNameCtl;
  final bool passVisible;
  final bool termsAccepted;
  final int passwordScore;
  final VoidCallback onTogglePass;
  final VoidCallback onTogglePassObserver;
  final ValueChanged<bool?> onTermsChanged;
  final VoidCallback onSubmit;

  const _FormColumn({
    required this.loading,
    required this.isDesktop,
    required this.userCtl,
    required this.emailCtl,
    required this.passCtl,
    required this.firstNameCtl,
    required this.lastNameCtl,
    required this.passVisible,
    required this.termsAccepted,
    required this.passwordScore,
    required this.onTogglePass,
    required this.onTogglePassObserver,
    required this.onTermsChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isDesktop) ...[
          Text(
            'Crear cuenta',
            style:
                styles.authTitle?.copyWith(fontSize: 36, letterSpacing: -0.8),
          ),
          const SizedBox(height: AppSpacing.s4),
          Text('Solo unos datos para arrancar', style: styles.authSubtitle),
          const SizedBox(height: AppSpacing.s24),
        ],
        AppTextField(
          label: 'Usuario',
          hint: 'tu_usuario',
          controller: userCtl,
          enabled: !loading,
          prefixIcon: Icons.person_outline,
          textInputAction: TextInputAction.next,
          validator: (v) => (v == null || v.trim().length < 3)
              ? 'Mínimo 3 caracteres'
              : null,
        ),
        const SizedBox(height: AppSpacing.s12),
        AppTextField(
          label: 'Email',
          hint: 'tu@email.com',
          controller: emailCtl,
          enabled: !loading,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
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
          hint: 'Mínimo 8 caracteres',
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
          autofillHints: const [AutofillHints.newPassword],
          onChanged: (_) => onTogglePassObserver(),
          validator: (v) =>
              (v == null || v.length < 8) ? 'Mínimo 8 caracteres' : null,
        ),
        const SizedBox(height: AppSpacing.s8),
        _PasswordStrength(score: passwordScore),
        const SizedBox(height: AppSpacing.s12),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                label: 'Nombre',
                hint: 'Opcional',
                controller: firstNameCtl,
                enabled: !loading,
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(width: AppSpacing.s12),
            Expanded(
              child: AppTextField(
                label: 'Apellido',
                hint: 'Opcional',
                controller: lastNameCtl,
                enabled: !loading,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s12),
        _TermsCheckbox(
          accepted: termsAccepted,
          onChanged: loading ? null : onTermsChanged,
        ),
        const SizedBox(height: AppSpacing.s16),
        AppButton.primary(
          label: 'Crear cuenta',
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
              Text('¿Ya tienes cuenta?', style: styles.authFootPrompt),
              const SizedBox(width: 6),
              InkWell(
                onTap: loading
                    ? null
                    : () => context.goNamed(AppRoute.auth.name),
                child: Text('Iniciar sesión', style: styles.authFootLink),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _PasswordStrength extends StatelessWidget {
  final int score; // 0..3
  const _PasswordStrength({required this.score});

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    final colors = Theme.of(context).colorScheme;
    final strengthColors = [
      AppColor.danger,
      AppColor.warning,
      AppColor.success,
    ];
    final labels = ['Débil', 'Regular', 'Fuerte'];
    return Row(
      children: [
        for (int i = 0; i < 3; i++) ...[
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: i < score ? strengthColors[score - 1] : colors.outline,
                borderRadius: AppRadius.smallBorder,
              ),
            ),
          ),
          if (i < 2) const SizedBox(width: 4),
        ],
        const SizedBox(width: AppSpacing.s8),
        SizedBox(
          width: 56,
          child: Text(
            score == 0 ? '—' : labels[score - 1],
            textAlign: TextAlign.right,
            style: styles.caption?.copyWith(
              color: score == 0
                  ? colors.onSurfaceVariant
                  : strengthColors[score - 1],
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _TermsCheckbox extends StatelessWidget {
  final bool accepted;
  final ValueChanged<bool?>? onChanged;

  const _TermsCheckbox({required this.accepted, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    return InkWell(
      onTap: onChanged == null ? null : () => onChanged!(!accepted),
      borderRadius: AppRadius.smallBorder,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox.adaptive(
                value: accepted,
                onChanged: onChanged,
                activeColor: AppColor.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.s8),
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: styles.bodySecondary,
                  children: [
                    const TextSpan(text: 'Acepto los '),
                    TextSpan(
                      text: 'Términos',
                      style: styles.authFootLink?.copyWith(fontSize: 13),
                    ),
                    const TextSpan(text: ' y la '),
                    TextSpan(
                      text: 'Política de Privacidad',
                      style: styles.authFootLink?.copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
