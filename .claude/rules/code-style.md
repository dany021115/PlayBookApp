---
paths:
  - "lib/**/*.dart"
  - "test/**/*.dart"
---

# Code Style Rules

## Imports
- Use absolute imports: `package:playbook/...`
- Order: dart core, flutter, external packages, package:playbook
- Never use relative imports between layers

## Freezed
- Events: `const factory {Name}Event.action() = {Name}ActionEvent;`
- State: A single factory with `@Default` fields
- Entity: `const factory` + `fromJson` factory

## Naming
- Files: `snake_case.dart` (match with main class)
- BLoC files: `{name}_bloc.dart`, `{name}_event.dart`, `{name}_state.dart`
- Part files: `part '{name}_bloc.freezed.dart';` (in the bloc)

## Classes
- Use `const` constructors where possible
- Always use `final` fields
- Prefer `sealed class` for closed hierarchies (like AppError)
- Prefer `abstract class` for interfaces (like Repository)

## Formatting
- Standard Dart format (80 chars)
- Trailing commas in parameter lists for better formatting

## iOS / Platform-aware Code

### Platform Checks
- Use `defaultTargetPlatform == TargetPlatform.iOS` for platform checks (works on all platforms including web)
- Import: `import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;`
- NEVER use `dart:io Platform` — it crashes on web

### Typography
- Never hardcode `fontFamily: 'Nunito'` — always use `AppTextStyle.fontFamily`
- `AppTextStyle.fontFamily` returns `null` on iOS (uses SF Pro), `Nunito` on Android

### SafeArea Pattern
```dart
// With AppBar (top:false because AppBar already handles the inset)
Scaffold(
  appBar: AppBar(...),
  body: SafeArea(
    top: false,
    child: ...,
  ),
)

// Without AppBar (all sides)
Scaffold(
  body: SafeArea(
    child: ...,
  ),
)
```

### Semantics Pattern
```dart
// Custom interactive widgets
Semantics(
  button: true,
  label: 'Description of the action',
  child: GestureDetector(...),
)

// Errors (announced automatically)
Semantics(
  liveRegion: true,
  child: Text(errorMessage),
)
```
