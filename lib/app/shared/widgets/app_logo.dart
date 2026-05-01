import 'package:flutter/material.dart';
import 'package:playbook/device/theme/radius.dart';
import 'package:playbook/device/theme/typography.dart';

/// PlayBook brand mark — book + arrow + chart icon, gradient backdrop baked
/// into the asset itself. Stacks vertically: icon → wordmark → tagline.
class AppLogo extends StatelessWidget {
  final double iconSize;
  final double fontSize;
  final bool showWordmark;
  final String? tagline;

  const AppLogo({
    super.key,
    this.iconSize = 56,
    this.fontSize = 22,
    this.showWordmark = true,
    this.tagline = 'Tu analista deportivo de bolsillo',
  });

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: AppRadius.cardBorder,
          child: Image.asset(
            'assets/images/logo.png',
            width: iconSize,
            height: iconSize,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            semanticLabel: 'PlayBook',
          ),
        ),
        if (showWordmark) ...[
          const SizedBox(height: 12),
          Text(
            'PlayBook',
            style: styles.pageTitle?.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          if (tagline != null && tagline!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              tagline!,
              textAlign: TextAlign.center,
              style: styles.authSubtitle,
            ),
          ],
        ],
      ],
    );
  }
}
