import 'package:flutter/material.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/radius.dart';
import 'package:playbook/device/theme/typography.dart';

enum AppButtonVariant { primary, outlined, text }

/// Mirrors Pencil components:
/// - Component/Button/Primary (UOnDb)
/// - Component/Button/Outlined (Tc8Fj)
/// - Component/Button/Text (XgeBs)
///
/// Auth screens use a **52h pill-12 primary** for the main CTA, so set
/// `tall: true` to get the 52pt height seen in the design.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? leadingIcon;
  final bool loading;
  final bool tall;
  final bool expand;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.leadingIcon,
    this.loading = false,
    this.tall = false,
    this.expand = true,
  });

  const AppButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingIcon,
    this.loading = false,
    this.tall = true,
    this.expand = true,
  }) : variant = AppButtonVariant.primary;

  const AppButton.outlined({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingIcon,
    this.loading = false,
    this.tall = false,
    this.expand = true,
  }) : variant = AppButtonVariant.outlined;

  const AppButton.text({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingIcon,
    this.loading = false,
    this.tall = false,
    this.expand = false,
  }) : variant = AppButtonVariant.text;

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    final isDisabled = onPressed == null || loading;
    final radius = tall ? AppRadius.cardBorder : AppRadius.smallBorder;
    final height = tall ? 52.0 : 44.0;

    Widget content() {
      if (loading) {
        return const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator.adaptive(strokeWidth: 2),
        );
      }
      final color = variant == AppButtonVariant.primary
          ? AppColor.onPrimary
          : AppColor.primary;
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingIcon != null) ...[
            Icon(leadingIcon, size: 18, color: color),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: variant == AppButtonVariant.primary
                ? styles.buttonPrimary
                : styles.buttonSecondary,
          ),
        ],
      );
    }

    final ButtonStyle baseStyle = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(
          Size(expand ? double.infinity : 0, height)),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: radius)),
      padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
    );

    switch (variant) {
      case AppButtonVariant.primary:
        return SizedBox(
          width: expand ? double.infinity : null,
          height: height,
          child: FilledButton(
            onPressed: isDisabled ? null : onPressed,
            style: baseStyle.merge(
              FilledButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: AppColor.onPrimary,
                disabledBackgroundColor:
                    AppColor.primary.withValues(alpha: 0.5),
                disabledForegroundColor:
                    AppColor.onPrimary.withValues(alpha: 0.7),
              ),
            ),
            child: content(),
          ),
        );
      case AppButtonVariant.outlined:
        return SizedBox(
          width: expand ? double.infinity : null,
          height: height,
          child: OutlinedButton(
            onPressed: isDisabled ? null : onPressed,
            style: baseStyle.merge(
              OutlinedButton.styleFrom(
                foregroundColor: AppColor.primary,
                side: const BorderSide(color: AppColor.primary, width: 1.5),
              ),
            ),
            child: content(),
          ),
        );
      case AppButtonVariant.text:
        return TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColor.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: AppRadius.smallBorder),
          ),
          child: content(),
        );
    }
  }
}
