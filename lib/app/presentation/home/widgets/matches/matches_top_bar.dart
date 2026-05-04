import 'package:flutter/material.dart';
import 'package:playbook/app/shared/widgets/circle_icon_button.dart';
import 'package:playbook/device/theme/spacing.dart';
import 'package:playbook/device/theme/typography.dart';

/// Header for the Partidos screen.
///
/// Visual mode is driven by [compact]:
///   * `true`  — Pencil `mlHeader` (mobile + tablet): greeting + title left,
///     2 circle icon buttons right.
///   * `false` — Pencil `gtE9B` (desktop): bigger title, full search input
///     on the right.
class MatchesTopBar extends StatelessWidget {
  final String greeting;
  final String title;
  final bool compact;
  final VoidCallback? onSearch;
  final VoidCallback? onNotifications;

  const MatchesTopBar({
    super.key,
    required this.greeting,
    required this.title,
    required this.compact,
    this.onSearch,
    this.onNotifications,
  });

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        compact ? AppSpacing.s24 : AppSpacing.s32,
        compact ? AppSpacing.s16 : AppSpacing.s24,
        compact ? AppSpacing.s24 : AppSpacing.s32,
        AppSpacing.s16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(greeting,
                    overflow: TextOverflow.ellipsis,
                    style: styles.authSubtitle),
                const SizedBox(height: 2),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: compact
                      ? styles.authTitle
                      : styles.authTitle?.copyWith(fontSize: 28),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.s12),
          if (compact)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleIconButton(
                    icon: Icons.search,
                    onTap: onSearch,
                    semanticLabel: 'Buscar'),
                const SizedBox(width: 8),
                CircleIconButton(
                  icon: Icons.notifications_outlined,
                  onTap: onNotifications,
                  semanticLabel: 'Notificaciones',
                ),
              ],
            )
          else
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar partido o equipo',
                    hintStyle: styles.formHint,
                    prefixIcon:
                        Icon(Icons.search, color: colors.onSurfaceVariant),
                    filled: true,
                    fillColor: colors.surfaceContainer,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9999),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
