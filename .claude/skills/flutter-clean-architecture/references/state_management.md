# State management trade-offs and templates

Read this when choosing or scaffolding state management for the Presentation layer of a Clean Architecture feature. The Domain and Data layers don't change based on this choice — only the Presentation layer does.

## Quick decision

| Library     | Best for                                                        | Boilerplate | Learning curve |
|-------------|------------------------------------------------------------------|-------------|----------------|
| **BLoC**    | Complex flows, multiple events, audit trails, large teams       | High        | Medium-high    |
| **Cubit**   | Same as BLoC but no events — direct method calls                | Medium      | Low            |
| **Riverpod**| Modern reactive patterns, compile-time safety, fine-grained rebuilds | Medium  | Medium         |
| **Provider**| Small apps, simple state, official Flutter team recommendation prior to Riverpod | Low | Low |
| **GetX**    | Avoid for new projects — couples concerns and bypasses Clean Architecture |  — | — |

Match whatever the project already uses. If starting fresh: **BLoC for complex apps, Cubit for medium, Riverpod if the team prefers a more reactive style.**

## BLoC template

```dart
// event
sealed class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object?> get props => [];
}

final class UserRequested extends UserEvent {
  final String userId;
  const UserRequested(this.userId);
  @override
  List<Object?> get props => [userId];
}

// state
sealed class UserState extends Equatable {
  const UserState();
  @override
  List<Object?> get props => [];
}

final class UserInitial extends UserState {}
final class UserLoading extends UserState {}
final class UserLoaded extends UserState {
  final User user;
  const UserLoaded(this.user);
  @override
  List<Object?> get props => [user];
}
final class UserError extends UserState {
  final String message;
  const UserError(this.message);
  @override
  List<Object?> get props => [message];
}

// bloc
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;
  UserBloc({required this.getUser}) : super(UserInitial()) {
    on<UserRequested>(_onUserRequested);
  }

  Future<void> _onUserRequested(UserRequested event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await getUser(event.userId);
    result.fold(
      (failure) => emit(UserError(_messageFor(failure))),
      (user) => emit(UserLoaded(user)),
    );
  }
}
```

`freezed` makes events/states even cleaner — adopt it if the project already uses codegen.

## Cubit template

Use when there's no need to log or replay user actions — fewer files, same separation.

```dart
class UserCubit extends Cubit<UserState> {
  final GetUser getUser;
  UserCubit({required this.getUser}) : super(UserInitial());

  Future<void> loadUser(String userId) async {
    emit(UserLoading());
    final result = await getUser(userId);
    result.fold(
      (failure) => emit(UserError(_messageFor(failure))),
      (user) => emit(UserLoaded(user)),
    );
  }
}
```

## Riverpod template

```dart
// provider for the use case (registered via DI)
final getUserProvider = Provider<GetUser>((ref) => sl<GetUser>());

// async notifier holding the state
class UserNotifier extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async => null;

  Future<void> loadUser(String userId) async {
    state = const AsyncLoading();
    final result = await ref.read(getUserProvider)(userId);
    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (user) => AsyncData(user),
    );
  }
}

final userNotifierProvider =
    AsyncNotifierProvider<UserNotifier, User?>(UserNotifier.new);
```

## Provider template

For very simple cases. `ChangeNotifier` works but loses the typed-state benefit — prefer it only for trivial features.

```dart
class UserProvider extends ChangeNotifier {
  final GetUser getUser;
  UserProvider(this.getUser);

  bool isLoading = false;
  User? user;
  String? error;

  Future<void> loadUser(String userId) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await getUser(userId);
    result.fold(
      (failure) => error = _messageFor(failure),
      (u) => user = u,
    );

    isLoading = false;
    notifyListeners();
  }
}
```

## Cross-cutting rules

- The state class never holds `UserModel`. Always the entity.
- The state machine should make impossible states unrepresentable — use sealed classes or freezed unions.
- `result.fold(left, right)` is the standard pattern for unwrapping `Either<Failure, T>`.
- Map `Failure` → user-facing string in the presentation layer (a private helper in the bloc/cubit/notifier), not in the use case.

## Event transformers (debounce, throttle, droppable)

Search-as-you-type, button-mash protection, and rate-limited APIs all need to drop or delay events. The default BLoC behavior — process every event in order — is wrong for these cases. Use `bloc_concurrency` + `stream_transform`.

```yaml
dependencies:
  bloc_concurrency: ^0.3.0
  stream_transform: ^2.1.0
```

```dart
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

EventTransformer<E> _debounce<E>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  final SearchProducts searchProducts;

  ProductSearchBloc({required this.searchProducts}) : super(const ProductSearchInitial()) {
    on<SearchQueryChanged>(
      _onQueryChanged,
      transformer: _debounce(const Duration(milliseconds: 350)),
    );
  }

  Future<void> _onQueryChanged(SearchQueryChanged e, Emitter<ProductSearchState> emit) async {
    if (e.query.trim().isEmpty) {
      emit(const ProductSearchInitial());
      return;
    }
    emit(const ProductSearchLoading());
    final result = await searchProducts(SearchProductsParams(query: e.query));
    result.fold(
      (f) => emit(ProductSearchError(_messageFor(f))),
      (products) => emit(ProductSearchLoaded(products)),
    );
  }
}
```

The `switchMap` matters as much as the `debounce` — it cancels in-flight searches when a new query arrives, so stale results never overwrite fresh ones.

Other transformers from `bloc_concurrency`:

- `restartable()` — cancel current, start new (good for searches and toggles)
- `droppable()` — ignore new events while one is in flight (good for "submit" buttons)
- `sequential()` — queue them, process one at a time (default behavior; rarely need to specify)
- `concurrent()` — fire all in parallel (rarely correct)

## Avoiding flicker on updates (Loading vs Updating)

A common BLoC anti-pattern: every refresh emits `Loading`, which causes the UI to jump back to a spinner even when there's perfectly good stale data already showing. Pull-to-refresh becomes "yank-to-flicker."

**Solution**: separate "first load" from "refresh."

```dart
sealed class FavoritesState extends Equatable {
  const FavoritesState();
  @override
  List<Object?> get props => [];
}

final class FavoritesInitial extends FavoritesState {}
final class FavoritesLoading extends FavoritesState {}    // Only on first load

final class FavoritesLoaded extends FavoritesState {
  final List<Favorite> favorites;
  final bool isUpdating;                                  // Refresh in flight
  const FavoritesLoaded(this.favorites, {this.isUpdating = false});

  FavoritesLoaded copyWith({List<Favorite>? favorites, bool? isUpdating}) =>
      FavoritesLoaded(favorites ?? this.favorites, isUpdating: isUpdating ?? this.isUpdating);

  @override
  List<Object?> get props => [favorites, isUpdating];
}

final class FavoritesError extends FavoritesState {
  final String message;
  const FavoritesError(this.message);
  @override
  List<Object?> get props => [message];
}
```

In the bloc:

```dart
Future<void> _onRequested(FavoritesRequested e, Emitter<FavoritesState> emit) async {
  // First load: real spinner
  if (state is! FavoritesLoaded) {
    emit(FavoritesLoading());
  } else {
    // Refresh: keep showing data, mark as updating
    emit((state as FavoritesLoaded).copyWith(isUpdating: true));
  }

  final result = await getFavorites(e.userId);
  result.fold(
    (f) => emit(FavoritesError(_messageFor(f))),
    (list) => emit(FavoritesLoaded(list)),
  );
}
```

In the UI, render `isUpdating` as a thin progress bar at the top, not a full-screen spinner:

```dart
BlocBuilder<FavoritesBloc, FavoritesState>(
  builder: (_, state) => switch (state) {
    FavoritesInitial() || FavoritesLoading() =>
      const Center(child: CircularProgressIndicator()),
    FavoritesLoaded(:final favorites, :final isUpdating) => Column(children: [
      if (isUpdating) const LinearProgressIndicator(),
      Expanded(child: FavoritesList(favorites: favorites)),
    ]),
    FavoritesError(:final message) => ErrorView(message: message),
  },
)
```

Same idea for toggles, deletes, and any "edit while showing" interaction — the user keeps their context.

## Optimistic UI updates (online-only)

When you're online-only but want fast UX on toggle interactions, update the UI **before** the server confirms, then revert if it fails. This gives the snappy feel of offline-first without the complexity — no cache, no sync queue, no UUIDs, no `INetworkInfo`.

**When to use:**
- Toggles (favorites, likes, bookmarks, mark as read)
- Counter increments (claps, votes, reactions)
- Reorder operations (drag to reorder)
- Anything where the user can predict the outcome

**When NOT to use:**
- Money or legally consequential actions (transfers, purchases)
- Multi-step flows where rollback is awkward
- Anything where the server's response shapes the UI in non-obvious ways

**Don't combine with offline-first.** The offline-first repo already handles this UX through `syncedWithRemote` flags. Picking one is enough.

### Pattern

```dart
Future<void> _onToggled(FavoriteToggled e, Emitter<FavoritesState> emit) async {
  // Need an existing loaded state to roll back to
  if (state is! FavoritesLoaded) return;
  final loaded = state as FavoritesLoaded;
  final originalList = loaded.favorites;

  // Optimistic update: assume success, mutate locally
  final isCurrentlyFavorite = originalList.any((f) => f.productId == e.productId);
  final optimisticList = isCurrentlyFavorite
      ? originalList.where((f) => f.productId != e.productId).toList()
      : [...originalList, _placeholder(e.productId, e.userId)];
  emit(FavoritesLoaded(optimisticList));

  // Fire the actual call
  final result = await toggleFavorite(
    ToggleFavoriteParams(userId: e.userId, productId: e.productId),
  );

  result.fold(
    (failure) {
      // Revert to the pre-toggle list
      emit(FavoritesLoaded(originalList));
      // Surface the error without yanking the user away — see "Transient errors" below
    },
    (_) {
      // Success: refetch to pick up the canonical record (real ID, server timestamp)
      add(FavoritesRequested(e.userId));
    },
  );
}

Favorite _placeholder(String productId, String userId) => Favorite(
  id: 'temp-$productId', // replaced by the refetch on success
  productId: productId,
  userId: userId,
  addedAt: DateTime.now(),
);
```

The `temp-` prefix in the placeholder ID is a convention. The `FavoriteCard` widget should key off `productId`, not the favorite's `id`, so the swap is invisible to the UI.

### Avoiding race conditions

If the user mashes the toggle button, you'll have multiple in-flight requests competing. Use `droppable()` from `bloc_concurrency`:

```dart
on<FavoriteToggled>(_onToggled, transformer: droppable());
```

`droppable()` ignores new events while one is being processed. Combined with optimistic UI, the user gets immediate visual feedback on the first tap; subsequent taps are quietly dropped until the request completes.

### Transient errors (snackbar pattern)

Emitting `FavoritesError(message)` on a failed toggle yanks the user out of the list and into an error screen — that's worse than just showing a snackbar. For one-shot errors that shouldn't replace the visible state, expose them through a side channel:

```dart
final class FavoritesLoaded extends FavoritesState {
  final List<Favorite> favorites;
  final bool isUpdating;
  final String? transientError;  // consumed once via BlocListener
  // ...
}
```

```dart
// In the page
BlocListener<FavoritesBloc, FavoritesState>(
  listenWhen: (prev, curr) =>
      curr is FavoritesLoaded && curr.transientError != null,
  listener: (context, state) {
    final msg = (state as FavoritesLoaded).transientError!;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  },
  child: /* ... */,
)
```

After emitting the error once, emit a fresh `FavoritesLoaded` with `transientError: null` so the listener doesn't re-fire on rebuilds. (Or use a separate `Stream<TransientEvent>` exposed by the bloc — both are valid; pick the simpler one for your team.)
