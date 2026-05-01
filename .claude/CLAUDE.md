# PlayBook App — Claude Code Instructions

## Project context
Flutter mobile app (iOS + Android, web optional) that consumes **PlayBookApi** (sibling Django REST + WebSocket service at `../../PlayBook/PlayBookApi`).

Product: sports prediction tips. Users browse upcoming matches per league/sport, see machine-generated picks with LLM-explained reasoning, follow leagues, save predictions, get push notifications.

**No money handling.** No wallets, no real bets — only tips with explanations. Built so it can pivot to a paid premium tier later (RevenueCat) without a license issue.

**Cuba-friendly stack** — same constraint as the backend:
- Auth via Google's `/oauth2/v3/userinfo` (the `google_sign_in` client package; **NO** `firebase_auth`)
- Email/password also supported
- Push: `firebase_messaging` package (Android requires Google Play Services; users without GPS won't receive push — accepted tradeoff)

## Tech stack (mirror TeeShot, with PlayBook deltas)

| Concern | Package |
|---|---|
| State management | `flutter_bloc` + `freezed` (events + state) |
| Navigation | `go_router` |
| DI | `get_it` + `injectable` (codegen) |
| HTTP | `dio` + `retrofit` (codegen) |
| Models | `freezed_annotation` + `json_annotation` (codegen) |
| Env config | `envied` (codegen) |
| Functional errors | `fpdart` (`Either`, `Option`) |
| Theme | Material 3, platform-aware typography (SF Pro on iOS, Nunito on Android), `responsive_framework` |
| Push | `firebase_messaging` (NO firebase_auth, NO firebase_core extras) |
| Google login | `google_sign_in` (NO firebase_auth) |
| Monitoring | `sentry_flutter` |
| Asset constants | `spider` |

## Layer layout (TeeShot flavor)

```
lib/
├── main.dart               # Entry: BlocProviders + MaterialApp.router + Sentry
├── di.dart / di.config.dart  # GetIt + Injectable codegen
├── env.dart / env.g.dart   # Envied (.env)
├── phoenix.dart            # Restart wrapper (logout / env switch)
├── app/                    # Application layer (orchestration)
│   ├── router.dart         # GoRouter w/ AuthBloc redirect listenable
│   ├── bloc/               # Global BLoCs (auth, theme)
│   ├── presentation/       # Pages by feature
│   │   ├── auth/
│   │   ├── matches/
│   │   ├── predictions/
│   │   └── ...
│   └── shared/widgets/
├── data/
│   ├── api/                # rest_client.dart (Retrofit), interceptors, error handling
│   ├── constants/          # api.dart base URLs
│   ├── entities/           # API DTOs (Freezed + JsonSerializable)
│   ├── repository/         # Repository implementations (@LazySingleton)
│   ├── service/            # Storage, secrets, websocket
│   └── utils/
├── device/
│   ├── router/             # PageTransitions, RouterManager, Observer
│   ├── theme/              # AppTheme, AppColor, AppTextStyle
│   └── helpers/
├── domain/
│   ├── entities/           # Domain entities (Freezed, immutable)
│   └── repository/         # Abstract repository interfaces
└── resources/              # Spider-generated asset constants
```

`domain/` is pure Dart — never imports `data/`, `device/`, `app/`, or Flutter.

## Auth flow (Cuba pattern, dlujo-style)

The backend (`PlayBookApi/api/v1/auth/token/`) accepts:
```json
{ "username": "<email or empty>", "password": "<pw or google access_token>",
  "provider": "password" | "google" | "apple", "platform": "ANDROID" | "IOS" }
```
And returns `{ access, refresh, user }` (JWT pair + nested user/profile).

Flutter responsibilities:
1. Email/password: collect creds → POST with `provider=password`.
2. Google: `google_sign_in` → obtain `accessToken` → POST with `provider=google`, `password=<accessToken>`.
3. Always include `X-Api-Key` header on every request (built into Retrofit interceptor).
4. Store `access` in memory + `refresh` in `flutter_secure_storage`. On 401 → refresh via `/api/v1/auth/token/refresh/`. On refresh failure → trigger logout (clear secure storage + go to login).

`X-Api-Key` is configured via `envied` from `.env` so the same APK can target dev/prod.

## API connectivity

- Base URL via `envied`. Dev default: `http://10.0.2.2:18002` (Android emulator → host) or `http://localhost:18002` (web/iOS sim).
- All `/api/v1/*` endpoints require `Authorization: Bearer <jwt>` AND `X-Api-Key`. Retrofit interceptors handle both automatically.
- WebSocket: `ws://<host>:18002/ws/matches/?sport=<key>&token=<jwt>` — `web_socket_channel`.

## iOS HIG compliance (mandatory)

Same as TeeShot. See `.claude/rules/architecture.md` and `.claude/rules/widget-standards.md` — shared with this project intentionally.

Highlights:
- Mandatory `SafeArea` on every page.
- Adaptive widgets via `.adaptive()` constructors.
- Touch targets ≥ 44×44pt.
- Platform check via `defaultTargetPlatform`, never `dart:io Platform`.
- Navigation via `PageTransitions.platformTransition()` (Cupertino on iOS, fade on Android).
- No FAB on iOS, elevation 0 on iOS (theme-driven).

## When the skill (flutter-clean-architecture) and TeeShot patterns conflict

**TeeShot wins.** The skill describes the "by the book" `core/` + `features/<name>/{domain,data,presentation}` layout. We are NOT using that layout. We use TeeShot's `app/`, `data/`, `device/`, `domain/`. Specifically:

| Skill says | We do |
|---|---|
| `lib/features/<name>/domain/usecases/get_user.dart` | NO use-case classes by default. Repositories are called directly from BLoCs. (Add use cases later if logic grows.) |
| `IUserRepository` (I prefix) | `IUserRepository` ← **same**, we keep the `I` prefix. |
| `lib/features/<name>/data/sources/user_api_source.dart` | API endpoints are centralized in `data/api/rest_client.dart` with Retrofit annotations. No per-feature `*_api_source.dart`. |
| `core/utils/generics/usecase.dart` | Skipped unless we explicitly add use cases. |
| `dartz` for `Either` | We use `fpdart`. Same idea, slightly different API. |
| `equatable` for value equality | Freezed handles it; we don't add `equatable` separately. |
| Failures (sealed `Failure` hierarchy in `core/errors/`) | We have `AppError` in `data/api/` — slightly different name and lives in data layer, not core. |

The skill is stocked as a reference for general patterns (BLoC structure, presentation patterns, debounce/throttle, optimistic UI, testing). When TeeShot has its own opinion, follow TeeShot.

## Workflow conventions

1. **Codegen** — after adding `@freezed`, `@injectable`, or `@JsonSerializable`, run:
   ```
   dart run build_runner build --delete-conflicting-outputs
   ```
2. **Adding a new screen** — create the BLoC under `app/presentation/<feature>/bloc/`, the page under `app/presentation/<feature>/`, and register the route in `app/router.dart`.
3. **Adding a new endpoint** — add the method to `data/api/rest_client.dart` with the `@GET`/`@POST` Retrofit annotation, regen, then call it from a Repository implementation.
4. **Adding a new repository** — interface in `domain/repository/`, impl in `data/repository/`, annotated with `@LazySingleton(as: IXxxRepository)`. Run build_runner.
5. **Asking the user** — when the skill defaults clash with TeeShot, ALWAYS prefer TeeShot. When neither dictates (new decision), ASK.

## Things to skip vs TeeShot

TeeShot has features we don't need: golf rounds, GPS shots, AI caddy chat, RevenueCat subscriptions, geolocator, just_audio, image_picker, google_maps_flutter, flutter_slidable, web_socket_channel + stream_transform for chat streaming, etc. Cherry-pick from `pubspec.yaml` only what PlayBook needs.

## Things we add that TeeShot doesn't have

- **Internal API key** in env (the `X-Api-Key` for the PlayBookApi mobile app, generated by `seed_api_keys` on the backend).
- **`web_socket_channel`** — for live match score updates (`/ws/matches/`).
- **Predictions feature** — entirely new, no equivalent in TeeShot.
