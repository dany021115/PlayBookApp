---
paths:
  - "lib/app/presentation/**/*.dart"
  - "lib/app/shared/widgets/**/*.dart"
---

# Widget Creation Standards

## Layout Stability (CRITICAL)

Layout must NEVER shift, jump, or resize when state changes. This is the #1 iOS HIG violation.

### Conditional Elements → Use Opacity, NOT `if`

When an element appears/disappears based on state (selection, edit mode, etc.), it changes the layout and causes jumps.

```dart
// BAD — removes the icon from layout, text reflows, card resizes
if (isSelected)
  Icon(Icons.check_circle, size: 22, color: colors.primary),

// GOOD — icon always occupies space, only visibility changes
Opacity(
  opacity: isSelected ? 1 : 0,
  child: Icon(Icons.check_circle, size: 22, color: colors.primary),
),
```

When the hidden element should also be non-interactive:

```dart
// GOOD — invisible AND non-interactive, but still occupies layout space
Opacity(
  opacity: _isEditing ? 0 : 1,
  child: IgnorePointer(
    ignoring: _isEditing,
    child: GestureDetector(onTap: handler, child: icon),
  ),
),
```

### When `if` IS acceptable

- Elements that add NEW content below (like showing a Save/Cancel row in edit mode — this extends the page, not shifts existing content)
- Loading/error states that replace the entire content area
- List items that are expected to grow/shrink

## Project Loading Widget

ALWAYS use the project's `CustomLoading` widget instead of raw indicators.

```dart
// BAD
CircularProgressIndicator.adaptive()

// GOOD
import 'package:playbook/app/shared/widgets/custom_loading.dart';
const CustomLoading()
CustomLoading(color: colors.onPrimary)  // with custom color
```

## Project Shared Widgets

Before creating inline UI, check if a shared widget exists:

| Widget | Location | Purpose |
|--------|----------|---------|
| `CustomLoading` | `shared/widgets/custom_loading.dart` | Loading indicator |
| `EditActionsRow` | `shared/widgets/edit_actions_row.dart` | Save/Cancel buttons for edit mode |
| `SectionErrorRetry` | `shared/widgets/section_error_retry.dart` | Error message + retry button |
| `ClubDistanceRow` | `shared/widgets/club_distance_row.dart` | Club name + distance display |
| `PageDots` | `shared/widgets/page_dots.dart` | Page indicator dots |
| `AuthSessionListener` | `shared/widgets/auth_session_listener.dart` | Auth state listener wrapper |
| `SwipeToDelete` | `shared/widgets/swipe_to_delete.dart` | iOS-standard swipe-to-delete wrapper |

## Touch Targets

Every interactive element must have a minimum 44x44 tap area.

```dart
// Explicit sizing for icon buttons
GestureDetector(
  onTap: handler,
  child: SizedBox(
    width: 44,
    height: 44,
    child: Icon(Icons.edit_outlined, size: 20),
  ),
),
```

## Semantics

Every custom interactive widget MUST have `Semantics`:

```dart
Semantics(
  button: true,
  label: 'Select Intermediate',
  child: GestureDetector(onTap: onTap, child: card),
)
```

Error messages MUST use `liveRegion`:

```dart
Semantics(
  liveRegion: true,
  child: Text(errorMessage),
)
```

## Design System Tokens (MANDATORY)

### Typography — `AppTextStyle(context)`

NEVER use inline `TextStyle(fontFamily: AppTextStyle.fontFamily, ...)`. Use semantic tokens:

```dart
final styles = AppTextStyle(context);
final colors = Theme.of(context).colorScheme;

Text('Title', style: styles.sectionTitle),
Text('Body', style: styles.bodyText),
Text('Muted', style: styles.bodyText?.copyWith(color: colors.onSurfaceVariant)),
```

If no existing token matches, flag it — do not create inline styles.

### Border Radius — `AppRadius`

NEVER use `BorderRadius.circular(N)`. Use tokens:

```dart
borderRadius: AppRadius.mdBorder,  // 12
borderRadius: AppRadius.lgBorder,  // 16
```

### Spacing — `AppSpacing`

Use `AppSpacing` tokens for padding, margin, gaps, and SizedBox dimensions:

```dart
padding: const EdgeInsets.all(AppSpacing.lg),          // 16
const SizedBox(height: AppSpacing.sm),                  // 8
margin: const EdgeInsets.only(bottom: AppSpacing.md),   // 12
```

## Card/Container Pattern

Standard card pattern used in the project:

```dart
Container(
  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 14),
  decoration: BoxDecoration(
    color: colors.surfaceContainer,
    borderRadius: AppRadius.mdBorder,
    border: Border.all(
      color: isSelected ? colors.primary : colors.outline,
      width: 1,
    ),
  ),
  child: ...,
)
```

## Inline Edit Mode Pattern

For sections with editable content:

1. `StatefulWidget` with local state: `_isEditing`, `_isSaving`, `_tentativeValue`
2. View mode: display data + edit icon (44x44, with `Semantics`)
3. Edit mode: items become tappable, edit icon hidden with `Opacity(0)` + `IgnorePointer`
4. Save/Cancel via `EditActionsRow` shared widget
5. `BlocListener` for save result (success → exit edit, error → SnackBar + stay in edit)
6. `BlocBuilder` with `buildWhen` for selective rebuilds

## Section Data Loading Pattern

```dart
if (data.isEmpty && state.isLoading)
  const Padding(
    padding: EdgeInsets.symmetric(vertical: 24),
    child: CustomLoading(),
  )
else if (data.isEmpty && state.error != null)
  SectionErrorRetry(
    error: state.error!,
    onRetry: () => context.read<Bloc>().add(const LoadEvent()),
  )
else
  ...data.map((item) => ItemWidget(item: item)),
```

## Color Usage

Use `Theme.of(context).colorScheme` tokens, never hardcode colors:

| Token | Usage |
|-------|-------|
| `colors.primary` | Selected state borders, icons, text |
| `colors.onSurface` | Default text |
| `colors.onSurfaceVariant` | Secondary/description text |
| `colors.surfaceContainer` | Card backgrounds |
| `colors.outline` | Unselected borders |
| `colors.error` | Error text |
| `colors.onPrimary` | Text on primary-colored backgrounds |

## Componentization

If a UI pattern will be reused (even potentially), extract it to `lib/app/shared/widgets/`. Sections within a page go in `lib/app/presentation/{feature}/widgets/`.
