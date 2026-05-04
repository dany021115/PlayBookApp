import 'package:flutter/material.dart';
import 'package:playbook/device/theme/color.dart';

/// Section header with a leading widget (icon/dot) + title + optional
/// "Ver todos →" trailing link.
///
/// Mirrors Pencil pattern used in `liveHdr`, `upHdr`, etc.
class SectionHeader extends StatelessWidget {
  final Widget leading;
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final EdgeInsetsGeometry padding;

  const SectionHeader({
    super.key,
    required this.leading,
    required this.title,
    this.actionLabel = 'Ver todos →',
    this.onAction,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              leading,
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionLabel!,
                style: const TextStyle(
                  color: AppColor.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
