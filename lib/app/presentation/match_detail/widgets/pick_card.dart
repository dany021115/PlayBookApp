import 'package:flutter/material.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/radius.dart';

/// Primary-gradient pick card with sparkles + confidence pill.
///
/// Mirrors Pencil `dsUWi / mdPickCard`.
class PickCard extends StatelessWidget {
  final String title;
  final String reasoning;
  final int confidence; // 0..100

  const PickCard({
    super.key,
    required this.title,
    required this.reasoning,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: AppColor.primaryGradient,
        borderRadius: AppRadius.sheetBorder,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PickHeader(confidence: confidence),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: AppColor.onPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            reasoning,
            style: TextStyle(
              color: AppColor.onPrimary.withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _PickHeader extends StatelessWidget {
  final int confidence;
  const _PickHeader({required this.confidence});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Icon(Icons.auto_awesome, color: AppColor.onPrimary, size: 16),
            SizedBox(width: 6),
            Text(
              'Nuestro pick',
              style: TextStyle(
                color: AppColor.onPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Container(
          height: 22,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColor.onPrimary.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Text(
            'Conf $confidence%',
            style: const TextStyle(
              color: AppColor.onPrimary,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
