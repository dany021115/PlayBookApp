import 'package:flutter/material.dart';

/// 40×40 circular button with surface bg + centered icon.
///
/// Used in headers across home / profile / detail screens.
/// Mirrors Pencil header buttons (e.g. `mlSearch` / `mlBell` in `xN5ee`).
class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;
  final String? semanticLabel;

  const CircleIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 40,
    this.iconSize = 18,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: semanticLabel,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size / 2),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            // Pencil header buttons (mlSearch/mlBell) = `$bg/surface`,
            // which maps to `colors.surfaceContainer` in this theme.
            color: colors.surfaceContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: iconSize, color: colors.onSurface),
        ),
      ),
    );
  }
}
