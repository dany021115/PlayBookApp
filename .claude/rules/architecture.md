---
paths:
  - "lib/**/*.dart"
---

# Architecture Rules

## Layer Dependencies
- `domain/` does NOT import from `data/`, `device/`, or `app/` — it's pure Dart
- `data/` imports from `domain/` (to implement interfaces)
- `device/` does NOT import from `data/` or `domain/`
- `app/` can import from all layers

## Where Each Thing Goes
- Pure business logic → `domain/`
- DTOs, API calls, cache → `data/`
- Theme, router helpers, device features → `device/`
- BLoCs, pages, widgets, router config → `app/`

## BLoCs
- Global BLoCs (auth, nav, theme) go in `app/bloc/`
- Feature BLoCs go in `app/presentation/{feature}/bloc/` or next to their page
- Every BLoC MUST use Freezed for events and state
- Every BLoC MUST have `@injectable` or `@singleton` for DI
- State uses copyWith, do NOT create multiple state classes — use a single state with fields

## Entities and Models
- Domain entities go in `domain/entities/` — Freezed, immutable
- API DTOs/Models go in `data/entities/` — Freezed + JsonSerializable
- ALWAYS use `@freezed` with `_$ClassName`
- ALWAYS include `part '{name}.freezed.dart'` and `part '{name}.g.dart'`

## Repositories
- Abstract interface in `domain/repository/`
- Concrete implementation in `data/repository/`
- Implementation uses `@LazySingleton(as: AbstractInterface)`
- Methods return `Future<Either<AppError, T>>` using fpdart

## API
- Endpoints are defined in `data/api/rest_client.dart` with Retrofit annotations
- URL constants in `data/constants/api.dart`
- Error handling with `AppError.fromDioResponse()`

## DI
- Everything is registered with Injectable annotations, not manually
- After creating classes with `@injectable`/`@singleton`/`@lazySingleton`, run build_runner

## iOS HIG / Platform Adaptations

### SafeArea
- Every page MUST have `SafeArea`
- When there's an AppBar: `Scaffold(body: SafeArea(top: false, child: ...))` — the AppBar already handles the top inset
- When there's no AppBar (splash, auth): `SafeArea(child: ...)` with all sides

### Adaptive Widgets
- Use `.adaptive()` constructor: `CircularProgressIndicator.adaptive()`, `Switch.adaptive()`, `Slider.adaptive()`
- Do NOT import `cupertino.dart` directly for widgets — the `.adaptive()` constructors adapt automatically
- Exception: `CupertinoPage` in `transitions.dart` for navigation

### Navigation
- Normal routes: `PageTransitions.platformTransition()` — uses `CupertinoPage` on iOS (slide-from-right + swipe-back), fade on others
- Splash/auth only: `PageTransitions.fadeTransition()` — these are not standard navigation

### Touch Targets
- Minimum 44x44pt on all interactive elements
- `materialTapTargetSize: MaterialTapTargetSize.padded` is set in the global ThemeData

### Elevation
- iOS does not use shadows/elevation (flat design)
- The theme handles this automatically: card elevation 0, bottom nav elevation 0, FAB elevation 0 on iOS
- No manual action needed — `AppTheme` is already platform-aware

### Accessibility / VoiceOver
- `Semantics` wrapper on custom interactive widgets
- `semanticLabel` on `Image` and decorative icons
- Error texts must have `Semantics(liveRegion: true)` for automatic announcements
