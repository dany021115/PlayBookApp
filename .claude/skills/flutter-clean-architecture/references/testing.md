# Testing each layer

Clean Architecture's main payoff is testability. Each layer has its own test strategy.

## What to test where

| Layer | Test type | What to mock | Tools |
|-------|-----------|--------------|-------|
| Use case | Unit | Repository | `mocktail`, `test` |
| Repository | Unit | Data sources, NetworkInfo | `mocktail`, `test` |
| Data source | Unit (or integration) | HTTP client / DB | `mocktail`, `test`, `dio_mock` |
| BLoC/Cubit | Unit | Use cases | `bloc_test`, `mocktail` |
| Page/Widget | Widget | BLoC (provide a fake) | `flutter_test`, `bloc_test` |

## Use case test

The simplest layer to test — pure logic, single dependency.

```dart
class MockUserRepository extends Mock implements IUserRepository {}

void main() {
  late GetUser usecase;
  late MockUserRepository repository;

  setUp(() {
    repository = MockUserRepository();
    usecase = GetUser(repository);
  });

  const tUser = User(id: '1', name: 'Ada', email: 'ada@example.com');

  test('returns user from repository', () async {
    when(() => repository.getUser('1')).thenAnswer((_) async => const Right(tUser));

    final result = await usecase('1');

    expect(result, const Right(tUser));
    verify(() => repository.getUser('1')).called(1);
    verifyNoMoreInteractions(repository);
  });
}
```

## Repository test

Cover the connectivity branches: online → API + cache, offline → cache only, both error paths.

```dart
void main() {
  late UserRepository repository;
  late MockUserApiSource apiSource;
  late MockUserLocalSource localSource;
  late MockNetworkInfo networkInfo;

  setUp(() {
    apiSource = MockUserApiSource();
    localSource = MockUserLocalSource();
    networkInfo = MockNetworkInfo();
    repository = UserRepository(
      apiSource: apiSource,
      localSource: localSource,
      networkInfo: networkInfo,
    );
  });

  group('getUser', () {
    const tUserModel = UserModel(id: '1', name: 'Ada', email: 'ada@example.com');

    test('online: returns api result and caches it', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => apiSource.getUser('1')).thenAnswer((_) async => tUserModel);
      when(() => localSource.cacheUser(any())).thenAnswer((_) async {});

      final result = await repository.getUser('1');

      expect(result, const Right<Failure, User>(tUserModel));
      verify(() => localSource.cacheUser(tUserModel)).called(1);
    });

    test('offline: returns cached user', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);
      when(() => localSource.getCachedUser('1')).thenAnswer((_) async => tUserModel);

      final result = await repository.getUser('1');

      expect(result, const Right<Failure, User>(tUserModel));
      verifyNever(() => apiSource.getUser(any()));
    });

    test('online + server error: returns ServerFailure', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => apiSource.getUser('1')).thenThrow(ServerException());

      final result = await repository.getUser('1');

      expect(result, Left<Failure, User>(ServerFailure()));
    });
  });
}
```

## BLoC test

Use `bloc_test` for tidy "given event → expected states" assertions.

```dart
class MockGetUser extends Mock implements GetUser {}

void main() {
  late MockGetUser getUser;

  setUpAll(() {
    registerFallbackValue('');
  });

  setUp(() {
    getUser = MockGetUser();
  });

  const tUser = User(id: '1', name: 'Ada', email: 'ada@example.com');

  blocTest<UserBloc, UserState>(
    'emits [Loading, Loaded] when use case succeeds',
    build: () {
      when(() => getUser(any())).thenAnswer((_) async => const Right(tUser));
      return UserBloc(getUser: getUser);
    },
    act: (bloc) => bloc.add(const UserRequested('1')),
    expect: () => [UserLoading(), const UserLoaded(tUser)],
    verify: (_) => verify(() => getUser('1')).called(1),
  );

  blocTest<UserBloc, UserState>(
    'emits [Loading, Error] when use case fails',
    build: () {
      when(() => getUser(any())).thenAnswer((_) async => Left(ServerFailure()));
      return UserBloc(getUser: getUser);
    },
    act: (bloc) => bloc.add(const UserRequested('1')),
    expect: () => [UserLoading(), const UserError('Server error')],
  );
}
```

## Widget test

Don't talk to real BLoCs — provide a stubbed one.

```dart
class MockUserBloc extends MockBloc<UserEvent, UserState> implements UserBloc {}

void main() {
  late MockUserBloc bloc;

  setUp(() {
    bloc = MockUserBloc();
  });

  testWidgets('shows loading then user', (tester) async {
    whenListen(
      bloc,
      Stream.fromIterable([
        UserLoading(),
        const UserLoaded(User(id: '1', name: 'Ada', email: 'ada@example.com')),
      ]),
      initialState: UserInitial(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserBloc>.value(
          value: bloc,
          child: const UserPage(userId: '1'),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump();
    expect(find.text('Ada'), findsOneWidget);
  });
}
```

## Folder layout for tests

Mirror the lib structure:

```
test/
├── core/
├── features/
│   └── user/
│       ├── data/
│       │   ├── models/
│       │   ├── repositories/
│       │   └── sources/
│       ├── domain/
│       │   └── usecases/
│       └── presentation/
│           ├── bloc/
│           └── pages/
└── helpers/
    ├── test_helper.dart        # registerFallbackValue calls, common setup
    └── fixture_reader.dart     # loads JSON fixtures from test/fixtures/
```

## What NOT to test

- Private methods directly. Test them through the public API.
- Generated code (`*.g.dart`, `*.freezed.dart`). The generator is already tested.
- Trivial getters that just return a field.
- Flutter framework behavior (e.g. that `Text` actually renders text).
