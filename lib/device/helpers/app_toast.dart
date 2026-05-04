import 'package:flutter/material.dart';
import 'package:playbook/app/shared/widgets/playbook_toast.dart';
import 'package:toastification/toastification.dart';

/// Thin facade over `toastification` that always renders [PlaybookToast]
/// (the Pencil `Toast/*` cards in `U9QHd / Feedback`).
///
/// Calling code stays identical (`AppToast.success(context, '...')`) and an
/// optional [subtitle] enables the 2-line variant.
abstract class AppToast {
  static void error(BuildContext context, String title, {String? subtitle}) =>
      _show(context, PlaybookToastVariant.error, title, subtitle);

  static void success(BuildContext context, String title,
          {String? subtitle}) =>
      _show(context, PlaybookToastVariant.success, title, subtitle);

  static void warning(BuildContext context, String title,
          {String? subtitle}) =>
      _show(context, PlaybookToastVariant.warning, title, subtitle);

  static void info(BuildContext context, String title, {String? subtitle}) =>
      _show(context, PlaybookToastVariant.info, title, subtitle);

  static void _show(
    BuildContext context,
    PlaybookToastVariant variant,
    String title,
    String? subtitle,
  ) {
    toastification.showCustom(
      context: context,
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.topRight,
      builder: (context, holder) => Padding(
        padding: const EdgeInsets.all(12),
        child: PlaybookToast(
          variant: variant,
          title: title,
          subtitle: subtitle,
          onClose: () => toastification.dismiss(holder),
        ),
      ),
    );
  }
}
