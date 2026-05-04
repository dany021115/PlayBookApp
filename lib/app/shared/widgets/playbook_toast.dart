import 'package:flutter/material.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/radius.dart';
import 'package:playbook/device/theme/typography.dart';

enum PlaybookToastVariant { success, error, warning, info }

/// Toast card mirroring Pencil `Toast/Success` (9Nduk) / `Toast/Error`
/// (EN6im) / `Toast/Info` (O94pa).
///
/// Visual spec:
///   * Fill `$bg/surface` (slate-900-ish), corner radius 12, padding 14×16
///   * 1px inside border colored to the variant @ ~38% alpha (`#XX..60`)
///   * Outer shadow: blur 12, offset (0,4), `#00000040`
///   * Row: 20px colored icon · column(title 13/600 + optional subtitle
///     11 onSurfaceVariant) · 16px close icon
class PlaybookToast extends StatelessWidget {
  final PlaybookToastVariant variant;
  final String title;
  final String? subtitle;
  final VoidCallback? onClose;

  const PlaybookToast({
    super.key,
    required this.variant,
    required this.title,
    this.subtitle,
    this.onClose,
  });

  Color get _accent {
    switch (variant) {
      case PlaybookToastVariant.success:
        return AppColor.success;
      case PlaybookToastVariant.error:
        return AppColor.danger;
      case PlaybookToastVariant.warning:
        return AppColor.warning;
      case PlaybookToastVariant.info:
        return AppColor.info;
    }
  }

  IconData get _icon {
    switch (variant) {
      case PlaybookToastVariant.success:
        return Icons.check_circle_outline;
      case PlaybookToastVariant.error:
        return Icons.error_outline;
      case PlaybookToastVariant.warning:
        return Icons.warning_amber_outlined;
      case PlaybookToastVariant.info:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      liveRegion: true,
      container: true,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 360),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: colors.surfaceContainer,
          borderRadius: AppRadius.cardBorder,
          border: Border.all(
            color: _accent.withValues(alpha: 0.38),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0x40000000),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(_icon, color: _accent, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: styles.bodyText?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: styles.bodySecondary?.copyWith(
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            if (onClose != null)
              GestureDetector(
                onTap: onClose,
                behavior: HitTestBehavior.opaque,
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: colors.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
