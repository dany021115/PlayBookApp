import 'package:flutter/material.dart';
import 'package:playbook/device/theme/color.dart';

/// Pill badge with red dot + minute (e.g. `67'`) used on live match cards.
///
/// Mirrors Pencil `c1Live` / `c2Live`.
class LiveMinuteBadge extends StatelessWidget {
  final String minute;
  const LiveMinuteBadge({super.key, required this.minute});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(7, 0, 8, 0),
      height: 20,
      decoration: BoxDecoration(
        color: AppColor.danger.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColor.danger,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            minute,
            style: const TextStyle(
              color: AppColor.danger,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
