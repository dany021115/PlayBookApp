import 'package:flutter/material.dart';
import 'package:playbook/device/theme/color.dart';
import 'package:playbook/device/theme/radius.dart';
import 'package:playbook/device/theme/typography.dart';

/// Mirrors Pencil Component/Input/Text (`U8FwI`):
/// - label 12/600 secondary above field (gap 6)
/// - field 52h, radius 12 (auth flavor — Pencil uses 44h+8 in component
///   but auth screens override to 52h+12 — we match the screen, not the comp)
/// - surface fill, 1px border, primary border on focus
class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffix;
  final TextEditingController? controller;
  final bool obscureText;
  final bool enabled;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffix,
    this.controller,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType,
    this.autofillHints,
    this.validator,
    this.onChanged,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    final c = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: styles.formLabel),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          autofillHints: widget.autofillHints,
          validator: widget.validator,
          onChanged: widget.onChanged,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onSubmitted,
          focusNode: _focusNode,
          style: styles.formField,
          cursorColor: AppColor.primary,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: styles.formHint,
            prefixIcon: widget.prefixIcon == null
                ? null
                : Icon(widget.prefixIcon,
                    size: 18, color: c.onSurfaceVariant),
            suffixIcon: widget.suffix,
            filled: true,
            fillColor: c.surfaceContainer,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: AppRadius.cardBorder,
              borderSide: BorderSide(color: c.outline, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.cardBorder,
              borderSide: BorderSide(color: c.outline, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.cardBorder,
              borderSide: const BorderSide(color: AppColor.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: AppRadius.cardBorder,
              borderSide: const BorderSide(color: AppColor.danger, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: AppRadius.cardBorder,
              borderSide: const BorderSide(color: AppColor.danger, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
