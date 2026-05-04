import 'package:flutter/material.dart';
import 'package:playbook/device/theme/color.dart';

/// Generic pill chip used in filter rows.
///
/// Mirrors Pencil `Component/Chip/Selected` (U9HNB) and
/// `Component/Chip/Unselected` (1fk2g).
class PillChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback? onTap;
  final Widget? leading;

  /// Background colour when [active]. Defaults to `AppColor.primary`.
  final Color? activeColor;

  /// Foreground/text colour when [active]. Defaults to white.
  final Color? activeForeground;

  const PillChip({
    super.key,
    required this.label,
    required this.active,
    this.onTap,
    this.leading,
    this.activeColor,
    this.activeForeground,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    // Inactive chip fill = `$bg/surface` per Pencil chipTomorrow/chipTop.
    final bg =
        active ? (activeColor ?? AppColor.primary) : colors.surfaceContainer;
    final fg = active
        ? (activeForeground ?? AppColor.onPrimary)
        : colors.onSurfaceVariant;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: fg,
                fontSize: 12,
                fontWeight: active ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
