import 'package:flutter/material.dart';
import 'package:playbook/device/theme/color.dart';

/// AI prediction pill — sparkles icon + text on translucent primary.
///
/// Mirrors Pencil `c1Pick`.
class PickPill extends StatelessWidget {
  final String text;
  const PickPill({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        color: AppColor.primary.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, color: AppColor.primary, size: 14),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColor.primary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
