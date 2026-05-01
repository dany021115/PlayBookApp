import 'package:flutter/material.dart';
import 'package:playbook/device/theme/typography.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Matches')),
      body: SafeArea(
        top: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Listado de partidos por liga.\nConectado a /api/v1/markets/matches.',
              textAlign: TextAlign.center,
              style: styles.bodyText,
            ),
          ),
        ),
      ),
    );
  }
}
