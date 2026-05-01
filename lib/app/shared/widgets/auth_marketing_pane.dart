import 'package:flutter/material.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/radius.dart';
import 'package:playbook/device/theme/spacing.dart';
import 'package:playbook/device/theme/typography.dart';

class AuthMarketingPane extends StatelessWidget {
  final String title;
  final String description;
  final List<String>? features;
  final Widget? footer;

  const AuthMarketingPane({
    super.key,
    required this.title,
    required this.description,
    this.features,
    this.footer,
  });

  factory AuthMarketingPane.signIn() => const AuthMarketingPane(
        title: 'Picks deportivos con IA',
        description:
            'Recibe predicciones automáticas con cuotas en vivo, '
            'explicación natural y trazabilidad por estrategia. '
            'Sin apostar, solo análisis profesional.',
        features: [
          'Cuotas live + pre-match de 5 casas',
          'Explicación con IA + métricas reales',
          'Notificaciones de picks calientes',
          'Hit-rate y ROI por estrategia',
        ],
      );

  factory AuthMarketingPane.signUp() => AuthMarketingPane(
        title: 'Empieza gratis hoy',
        description:
            'Sin tarjeta de crédito · Cancela cuando quieras · '
            '3 picks gratis al día.',
        footer: const _TestimonialCard(
          quote: '"En 3 meses subí 15% mi acierto siguiendo los '
              'Value Bets de PlayBook."',
          author: 'Carlos M.',
          meta: 'Madrid · Suscriptor 8 meses',
        ),
      );

  factory AuthMarketingPane.forgot() => AuthMarketingPane(
        title: 'Recupera tu acceso',
        description:
            'Te enviaremos un enlace seguro a tu correo para que vuelvas '
            'a entrar en segundos.',
        footer: const _SecurityBadge(
          text: 'Enlace válido 30 minutos · Encriptación end-to-end',
        ),
      );

  factory AuthMarketingPane.forgotSuccess() => AuthMarketingPane(
        title: 'Enlace en camino',
        description:
            'Revisa tu correo y haz clic en el enlace para crear una '
            'nueva contraseña.',
        footer: const _SecurityBadge(
          text: 'El enlace expira en 30 minutos por tu seguridad.',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColor.primaryGradient),
      padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _BrandRow(),
          const SizedBox(height: AppSpacing.s32),
          Text(
            title,
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              color: AppColor.onPrimary,
              fontSize: 56,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.6,
              height: 1.05,
            ),
          ),
          const SizedBox(height: AppSpacing.s16),
          Text(
            description,
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              color: AppColor.onPrimary.withValues(alpha: 0.8),
              fontSize: 17,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          if (features != null) ...[
            const SizedBox(height: AppSpacing.s32),
            for (int i = 0; i < features!.length; i++) ...[
              if (i != 0) const SizedBox(height: 14),
              _FeatureRow(text: features![i]),
            ],
          ],
          if (footer != null) ...[
            const SizedBox(height: AppSpacing.s32),
            footer!,
          ],
        ],
      ),
    );
  }
}

class _BrandRow extends StatelessWidget {
  const _BrandRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: AppRadius.cardBorder,
          child: Image.asset(
            'assets/images/logo.png',
            width: 64,
            height: 64,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            semanticLabel: 'PlayBook',
          ),
        ),
        const SizedBox(width: 14),
        Text(
          'PlayBook',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            color: AppColor.onPrimary,
            fontSize: 34,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
        ),
      ],
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String text;
  const _FeatureRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check, color: AppColor.onPrimary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              color: AppColor.onPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String quote;
  final String author;
  final String meta;
  const _TestimonialCard({
    required this.quote,
    required this.author,
    required this.meta,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.s24),
      decoration: BoxDecoration(
        color: AppColor.onPrimary.withValues(alpha: 0.08),
        borderRadius: AppRadius.sheetBorder,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quote,
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              color: AppColor.onPrimary,
              fontSize: 17,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColor.onPrimary.withValues(alpha: 0.27),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    author,
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      color: AppColor.onPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    meta,
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      color: AppColor.onPrimary.withValues(alpha: 0.67),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Pencil `testimonial` (FP0kQ / ytqIX) — translucent badge with shield-check
/// icon + bold copy. Reused across forgot password panes.
class _SecurityBadge extends StatelessWidget {
  final String text;
  const _SecurityBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.s24),
      decoration: BoxDecoration(
        color: AppColor.onPrimary.withValues(alpha: 0.08),
        borderRadius: AppRadius.sheetBorder,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.verified_user_outlined,
              color: AppColor.onPrimary, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                color: AppColor.onPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
