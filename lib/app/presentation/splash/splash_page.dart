import 'package:flutter/material.dart';
import 'package:playbook/app/shared/widgets/app_logo.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/spacing.dart';
import 'package:playbook/device/theme/typography.dart';

/// Splash brand frame matching Pencil hero gradient.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColor.primaryGradient),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppLogo(iconSize: 80, fontSize: 32),
                const SizedBox(height: AppSpacing.s32),
                Text(
                  'Picks deportivos con IA',
                  textAlign: TextAlign.center,
                  style: styles.heroTitle?.copyWith(fontSize: 22),
                ),
                const SizedBox(height: AppSpacing.s48),
                const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    color: AppColor.onPrimary,
                    strokeWidth: 2.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
