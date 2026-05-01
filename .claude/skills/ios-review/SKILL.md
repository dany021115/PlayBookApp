---
name: ios-review
description: This skill should be used to review a Flutter widget file for iOS HIG compliance and project standards. Usage - /ios-review [file_path or widget_name]
allowed-tools: Read, Glob, Grep
---

# iOS HIG & Widget Standards Review

Review the widget file "$ARGUMENTS" for compliance with iOS Human Interface Guidelines and project standards.

If a file path is given, read it directly. If a widget name is given, search for it with Glob.

## Checklist

Run through each check and report pass/fail with line numbers for violations.

### 1. Layout Stability
- [ ] No conditional rendering (`if`) that adds/removes elements within a Row, causing siblings to resize
- [ ] Elements that toggle visibility use `Opacity` + `IgnorePointer` instead of `if`/ternary that removes from layout
- [ ] Cards/containers maintain consistent dimensions regardless of selection state
- [ ] Check icons, badges, or indicators that appear on selection are always in the layout tree

### 2. Touch Targets
- [ ] All `GestureDetector` and `InkWell` widgets have at least 44x44 tap area
- [ ] Icon buttons wrapped in `SizedBox(width: 44, height: 44)`
- [ ] No bare `Icon` used as a tap target without proper sizing

### 3. Loading Indicators
- [ ] Uses `CircularProgressIndicator.adaptive()` (NOT raw `CircularProgressIndicator()`)
- [ ] If a project-wide `CustomLoading` is added later, switch to it

### 4. Typography
- [ ] Uses `AppTextStyle(context)` semantic getters — NOT inline `TextStyle(fontFamily: ..., fontSize: ..., fontWeight: ...)`
- [ ] No hardcoded font family strings like `'Nunito'`, `'Inter'`, or `'SF Pro'`
- [ ] Font imported: `import 'package:playbook/device/theme/typography.dart'`

### 5. Accessibility / Semantics
- [ ] All custom interactive widgets wrapped in `Semantics(button: true, label: '...')`
- [ ] Error messages use `Semantics(liveRegion: true)`
- [ ] Images and decorative icons have `semanticLabel`

### 6. Colors
- [ ] Uses `Theme.of(context).colorScheme` tokens (named `colors` per project convention)
- [ ] No hardcoded `Color(0x...)` or `Colors.xxx`
- [ ] Selected state uses `colors.primary`
- [ ] Text uses `colors.onSurface` / `colors.onSurfaceVariant`

### 7. Shared Widgets
- [ ] Uses `AppButton` for buttons (`primary` / `outlined` / `text` variants)
- [ ] Uses `AppTextField` for inputs (label + field, primary focus stroke)
- [ ] Uses `AppToast` (from `device/helpers/app_toast.dart`) for transient feedback (no `ScaffoldMessenger.showSnackBar`)
- [ ] Uses `AuthSessionListener` only at app root

### 8. Edit Mode Pattern (if applicable)
- [ ] `StatefulWidget` with `_isEditing`, `_isSaving`, `_tentativeValue`
- [ ] Edit icon hidden with `Opacity(0)` + `IgnorePointer` (not removed from tree)
- [ ] `BlocListener` for save result detection
- [ ] `BlocBuilder` with `buildWhen` for selective rebuilds
- [ ] Save button disabled when no change (`_tentativeValue == currentValue`)

### 9. Container/Card Pattern
- [ ] Uses `colors.surfaceContainer` for elevated backgrounds
- [ ] Border: `colors.outline` (unselected), `colors.primary` (selected)
- [ ] Uses `AppRadius.cardBorder` (12) for cards — NOT inline `BorderRadius.circular(N)`
- [ ] Padding: `EdgeInsets.symmetric(horizontal: AppSpacing.s16, vertical: 14)`

### 10. SafeArea (pages only)
- [ ] Page has `SafeArea`
- [ ] If AppBar present: `SafeArea(top: false)`
- [ ] If no AppBar: `SafeArea()` with all sides

### 11. Platform checks
- [ ] Uses `defaultTargetPlatform == TargetPlatform.iOS` (NOT `dart:io Platform`, which crashes on web)
- [ ] Navigation transitions go through `PageTransitions.platformTransition`

## Output Format

For each category, output:
- **PASS** if all checks pass
- **FAIL** with specific line numbers and what to fix

End with a summary: total passes, total failures, and priority fixes.
