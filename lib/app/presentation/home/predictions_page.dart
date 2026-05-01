import 'package:flutter/material.dart';
import 'package:playbook/device/theme/typography.dart';

class PredictionsPage extends StatelessWidget {
  const PredictionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Predictions')),
      body: SafeArea(
        top: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Tips generados con LLM.\nConectado a /api/v1/predictions.',
              textAlign: TextAlign.center,
              style: styles.bodyText,
            ),
          ),
        ),
      ),
    );
  }
}
