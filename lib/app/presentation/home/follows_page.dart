import 'package:flutter/material.dart';
import 'package:playbook/device/theme/typography.dart';

class FollowsPage extends StatelessWidget {
  const FollowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Follows')),
      body: SafeArea(
        top: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Ligas y predicciones guardadas.\nConectado a /api/v1/me/follows y /api/v1/me/saved-predictions.',
              textAlign: TextAlign.center,
              style: styles.bodyText,
            ),
          ),
        ),
      ),
    );
  }
}
