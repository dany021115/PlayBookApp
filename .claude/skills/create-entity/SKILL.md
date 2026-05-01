---
name: create-entity
description: Creates a Freezed entity with JsonSerializable. Usage - /create-entity EntityName [domain|data]
allowed-tools: Read, Write, Edit, Bash, Glob
---

# Create Entity

Create an entity named "$ARGUMENTS" using Freezed + JsonSerializable.

Parse the arguments:
- First argument: Name in PascalCase (e.g.: "Match")
- Second argument (optional): "domain" or "data" (default: "domain")

Derive:
- PascalCase: `Match`
- snake_case: `match`

## Location

- If **domain**: `lib/domain/entities/{snake_case}.dart`
- If **data**: `lib/data/entities/{snake_case}.dart`

## Create File

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '{snake_case}.freezed.dart';
part '{snake_case}.g.dart';

@freezed
class {PascalCase} with _${PascalCase} {
  const factory {PascalCase}({
    required String id,
    // TODO: Add fields
  }) = _{PascalCase};

  factory {PascalCase}.fromJson(Map<String, dynamic> json) => _${PascalCase}FromJson(json);
}
```

## Considerations

- If it's a **data** entity (DTO), fields must map to the API JSON (snake_case via build.yaml)
- If it's a **domain** entity, fields represent business logic
- Remember that `build.yaml` already configures `field_rename: snake` and `explicit_to_json: true`
- For fields with different names in JSON, use `@JsonKey(name: 'api_field_name')`
- For optional fields, use `@Default(value)` or nullable type `String?`
- For lists, use `@Default([]) List<Type> field`
- For enums, create the enum separately and Freezed serializes it automatically

### Example with common fields:

```dart
@freezed
class Match with _$Match {
  const factory Match({
    required String id,
    required String sport,
    required String league,
    required String homeTeam,
    required String awayTeam,
    @Default(0) int homeScore,
    @Default(0) int awayScore,
    DateTime? startsAt,
    @Default('scheduled') String status, // scheduled | live | finished
  }) = _Match;

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);
}
```

### Example with enum:

```dart
enum PredictionStatus { pending, won, lost, voided }

@freezed
class Prediction with _$Prediction {
  const factory Prediction({
    required String id,
    required String matchId,
    @Default(PredictionStatus.pending) PredictionStatus status,
  }) = _Prediction;

  factory Prediction.fromJson(Map<String, dynamic> json) => _$PredictionFromJson(json);
}
```

## If Custom Methods Are Needed

Add an empty private constructor to enable methods/getters:

```dart
@freezed
class Match with _$Match {
  const Match._(); // Enables custom methods

  const factory Match({
    required String id,
    required int homeScore,
    required int awayScore,
    required String status,
  }) = _Match;

  // Custom getter
  bool get isLive => status == 'live';
  int get totalGoals => homeScore + awayScore;

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);
}
```

## Code Generation

Run:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Verification

```bash
flutter analyze
```

## Remove .gitkeep

If the target folder had a `.gitkeep`, remove it after creating the file:
```bash
rm lib/{domain|data}/entities/.gitkeep 2>/dev/null || true
```
