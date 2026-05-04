import 'package:flutter/material.dart';
import 'package:playbook/device/theme/color.dart';

/// Placeholder team crest — flat circle. Replace with `Image.network(...)`
/// once we wire `Team.logo_url` from the API.
class TeamCrest extends StatelessWidget {
  final double size;
  final String? logoUrl;
  const TeamCrest({super.key, this.size = 32, this.logoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColor.surfaceElevatedLight,
        shape: BoxShape.circle,
      ),
    );
  }
}
