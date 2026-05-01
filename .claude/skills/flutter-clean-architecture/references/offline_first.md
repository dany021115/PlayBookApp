# Offline-first repository pattern (OPTIONAL)

This is an **opt-in extension** to the standard repository pattern in `SKILL.md`. Read it only when the user explicitly asks for offline support — don't apply it by default.

## When to opt in

Choose offline-first when:

- Users expect the app to work without connectivity (Cuban context, transit, rural, anywhere with intermittent internet)
- Immediate UI feedback matters more than guaranteed-fresh data
- The data is user-specific and reconcilable (favorites, drafts, read/unread status)
- A short stale-data window is acceptable

Choose standard (online-only) when:

- Data freshness is critical (banking balances, live scores, ride-hailing positions)
- Conflicts are expensive (collaborative editing, inventory)
- The team can't pay the cache-invalidation tax right now

When in doubt, start online-only. Adding offline later is a refactor; ripping it out is harder.

## What changes vs the default repository

The default repository in `SKILL.md` has one collaborator:

```dart
class UserRepository implements IUserRepository {
  final IUserApiSource apiSource;
  UserRepository({required this.apiSource});
  // ...
}
```

The offline-first version has three:

```dart
class UserRepository implements IUserRepository {
  final IUserApiSource apiSource;
  final IUserLocalSource localSource;
  final INetworkInfo networkInfo;
  UserRepository({required this.apiSource, required this.localSource, required this.networkInfo});
  // ...
}
```

The repository now has to decide which source to read from, when to cache, and how to handle the offline case gracefully.

## Read pattern

```dart
@override
Future<Either<Failure, User>> getUser(String id) async {
  if (await networkInfo.isConnected) {
    try {
      final remote = await apiSource.getUser(id);
      await localSource.cacheUser(remote);
      return Right(remote);
    } on ServerException {
      return _readCache(id); // Graceful fallback
    }
  }
  return _readCache(id);
}

Future<Either<Failure, User>> _readCache(String id) async {
  try {
    return Right(await localSource.getCachedUser(id));
  } on CacheException {
    return Left(CacheFailure());
  }
}
```

The fallback-to-cache-on-server-error is debatable — some apps want hard failures so users see "couldn't refresh" instead of stale data silently. Decide per feature.

## Write pattern (optimistic)

Optimistic writes update local state immediately, then push to the server in the background. The user sees the change instantly; sync catches up.

```dart
@override
Future<Either<Failure, Favorite>> toggleFavorite({
  required String userId,
  required String productId,
}) async {
  try {
    final existing = await localSource.findByProduct(userId, productId);

    if (existing != null) {
      // Toggle off: delete locally + remotely
      await localSource.removeFavorite(existing.id);
      if (await networkInfo.isConnected) {
        try {
          await apiSource.removeFavorite(userId: userId, productId: productId);
        } on ServerException {
          // Will reconcile on next sync
        }
      }
      return Right(existing);
    }

    // Toggle on: optimistic insert with client-generated UUID
    final localFav = FavoriteModel(
      id: uuid.v4(),
      productId: productId,
      userId: userId,
      addedAt: DateTime.now(),
      syncedWithRemote: false,
    );
    await localSource.upsertFavorite(localFav);

    if (await networkInfo.isConnected) {
      try {
        final remote = await apiSource.addFavorite(userId: userId, productId: productId);
        // Replace local-only record with the server-blessed one
        await localSource.removeFavorite(localFav.id);
        await localSource.upsertFavorite(remote);
        return Right(remote);
      } on ServerException {
        return Right(localFav); // Queued for sync
      }
    }
    return Right(localFav);
  } on CacheException {
    return Left(CacheFailure());
  }
}
```

## Client-generated IDs (UUID)

Optimistic writes need an ID before the server has assigned one. Use `uuid` v4:

```yaml
dependencies:
  uuid: ^4.0.0
```

```dart
final uuid = Uuid();
final id = uuid.v4(); // 550e8400-e29b-41d4-a716-446655440000
```

When the server responds with its real ID, replace the local record. The model needs a `syncedWithRemote` flag (or equivalent) so the sync queue knows what hasn't been pushed yet.

## NetworkInfo service

A small abstraction in `core/services/`:

```dart
// lib/core/services/i_network_info.dart
abstract class INetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get connectionChanges;
}
```

```dart
// lib/core/services/network_info.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkInfo implements INetworkInfo {
  final InternetConnectionChecker checker;
  final Connectivity connectivity;
  NetworkInfo({required this.checker, required this.connectivity});

  @override
  Future<bool> get isConnected => checker.hasConnection;

  @override
  Stream<bool> get connectionChanges =>
      connectivity.onConnectivityChanged.asyncMap((_) => isConnected);
}
```

Two checks because `connectivity_plus` only tells you if there's an interface up — it can't tell you if that interface actually reaches the internet (captive portals, "Wi-Fi without internet"). `internet_connection_checker` pings real hosts.

## Sync strategy

Two ways to trigger a sync:

1. **Manual** — pull-to-refresh, app foregrounded, "Sync now" button
2. **Automatic** — subscribe to `INetworkInfo.connectionChanges`, fire sync on offline → online transitions

Implement sync as its own use case:

```dart
class SyncFavorites implements UseCase<void, String> {
  final IFavoriteRepository repository;
  SyncFavorites(this.repository);

  @override
  Future<Either<Failure, void>> call(String userId) => repository.syncFavorites(userId);
}
```

The repository iterates `getUnsyncedFavorites(userId)` and pushes each one, marking success or skipping on failure for the next attempt.

## Conflict resolution

For most consumer apps, **last-write-wins** on the server is good enough. The client sends the local timestamp; the server picks newer. Document this clearly so users aren't surprised.

For collaborative editing or inventory, you need CRDTs or operational transform — that's beyond Clean Architecture and out of scope for this skill.

## Trade-offs you accept

- **More code** — every repository method has online and offline branches
- **More tests** — must cover both branches plus the error paths
- **Cache invalidation** — when does cached data become stale enough to discard? There's no universal answer
- **Ambiguous error states** — "Did my favorite save?" is now "locally yes, remotely TBD"
- **Schema migrations** — local cache schema changes need migration code, like a real database

If those costs aren't worth it for the feature in question, stick with the online-only default.

## DI registration

```dart
// In app/injection.dart, when offline-first is enabled
sl.registerLazySingleton<IUserRepository>(
  () => UserRepository(
    apiSource: sl(),
    localSource: sl(),
    networkInfo: sl(),
  ),
);

sl.registerLazySingleton<IUserLocalSource>(
  () => UserLocalSource(sl<Box<Map>>()), // Hive box, opened in init()
);

sl.registerLazySingleton<INetworkInfo>(
  () => NetworkInfo(checker: sl(), connectivity: sl()),
);

sl.registerLazySingleton(() => InternetConnectionChecker());
sl.registerLazySingleton(() => Connectivity());
sl.registerLazySingleton(() => const Uuid());
```

## Testing offline-first

The repository now has two big branches (online + offline) and several error paths. Cover them explicitly:

- Online + API success → API result returned, cache written
- Online + API error → falls back to cache
- Offline + cache hit → cache returned, API never called
- Offline + cache miss → `CacheFailure`
- Optimistic write online → local insert, remote insert, local replaced with remote ID
- Optimistic write offline → local insert with `synced: false`, no remote call
- Sync with unsynced records → each pushed and reconciled
- Sync offline → `NetworkFailure`

See `references/testing.md` for the test patterns.
