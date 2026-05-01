---
name: create-feature
description: Creates a complete feature following the project's clean architecture. Generates entity, repository, BLoC, page, and endpoints. Usage - /create-feature FeatureName
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
---

# Create Complete Feature

> **iOS HIG**: Every page must use SafeArea, CircularProgressIndicator.adaptive(), Semantics on errors, and `platformTransition()` on routes.

Create a feature named "$ARGUMENTS" following the project's clean architecture.

The name comes in PascalCase (e.g.: "MatchList"). Derive:
- snake_case: `match_list`
- File: `match_list.dart`
- Class: `MatchList`

## Step 1: Domain Entity

Create `lib/domain/entities/{snake_case}.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '{snake_case}.freezed.dart';
part '{snake_case}.g.dart';

@freezed
class {PascalCase} with _${PascalCase} {
  const factory {PascalCase}({
    required String id,
    // TODO: Add feature fields
  }) = _{PascalCase};

  factory {PascalCase}.fromJson(Map<String, dynamic> json) => _${PascalCase}FromJson(json);
}
```

## Step 2: Domain Repository (interface)

Create `lib/domain/repository/i_{snake_case}_repository.dart`:

```dart
import 'package:fpdart/fpdart.dart';
import 'package:playbook/data/api/app_error.dart';
import 'package:playbook/domain/entities/{snake_case}.dart';

abstract class I{PascalCase}Repository {
  Future<Either<AppError, List<{PascalCase}>>> getAll();
  Future<Either<AppError, {PascalCase}>> getById(String id);
}
```

> Note: PlayBook prefixes repository interfaces with `I` (e.g. `IAuthRepository`). Keep that convention.

## Step 3: RestClient Endpoints

Edit `lib/data/api/rest_client.dart` and add the endpoints:

```dart
@GET('/api/v1/{snake_case}s/')
Future<List<{PascalCase}Dto>> getAll{PascalCase}s();

@GET('/api/v1/{snake_case}s/{id}/')
Future<{PascalCase}Dto> get{PascalCase}ById(@Path('id') String id);
```

Add the entity import to rest_client.dart.

## Step 4: Data DTO (if API shape differs from domain)

If the API response differs from the domain entity, create a DTO in `lib/data/entities/{snake_case}_dto.dart` and map to the domain entity via a `toEntity()` extension.

## Step 5: Data Repository (implementation)

Create `lib/data/repository/{snake_case}_repository.dart`:

```dart
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:playbook/data/api/app_error.dart';
import 'package:playbook/data/api/rest_client.dart';
import 'package:playbook/domain/entities/{snake_case}.dart';
import 'package:playbook/domain/repository/i_{snake_case}_repository.dart';

@LazySingleton(as: I{PascalCase}Repository)
class {PascalCase}Repository implements I{PascalCase}Repository {
  final RestClient _client;

  {PascalCase}Repository(this._client);

  @override
  Future<Either<AppError, List<{PascalCase}>>> getAll() async {
    try {
      final response = await _client.getAll{PascalCase}s();
      return right(response.map((dto) => dto.toEntity()).toList());
    } on DioException catch (e) {
      return left(AppError.fromDio(e));
    }
  }

  @override
  Future<Either<AppError, {PascalCase}>> getById(String id) async {
    try {
      final response = await _client.get{PascalCase}ById(id);
      return right(response.toEntity());
    } on DioException catch (e) {
      return left(AppError.fromDio(e));
    }
  }
}
```

## Step 6: Feature BLoC

Create 3 files in `lib/app/presentation/{snake_case}/bloc/`:

### `{snake_case}_bloc.dart`:
```dart
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:playbook/domain/entities/{snake_case}.dart';
import 'package:playbook/domain/repository/i_{snake_case}_repository.dart';

part '{snake_case}_event.dart';
part '{snake_case}_state.dart';
part '{snake_case}_bloc.freezed.dart';

@injectable
class {PascalCase}Bloc extends Bloc<{PascalCase}Event, {PascalCase}State> {
  final I{PascalCase}Repository _repository;

  {PascalCase}Bloc(this._repository) : super(const {PascalCase}State()) {
    on<{PascalCase}LoadEvent>(_onLoad);
  }

  Future<void> _onLoad({PascalCase}LoadEvent event, Emitter<{PascalCase}State> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _repository.getAll();
    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error.displayMessage)),
      (data) => emit(state.copyWith(isLoading: false, items: data)),
    );
  }
}
```

### `{snake_case}_event.dart`:
```dart
part of '{snake_case}_bloc.dart';

@freezed
class {PascalCase}Event with _${PascalCase}Event {
  const factory {PascalCase}Event.load() = {PascalCase}LoadEvent;
}
```

### `{snake_case}_state.dart`:
```dart
part of '{snake_case}_bloc.dart';

@freezed
class {PascalCase}State with _${PascalCase}State {
  const factory {PascalCase}State({
    @Default(false) bool isLoading,
    @Default([]) List<{PascalCase}> items,
    String? error,
  }) = _Initial;
}
```

## Step 7: Feature Page

Create `lib/app/presentation/{snake_case}/{snake_case}_page.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playbook/app/presentation/{snake_case}/bloc/{snake_case}_bloc.dart';
import 'package:playbook/device/theme/typography.dart';
import 'package:playbook/di.dart';

class {PascalCase}Page extends StatelessWidget {
  const {PascalCase}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<{PascalCase}Bloc>()..add(const {PascalCase}Event.load()),
      child: const _{PascalCase}View(),
    );
  }
}

class _{PascalCase}View extends StatelessWidget {
  const _{PascalCase}View();

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyle(context);
    return Scaffold(
      appBar: AppBar(title: const Text('{PascalCase}')),
      body: SafeArea(
        top: false,
        child: BlocBuilder<{PascalCase}Bloc, {PascalCase}State>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (state.error != null) {
              return Center(
                child: Semantics(
                  liveRegion: true,
                  child: Text(state.error!, style: styles.statusError),
                ),
              );
            }
            if (state.items.isEmpty) {
              return Center(child: Text('Sin datos', style: styles.bodySecondary));
            }
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return ListTile(
                  title: Text(item.id, style: styles.cardTitle),
                  // TODO: Customize the ListTile
                );
              },
            );
          },
        ),
      ),
    );
  }
}
```

## Step 8: Register Route

Edit `lib/app/router.dart`:
1. Add to `AppRoute` enum: `{camelCase},`
2. Edit `lib/device/router/manager.dart` and add a path entry to `_routeBuilders`.
3. Add a `GoRoute` inside the `ShellRoute` (if it lives in the bottom nav) or at root level:
```dart
GoRoute(
  path: '${RouterManager.baseHome}/{snake_case}',
  name: AppRoute.{camelCase}.name,
  pageBuilder: (context, state) => PageTransitions.platformTransition(
    child: const {PascalCase}Page(),
    state: state,
  ),
),
```
4. Add the page import.

## Step 9: Code Generation

Run:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Step 10: Verification

Run:
```bash
flutter analyze
```

Verify there are no errors. Warnings in `.g.dart` or `.freezed.dart` files are normal.

## Summary of Created Files
1. `lib/domain/entities/{snake_case}.dart`
2. `lib/domain/repository/i_{snake_case}_repository.dart`
3. `lib/data/entities/{snake_case}_dto.dart` (if needed)
4. `lib/data/repository/{snake_case}_repository.dart`
5. `lib/app/presentation/{snake_case}/bloc/{snake_case}_bloc.dart`
6. `lib/app/presentation/{snake_case}/bloc/{snake_case}_event.dart`
7. `lib/app/presentation/{snake_case}/bloc/{snake_case}_state.dart`
8. `lib/app/presentation/{snake_case}/{snake_case}_page.dart`
9. Edited: `rest_client.dart`, `router.dart`, `manager.dart`
