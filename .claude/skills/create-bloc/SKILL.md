---
name: create-bloc
description: Creates a BLoC with Freezed events and state following the project pattern. Usage - /create-bloc BlocName [global|feature]
allowed-tools: Read, Write, Edit, Bash, Glob
---

# Create BLoC

> **iOS HIG**: When using loading indicators in the UI layer, use `CircularProgressIndicator.adaptive()` instead of `CircularProgressIndicator()`.

Create a BLoC named "$ARGUMENTS" following the project's Freezed pattern.

Parse the arguments:
- First argument: Name in PascalCase (e.g.: "MatchList")
- Second argument (optional): "global" or "feature" (default: "feature")

Derive:
- PascalCase: `MatchList`
- snake_case: `match_list`

## Location

- If **global**: `lib/app/bloc/{snake_case}/`
- If **feature**: `lib/app/presentation/{snake_case}/bloc/`

## Create 3 Files

### 1. `{snake_case}_bloc.dart`

```dart
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part '{snake_case}_event.dart';
part '{snake_case}_state.dart';
part '{snake_case}_bloc.freezed.dart';

@injectable  // use @singleton if global
class {PascalCase}Bloc extends Bloc<{PascalCase}Event, {PascalCase}State> {
  {PascalCase}Bloc() : super(const {PascalCase}State()) {
    on<{PascalCase}LoadEvent>(_onLoad);
  }

  Future<void> _onLoad({PascalCase}LoadEvent event, Emitter<{PascalCase}State> emit) async {
    emit(state.copyWith(isLoading: true));
    // TODO: Implement logic
    emit(state.copyWith(isLoading: false));
  }
}
```

Note: If **global**, use `@singleton` instead of `@injectable`.

### 2. `{snake_case}_event.dart`

```dart
part of '{snake_case}_bloc.dart';

@freezed
class {PascalCase}Event with _${PascalCase}Event {
  const factory {PascalCase}Event.load() = {PascalCase}LoadEvent;
}
```

### 3. `{snake_case}_state.dart`

```dart
part of '{snake_case}_bloc.dart';

@freezed
class {PascalCase}State with _${PascalCase}State {
  const factory {PascalCase}State({
    @Default(false) bool isLoading,
  }) = _Initial;
}
```

## If Global

In addition to creating the files, edit `lib/main.dart` to add the BlocProvider:

```dart
BlocProvider(create: (_) => getIt<{PascalCase}Bloc>()),
```

in the `MultiBlocProvider` providers list.

## Code Generation

Run:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Verification

```bash
flutter analyze
```
