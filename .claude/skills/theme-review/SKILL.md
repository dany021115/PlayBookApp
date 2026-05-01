---
name: theme-review
description: This skill should be used to review a Flutter widget file for correct use of the centralized design system (typography, colors, radius, spacing). Usage - /theme-review [file_path or widget_name]
allowed-tools: Read, Glob, Grep
---

# Design System Compliance Review

Review the widget file "$ARGUMENTS" for correct usage of the project's centralized design system.

If a file path is given, read it directly. If a widget name is given, search for it with Glob.

## Design System Reference

Read `references/design-tokens.md` for the complete token tables (typography, colors, radius, spacing). Key sources:

- **Typography**: `AppTextStyle(context)` semantic getters — `lib/device/theme/typography.dart`
- **Colors**: `Theme.of(context).colorScheme` tokens (named `colors` per project convention) + `AppColor` for brand/status — `lib/device/theme/color.dart`
- **Radius**: `AppRadius.*` / `AppRadius.*Border` — `lib/device/theme/radius.dart`
- **Spacing**: `AppSpacing.*` (Pencil 4/8/12/16/24/32/48/64) — `lib/device/theme/spacing.dart`

## Checklist

Run through each check and report pass/fail with line numbers for violations.

### 1. Typography Violations

- [ ] No inline `TextStyle(fontFamily: AppTextStyle.fontFamily, fontSize: ..., fontWeight: ...)` — use `AppTextStyle(context)` semantic getters instead
- [ ] No hardcoded `fontFamily:` strings like `'Nunito'`, `'Inter'`, or `'SF Pro'`
- [ ] No raw `TextStyle(fontSize: N)` without using the design system
- [ ] AppBar titles should use the theme's `appBarTheme.titleTextStyle` (no manual style needed — just pass a plain `Text` widget)
- [ ] If `AppTextStyle` doesn't have a matching getter for a specific style, flag it as a **missing token** (do NOT suggest adding inline styles)

### 2. Color Violations

- [ ] No hardcoded `Color(0x...)` values
- [ ] No `Colors.xxx` constants (e.g., `Colors.white`, `Colors.grey`) — use `AppColor.onPrimary` for white-on-primary, etc.
- [ ] Uses `Theme.of(context).colorScheme` tokens (assign to local `colors` once per build)
- [ ] No `withOpacity()` — use `withValues(alpha: x)` instead (Flutter 3.x)
- [ ] Text colors come from colorScheme (`onSurface`, `onSurfaceVariant`, `primary`, `error`) not from manual Color values
- [ ] Status colors (success/warning/danger/info) come from `AppColor.*`, not raw hex

### 3. Border Radius Violations

- [ ] No inline `BorderRadius.circular(N)` — use `AppRadius.*Border` tokens
- [ ] Buttons should not set custom `borderRadius` if they already inherit from theme (`OutlinedButton`, `FilledButton`, `TextButton` all get radius from `AppTheme`)
- [ ] Card shapes should not override theme card radius unless intentionally different

### 4. Button Style Violations

- [ ] Prefer the project `AppButton` (`primary` / `outlined` / `text`) over raw Material buttons
- [ ] If a raw `OutlinedButton`/`FilledButton`/`TextButton` is used, do NOT set inline `style:` for properties already defined in theme (fontSize, fontWeight, borderRadius, padding)
- [ ] Only override `style:` for properties that differ from the theme default
- [ ] Button text should NOT have a manual `TextStyle` — the button theme handles it

### 5. Spacing Violations

- [ ] No hardcoded numeric values in `EdgeInsets`, `SizedBox`, or `Gap` where an `AppSpacing` token matches — use `AppSpacing.s4 / s8 / s12 / s16 / s24 / s32 / s48 / s64`
- [ ] Spacing values should align to the Pencil scale (4 / 8 / 12 / 16 / 24 / 32 / 48 / 64)
- [ ] Consistent use of tokens across the file (don't mix `16` and `AppSpacing.s16` in the same file)
- [ ] Note: spacing adoption is progressive — flag violations but understand existing files may not be fully migrated yet

### 6. Container/Decoration Violations

- [ ] `BoxDecoration` border radius uses `AppRadius.*Border`
- [ ] `BoxDecoration` colors use colorScheme tokens
- [ ] Consistent use of `surfaceContainer` for elevated backgrounds

### 7. Toast/Feedback Violations

- [ ] Uses `AppToast.error/success/warning/info` (from `device/helpers/app_toast.dart`)
- [ ] No `ScaffoldMessenger.of(context).showSnackBar(...)` for app-level feedback

## Output Format

For each category, output:
- **PASS** if all checks pass
- **FAIL** with specific line numbers, the violation, and the correct replacement

### Example

```
### 1. Typography Violations — FAIL

Line 58: `TextStyle(fontFamily: AppTextStyle.fontFamily, fontSize: 18, fontWeight: FontWeight.w700, color: colors.onSurface)`
→ Replace with: `AppTextStyle(context).sectionTitle`

Line 112: `TextStyle(fontFamily: AppTextStyle.fontFamily, fontSize: 16, fontWeight: FontWeight.w600, color: colors.onSurface)`
→ Replace with: `AppTextStyle(context).cardTitle`

Line 200: `TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: colors.onSurfaceVariant)`
→ Missing token: no AppTextStyle getter for 13/w600/onSurfaceVariant. Consider adding `categoryLabel` to AppTextStyle.
```

End with a summary: total passes, total failures, missing tokens to add.
