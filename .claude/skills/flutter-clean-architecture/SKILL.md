---
name: flutter-clean-architecture
description: Use this skill whenever the user is working on a Flutter or Dart project and asks for help creating, scaffolding, refactoring, or reviewing code that should follow Clean Architecture. Trigger this for ANY Flutter feature work — building a screen, adding a repository, wiring up state management (BLoC/Cubit/Provider/Riverpod), creating a use case, defining entities, integrating an API or local storage, structuring folders, or setting up a new feature module. Also trigger when the user mentions "clean architecture", "domain layer", "data layer", "presentation layer", "use case", "repository pattern", or shows a folder layout with `domain/`, `data/`, `presentation/`, or `core/`. If a Flutter task could plausibly benefit from layered architecture, reach for this skill instead of writing ad-hoc code.
---

# Flutter Clean Architecture

A skill for producing Flutter code that follows the four-layer Clean Architecture pattern: **Domain**, **Data**, **Presentation**, and **Core**. The conventions encoded here match a specific team style — interfaces use the `I` prefix (e.g. `IUserRepository`), models extend entities (`UserModel extends User`), and data sources are split by transport (`api_source`, `local_source`, `firestore_source`).

## When to use this skill

Use this skill when generating, reviewing, or refactoring Flutter code that involves:

- Creating a new feature module (e.g. authentication, profile, products)
- Defining entities, models, repositories, or use cases
- Wiring state management (BLoC, Cubit, Provider, Riverpod, GetX)
- Adding API calls, local storage, or Firestore integration
- Organizing the folder structure of a Flutter project
- Reviewing whether existing code respects layer boundaries

Skip this skill for trivial single-widget tasks that don't touch business logic (e.g. "change this button color"), or for non-Flutter Dart scripts.

## The four layers

Source dependencies flow inward only: **Presentation → Domain ← Data**, with **Core** available to all. The Domain layer never imports from Data, Presentation, or Flutter itself — it must be pure Dart. Violating this is the single most common Clean Architecture mistake.

```
lib/
├── core/                   # Cross-cutting concerns (no Flutter-specific logic)
│   ├── errors/             # Failure classes, exception types
│   ├── services/           # Network info, logging, analytics, interceptors
│   └── utils/
│       ├── extensions/     # Dart extensions (StringX, DateTimeX, etc.)
│       └── generics/       # UseCase<Type, Params>, Result<T>, etc.
│
├── features/
│   └── <feature_name>/
│       ├── domain/                 # Pure Dart — no Flutter imports
│       │   ├── entities/           # User, Item, Order — plain business objects
│       │   ├── repositories/       # IUserRepository (abstract contracts)
│       │   └── usecases/           # GetUser, CreateOrder — one action per class
│       │
│       ├── data/                   # Implements domain contracts
│       │   ├── models/             # UserModel extends User; toJson/fromJson
│       │   ├── repositories/       # UserRepository implements IUserRepository
│       │   └── sources/            # Include only those the feature needs:
│       │       ├── api_source.dart       #   Remote (Dio/http) — almost always
│       │       ├── local_source.dart     #   Hive/SharedPrefs/sqflite — when caching
│       │       └── firestore_source.dart #   Firestore — when used
│       │
│       └── presentation/           # Flutter-aware
│           ├── pages/              # Screens
│           ├── bloc/ (or cubit/, provider/)
│           ├── components/         # Feature-specific widgets
│           ├── themes/             # Feature theming (rare; usually in core)
│           └── routes/             # Feature routes (rare; usually in app/)
│
└── app/                    # App-level wiring
    ├── routes/             # GoRouter / AutoRoute config
    ├── themes/             # App-wide ThemeData
    └── injection.dart      # get_it / injectable setup
```

The default for a new feature is **one data source** (the API). Add `local_source` only when caching is needed, `firestore_source` only when Firestore is actually used. Don't generate empty source files just to fill the template.

## Naming conventions (this team's style)

These conventions match the architecture diagram this skill is built around. Don't deviate without asking the user.

| Concept                 | Convention                          | Example                                  |
|-------------------------|-------------------------------------|------------------------------------------|
| Domain repository       | `I` prefix, abstract class          | `abstract class IUserRepository`         |
| Data repository         | No prefix, implements interface     | `class UserRepository implements IUserRepository` |
| Domain entity           | Plain noun                          | `class User`                             |
| Data model              | `Model` suffix, extends entity      | `class UserModel extends User`           |
| Use case                | Verb + noun, one method `call()`    | `class GetUser`, `class CreateOrder`     |
| Data source (abstract)  | `I` prefix + source kind            | `IUserApiSource`, `IUserLocalSource`     |
| Data source (impl)      | Source kind suffix                  | `UserApiSource`, `UserLocalSource`       |
| BLoC event              | Past tense or imperative            | `LoginRequested`, `UserLoaded`           |
| BLoC state              | Adjective or status                 | `AuthLoading`, `AuthAuthenticated`       |
| Failure (in core)       | `Failure` suffix                    | `ServerFailure`, `CacheFailure`          |

File names are `snake_case` and match the primary class: `i_user_repository.dart`, `user_model.dart`, `get_user.dart`.

## Layer-by-layer patterns

### Domain layer

Pure Dart. No `package:flutter/*`, no `package:dio/*`, no JSON. The domain describes **what** the app does, not **how**.

**Entity** — a value object. Use `equatable` for value equality.

```dart
// lib/features/user/domain/entities/user.dart
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;

  const User({required this.id, required this.name, required this.email});

  @override
  List<Object?> get props => [id, name, email];
}
```

**Repository interface** — defines the contract the data layer must fulfil. Returns `Either<Failure, T>` so errors are typed and explicit (using `dartz` or `fpdart`).

```dart
// lib/features/user/domain/repositories/i_user_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class IUserRepository {
  Future<Either<Failure, User>> getUser(String id);
  Future<Either<Failure, List<User>>> getAllUsers();
  Future<Either<Failure, void>> updateUser(User user);
}
```

**Use case** — one action, one class, one `call()` method. Pulls in only the repositories it needs.

```dart
// lib/features/user/domain/usecases/get_user.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/generics/usecase.dart';
import '../entities/user.dart';
import '../repositories/i_user_repository.dart';

class GetUser implements UseCase<User, String> {
  final IUserRepository repository;
  GetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(String userId) {
    return repository.getUser(userId);
  }
}
```

The generic `UseCase` lives in `core/utils/generics/`:

```dart
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  const NoParams();
}
```

For a use case with multiple inputs, define a `Params` class next to it:

```dart
class ToggleFavoriteParams extends Equatable {
  final String userId;
  final String productId;
  const ToggleFavoriteParams({required this.userId, required this.productId});
  @override
  List<Object?> get props => [userId, productId];
}
```

### Data layer

Implements the contracts. Knows about JSON, HTTP, databases, and caching.

**Model** — extends the entity, adds serialization. Domain code never sees JSON because the model's `User` face is what crosses the boundary.

```dart
// lib/features/user/data/models/user_model.dart
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.id, required super.name, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'email': email};
}
```

**Data source** — one per transport. Most features start with just an API source.

```dart
// lib/features/user/data/sources/user_api_source.dart
abstract class IUserApiSource {
  Future<UserModel> getUser(String id);
}

class UserApiSource implements IUserApiSource {
  final Dio dio;
  UserApiSource(this.dio);

  @override
  Future<UserModel> getUser(String id) async {
    try {
      final response = await dio.get('/users/$id');
      return UserModel.fromJson(response.data);
    } on DioException {
      throw ServerException();
    }
  }
}
```

**Repository implementation (default — single source)** — converts exceptions to typed failures and hands entities to the domain layer. This is the right starting point unless the feature explicitly needs offline support.

```dart
// lib/features/user/data/repositories/user_repository.dart
class UserRepository implements IUserRepository {
  final IUserApiSource apiSource;
  UserRepository({required this.apiSource});

  @override
  Future<Either<Failure, User>> getUser(String id) async {
    try {
      final user = await apiSource.getUser(id);
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  // ... other methods
}
```

If the feature needs **offline-first behavior** (cache + connectivity-aware reads, optimistic writes, queued sync), that's an opt-in extension. Ask the user whether they want it before adding it. The full pattern lives in `references/offline_first.md`.

### Presentation layer

Where Flutter lives. State management is the bridge between user actions and use cases.

**BLoC pattern** (preferred for complex flows):

```dart
// lib/features/user/presentation/bloc/user_bloc.dart
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;

  UserBloc({required this.getUser}) : super(UserInitial()) {
    on<UserRequested>(_onUserRequested);
  }

  Future<void> _onUserRequested(UserRequested event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await getUser(event.userId);
    result.fold(
      (failure) => emit(UserError(_mapFailureToMessage(failure))),
      (user) => emit(UserLoaded(user)),
    );
  }

  String _mapFailureToMessage(Failure f) =>
      f is ServerFailure ? 'Server error' : 'Cache error';
}
```

**Page** — pure UI. Reacts to state, dispatches events. No business logic.

```dart
class UserPage extends StatelessWidget {
  final String userId;
  const UserPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserBloc>()..add(UserRequested(userId)),
      child: Scaffold(
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) => switch (state) {
            UserLoading() => const Center(child: CircularProgressIndicator()),
            UserLoaded(:final user) => UserView(user: user),
            UserError(:final message) => ErrorView(message: message),
            _ => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}
```

For simpler features, **Cubit** (no events) or **Provider**/**Riverpod** are valid alternatives — match whatever the project already uses. See `references/state_management.md` for templates, plus the **debounce/throttle** pattern (search-as-you-type), the **flicker-free update** pattern (refreshing without yanking the user back to a spinner), and the **optimistic UI** pattern (instant feedback on toggles/likes without going offline-first).

### Core layer

Shared infrastructure. Lives outside any feature.

**Failures** — sealed hierarchy:

```dart
// lib/core/errors/failures.dart
abstract class Failure extends Equatable {
  const Failure();
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}
class CacheFailure extends Failure {}
class NetworkFailure extends Failure {}
class ValidationFailure extends Failure {
  final String message;
  const ValidationFailure(this.message);
  @override
  List<Object?> get props => [message];
}
```

**Exceptions** (thrown inside the data layer, caught and converted to Failures):

```dart
class ServerException implements Exception {}
class CacheException implements Exception {}
```

**Services** — `INetworkInfo`, logging, analytics. Defined as interfaces in core, implemented with concrete dependencies.

**Extensions** — small Dart utilities (`StringX`, `BuildContextX`, `DateTimeX`).

#### Cross-cutting infrastructure (Dio interceptors)

Auth tokens, logging, retries, and base URL configuration don't belong in individual API sources — they're cross-cutting and live as `Interceptor`s wired into a single shared `Dio` instance.

```dart
// lib/core/services/auth_interceptor.dart
class AuthInterceptor extends Interceptor {
  final ITokenStorage tokenStorage;
  AuthInterceptor(this.tokenStorage);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await tokenStorage.getToken();
    if (token != null) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await tokenStorage.clear(); // trigger re-login flow
    }
    handler.next(err);
  }
}
```

Wire it once in `app/injection.dart`:

```dart
sl.registerLazySingleton(() {
  final dio = Dio(BaseOptions(baseUrl: 'https://api.example.com'));
  dio.interceptors.addAll([
    AuthInterceptor(sl<ITokenStorage>()),
    LogInterceptor(requestBody: true, responseBody: true), // dev only
  ]);
  return dio;
});
```

After this, every API source just takes `Dio` as a constructor parameter and never thinks about auth or logging again.

## Where logic belongs

A frequent confusion is whether transformation logic (filtering, sorting, paginating, deduplicating) belongs in the repository, the use case, or the BLoC. The rule:

**Use case** — anything driven by **business rules**:
- "Show only products in stock"
- "Sort by price ascending"
- "Hide users blocked by the current user"
- "Apply the user's preferred currency before returning prices"

Implement business filters with `result.map((list) => list.where(...).toList())` so the failure branch passes through untouched.

**Repository** — anything driven by **data infrastructure**:
- "If API fails, fall back to cache" (offline-first only)
- "Try API1, then API2 if it 404s"
- "Convert UserModel to User"
- "Catch DioException and throw ServerFailure"

If you find yourself writing `where(...)` or `sort(...)` in a repository, that's a smell. Move it to a use case.

**Presentation (BLoC/widget)** — anything driven by **UI concerns**:
- UI-only pagination (show first 20, lazy-load the rest as the user scrolls)
- Formatting `DateTime` for display
- Mapping `Failure` to a localized human string
- Debounce/throttle of user input

## Dependency injection

Use `get_it` (often with `injectable` for codegen). Wire dependencies in `app/injection.dart` so each layer can be swapped or mocked in tests.

```dart
final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => UserBloc(getUser: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetUser(sl()));

  // Repository (default: single source)
  sl.registerLazySingleton<IUserRepository>(
    () => UserRepository(apiSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<IUserApiSource>(() => UserApiSource(sl()));

  // Core (Dio with interceptors registered above)
  // ... etc
}
```

## Standard package set

Unless the project specifies otherwise, default to:

- `flutter_bloc` — state management
- `equatable` — value equality
- `dartz` (or `fpdart`) — `Either<Failure, T>` for typed errors
- `get_it` + `injectable` — dependency injection
- `dio` — HTTP client
- `freezed` — for unions/sealed classes when modeling states or events (optional but excellent)
- `mocktail` + `bloc_test` — testing

Add as needed:

- `bloc_concurrency` + `stream_transform` — when a BLoC needs **debounce**, **throttle**, or **droppable** event handling (search-as-you-type, button mash protection)
- `hive` / `shared_preferences` / `sqflite` — local storage (only when caching is required)
- `connectivity_plus` + `internet_connection_checker` — for `INetworkInfo` (only with offline-first)
- `uuid` — for client-generated IDs (only with offline-first optimistic writes)

## Common mistakes to avoid

- **Importing Flutter or Dio inside `domain/`.** The domain must build on its own. If you wrote `import 'package:flutter/material.dart';` in a use case or entity, that's a bug.
- **Using models in the presentation layer.** Repositories return entities (or `Either<Failure, Entity>`). The presentation layer should never see `UserModel`, `fromJson`, or HTTP types.
- **Skipping the repository interface.** "We only have one data source" isn't a reason — the interface costs nothing and unblocks testing.
- **Cramming logic into the BLoC.** BLoCs orchestrate; they shouldn't decide. Business rules live in use cases.
- **Throwing exceptions across layers.** Convert exceptions to `Failure`s at the repository boundary.
- **One mega use case.** Each use case does one thing. `UserService.doEverything()` is not a use case.
- **Putting routing inside features.** App-wide routes belong in `app/routes/`, not inside `features/<x>/presentation/`.
- **Auth tokens read inside the widget or api source.** Use a Dio interceptor, configured once.
- **Loading state on every refresh.** That causes UI flicker. See the flicker-free pattern in `references/state_management.md`.

## When to deviate

This pattern is overkill for tiny apps (a 2-screen prototype, a personal utility). For those, a single-layer Provider/Riverpod setup is faster and clearer. Reach for full Clean Architecture when:

- The app has real business rules, not just CRUD on an API
- Multiple data sources need to coexist (API + cache + offline)
- The team is more than one person
- The project is expected to live more than a few months

If the user's project is small or experimental, mention this tradeoff before scaffolding the full layer cake.

## Workflow: scaffolding a new feature

1. Confirm the feature name and the entity/entities involved.
2. Ask which state management lib the project uses (BLoC, Cubit, Riverpod, etc.) if not obvious from existing code.
3. **Ask whether the feature needs offline support.** Default to no — pull in the offline-first pattern only on request.
4. Create the folder structure under `lib/features/<feature>/` with `domain/`, `data/`, `presentation/`. Generate only the data sources you'll actually use.
5. Build outward from domain → data → presentation. Don't write the page first.
6. Update `app/injection.dart` to register the new dependencies.
7. Add the route to `app/routes/`.
8. Generate at least one test file (use case test is the highest-leverage starting point — pure logic, single mock).

## Workflow: refactoring legacy code

When handed an existing widget that does too much (HTTP + JSON + business rules + UI all in one file), don't rewrite top-down. Walk through this checklist:

**Diagnose** — read the widget and tag each block with the layer it belongs to:
- Direct HTTP calls or `jsonDecode` → data layer
- `Map<String, dynamic>` flowing through state → missing entity
- `where(...)`, `sort(...)`, business filters in the widget → use case
- Auth tokens read with `SharedPreferences` in the widget → core service / Dio interceptor
- `setState` with multiple boolean flags (`isLoading`, `error`, `data`) → BLoC/Cubit with sealed states
- Generic `catch (e)` → missing typed `Failure`s

**Extract in this order** (each step is independently committable):

1. **Entity** — define the typed object the UI actually consumes. Stop passing `Map<String, dynamic>`.
2. **Model + API source** — pull HTTP and JSON out of the widget into a `*_api_source.dart` and `*_model.dart`.
3. **Repository + interface** — wrap the source. Convert exceptions to `Failure`s.
4. **Use case(s)** — move the `where`/`sort`/business-rule code from the widget into a use case.
5. **BLoC + sealed states** — replace `setState` flags with typed states.
6. **Shrink the widget** — convert to `StatelessWidget`, replace `setState` with `BlocBuilder` or `BlocConsumer`.
7. **Wire DI** — register everything in `app/injection.dart`.
8. **Cross-cutting cleanup** — if multiple features were duplicating auth/logging, hoist to a Dio interceptor.

A widget that started at 80+ lines doing five things should end up under 40 lines doing one thing: rendering state.

## Reference files

For deeper detail on specific patterns, see:

- `references/state_management.md` — BLoC vs Cubit vs Riverpod vs Provider trade-offs and templates; debounce/throttle event transformers; flicker-free updates; optimistic UI pattern
- `references/testing.md` — How to test each layer (use case, repository, bloc, widget)
- `references/folder_template.md` — Copy-paste folder skeleton for a new feature
- `references/offline_first.md` — **Optional** offline-first repository pattern: cache + connectivity-aware reads, optimistic local writes with UUIDs, sync queue, NetworkInfo service. Read only when the user explicitly asks for offline support.
