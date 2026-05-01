# Folder skeleton for a new feature

Copy this layout when adding a feature to a project that already follows the architecture. Replace `<feature>` with the feature name (snake_case) and `<Entity>` with the primary entity (PascalCase). Skip files you don't need (e.g. drop `firestore_source.dart` if Firestore isn't used).

## Skeleton

```
lib/features/<feature>/
├── domain/
│   ├── entities/
│   │   └── <entity>.dart
│   ├── repositories/
│   │   └── i_<entity>_repository.dart
│   └── usecases/
│       ├── get_<entity>.dart
│       ├── get_all_<entity>s.dart
│       ├── create_<entity>.dart
│       ├── update_<entity>.dart
│       └── delete_<entity>.dart
│
├── data/
│   ├── models/
│   │   └── <entity>_model.dart
│   ├── repositories/
│   │   └── <entity>_repository.dart
│   └── sources/
│       ├── <entity>_api_source.dart
│       ├── <entity>_local_source.dart
│       └── <entity>_firestore_source.dart   (optional)
│
└── presentation/
    ├── bloc/
    │   ├── <entity>_bloc.dart
    │   ├── <entity>_event.dart
    │   └── <entity>_state.dart
    ├── pages/
    │   ├── <entity>_list_page.dart
    │   └── <entity>_detail_page.dart
    └── components/
        └── <entity>_card.dart
```

For the test mirror, see `references/testing.md`.

## Order of creation

Build inside-out so each layer compiles against types that already exist:

1. `domain/entities/<entity>.dart`
2. `domain/repositories/i_<entity>_repository.dart`
3. `domain/usecases/*.dart` (one file per action)
4. `data/models/<entity>_model.dart`
5. `data/sources/*.dart` (abstract first, then impl)
6. `data/repositories/<entity>_repository.dart`
7. `presentation/bloc/*.dart` (state, event, then bloc)
8. `presentation/pages/*.dart` and `components/*.dart`
9. Register everything in `app/injection.dart`
10. Add routes in `app/routes/`

## DI registration block

Append a feature-specific block to `injection.dart`:

```dart
Future<void> _init<Feature>() async {
  // Bloc — factory so a fresh one is created per page
  sl.registerFactory(() => <Entity>Bloc(
        get<Entity>: sl(),
        getAll<Entity>s: sl(),
        create<Entity>: sl(),
        update<Entity>: sl(),
        delete<Entity>: sl(),
      ));

  // Use cases — lazy singletons
  sl.registerLazySingleton(() => Get<Entity>(sl()));
  sl.registerLazySingleton(() => GetAll<Entity>s(sl()));
  sl.registerLazySingleton(() => Create<Entity>(sl()));
  sl.registerLazySingleton(() => Update<Entity>(sl()));
  sl.registerLazySingleton(() => Delete<Entity>(sl()));

  // Repository
  sl.registerLazySingleton<I<Entity>Repository>(
    () => <Entity>Repository(
      apiSource: sl(),
      localSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<I<Entity>ApiSource>(() => <Entity>ApiSource(sl()));
  sl.registerLazySingleton<I<Entity>LocalSource>(() => <Entity>LocalSource(sl()));
}
```

Then call `_init<Feature>()` from the global `init()` after registering core services (Dio, NetworkInfo, storage).

## Route registration (GoRouter example)

```dart
GoRoute(
  path: '/<feature>',
  builder: (_, __) => const <Entity>ListPage(),
  routes: [
    GoRoute(
      path: ':id',
      builder: (_, state) => <Entity>DetailPage(id: state.pathParameters['id']!),
    ),
  ],
),
```

## Minimum viable feature

If full CRUD is overkill, the smallest valid slice is:

- 1 entity
- 1 repository interface + impl
- 1 data source
- 1 use case
- 1 BLoC/Cubit + state
- 1 page

Don't skip the repository interface even for read-only single-source features — it's what keeps the domain testable.
