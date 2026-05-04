# Mock Data Rules

UI screens that aren't yet wired to the backend MUST keep their mock data
in `lib/app/mock/`, never inline in widgets.

## Why

* Widgets stay pure presentation. They receive data via constructor params,
  not from hardcoded constants embedded in the build method.
* When the backend wire lands, swapping mock → real is a one-line change in
  a single section widget (replace `MatchesMock.live` with `state.live`).
* Designers and copy reviewers can change the demo content in one place.

## Folder layout

```
lib/app/mock/
├── matches_mock.dart       # Inicio screen mocks
├── predictions_mock.dart   # Tips screen mocks
├── profile_mock.dart       # Perfil screen mocks
└── ...                     # one file per feature
```

## File template

Each mock file exposes:

1. **Plain immutable model classes** — `@immutable` data records that
   match the constructor params of the consuming widget. Their shape
   should mirror what the eventual `domain/entities/<Foo>.dart` will
   look like, so the swap costs nothing extra later.
2. **A single namespacing class** with a private constructor — holds
   `static const` lists / scalars that the UI references.

Example skeleton:

```dart
@immutable
class MockFoo {
  final String title;
  // ...
  const MockFoo({required this.title, ...});
}

class FooMock {
  FooMock._();

  static const String pageTitle = 'Foo';
  static const List<MockFoo> items = [
    MockFoo(title: '...'),
  ];
}
```

## What goes in the mock vs in the widget

* **Mock**: scalars (titles, counts, copy), lists of records, theme-token
  references that are *content choices* (e.g. `AppColor.primary` for one
  match's league dot).
* **Widget**: layout, padding, the act of rendering a list, semantic
  affordances. Widgets must NOT mention specific match names, team names,
  league copy, or counts inline.

## Anti-patterns

NO:

```dart
// inside a section widget
const MatchCard(
  league: 'LaLiga · J32',
  home: 'R. Madrid',
  away: 'Barça',
  ...
)
```

YES:

```dart
// inside a section widget
for (final m in MatchesMock.live)
  MatchCard(
    league: m.league,
    home: m.home,
    away: m.away,
    ...
  )
```

## Replacing with real data

When wiring the backend:

1. Add the `BLoC` and `Repository` per `architecture.md`.
2. In the section widget, replace
   ```dart
   final items = FooMock.items;
   ```
   with
   ```dart
   final items = context.watch<FooBloc>().state.items;
   ```
3. The mock file stays as-is — it's still useful for tests and Storybook-style demos.

## When NOT to use this folder

If a constant is genuinely UX scaffolding (placeholder text, default
breakpoints, asset paths), keep it next to the widget. The mock folder
is only for content that *will be replaced by API-derived data*.
