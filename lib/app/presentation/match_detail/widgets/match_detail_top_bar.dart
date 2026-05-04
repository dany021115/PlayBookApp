import 'package:flutter/material.dart';
import 'package:playbook/device/theme/color.dart';

/// Top bar of the detail hero: back button + league text + bookmark save.
///
/// Mirrors Pencil `mdTop`.
class MatchDetailTopBar extends StatelessWidget {
  final String league;
  final VoidCallback? onBack;
  final VoidCallback? onSave;

  const MatchDetailTopBar({
    super.key,
    required this.league,
    this.onBack,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _HeroCircleButton(
          icon: Icons.arrow_back,
          size: 36,
          iconSize: 20,
          background: colors.surfaceContainerHigh,
          onTap: onBack,
          semanticLabel: 'Volver',
        ),
        Text(
          league,
          style: TextStyle(
            color: colors.onSurfaceVariant,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        _HeroCircleButton(
          icon: Icons.bookmark_border,
          size: 40,
          iconSize: 18,
          background: AppColor.onPrimary.withValues(alpha: 0.08),
          onTap: onSave,
          semanticLabel: 'Guardar partido',
        ),
      ],
    );
  }
}

class _HeroCircleButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final double iconSize;
  final Color background;
  final VoidCallback? onTap;
  final String? semanticLabel;
  const _HeroCircleButton({
    required this.icon,
    required this.size,
    required this.iconSize,
    required this.background,
    this.onTap,
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
          alignment: Alignment.center,
          decoration: BoxDecoration(color: background, shape: BoxShape.circle),
          child: Icon(icon, size: iconSize, color: colors.onSurface),
        ),
      ),
    );
  }
}
