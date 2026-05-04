# Widget Extraction Rules (MANDATORY)

The user dislikes long files. Mirror TeeShot's pattern strictly.

## File length budget

- **Page files (`*_page.dart`)**: target ≤ 200 lines. Hard ceiling: 300 lines.
- **Widget files**: target ≤ 150 lines. Hard ceiling: 200 lines.
- **State** (`StatefulWidget`'s `_State` class) lives in the page. Pure layout/visual sub-trees move to widget files.

When you exceed the target, extract.

## Folder layout

Every screen feature follows this structure:

```
lib/app/presentation/<feature>/
├── <feature>_page.dart              # Coordinator — state, scaffold, lays out sections
├── bloc/                            # If the feature has its own BLoC
│   ├── <feature>_bloc.dart
│   ├── <feature>_event.dart
│   └── <feature>_state.dart
└── widgets/
    ├── <section_a>.dart             # One widget per visual section
    ├── <section_b>.dart
    └── <complex_subsection>/        # Subfolder when one section has many sub-widgets
        ├── <sub_widget_1>.dart
        ├── <sub_widget_2>.dart
        └── <sub_model>.dart         # UI-only models live next to their widgets
```

The page imports the widgets and composes them. The page does NOT define visual sub-trees inline beyond a thin coordinator-level Scaffold + Sliver list.

## What goes where

| Where | What |
|---|---|
| `lib/app/shared/widgets/` | Reusable across ≥2 features. Generic primitives like `CircleIconButton`, `SectionHeader`, `PillChip`, `CustomLoading`, `EditActionsRow`. |
| `lib/app/presentation/<feature>/widgets/` | Widget that only this feature uses but the page composes from many of these. |
| `lib/app/presentation/<feature>/widgets/<subgroup>/` | When one widget itself has 3+ sub-widgets (e.g. `match_card/` containing `score_row`, `odds_cell`, `pick_pill`). |

## Reusability triage — done EVERY time before writing a widget inline

Before writing a private `_FooBar` widget inline:

1. **Search shared first** — `ls lib/app/shared/widgets/`. If something close exists, use or extend it.
2. **Will another feature use this?** If yes → put it in `shared/widgets/` from the start.
3. **Is it pure presentation?** Move it to `widgets/`. Only logic-coupled widgets stay private to the page.
4. **Will it be ≥ 30 lines?** Extract to its own file even if currently page-private.

If you wrote three `_PrivateWidget` classes in the same page that have similar structure (e.g. three list-row variants), STOP and extract a single parameterized widget to `shared/widgets/`.

## Naming

- File name = main class name in snake_case: `match_card.dart` → `class MatchCard`.
- Make the class **public** (no `_` prefix) when it lives in its own file. Private `_FooBar` is only for tiny helpers that stay inside the same file with their parent.
- UI-only models that live next to their widget: `odds_value.dart` → `class OddsValue { ... }` (no annotations needed for static mock data).

## Example of the discipline (from TeeShot)

`round_page.dart` is 773 lines but every visual section was extracted:

```
round/
├── round_page.dart                 # 773 lines — state mgmt, scroll controller, AI chat overlay
├── round_page_helpers.dart         # 67 lines — pure functions, format helpers
├── round_page_recommend.dart       # extracted recommend-shot section
├── round_page_shot_actions.dart    # extracted shot actions
├── bloc/
└── widgets/
    ├── ai/                         # AI caddy widgets
    ├── map/                        # GPS map widgets
    ├── overlay/
    ├── scoring/                    # score_bar, score_entry_sheet, scorecard_sheet
    ├── shot/
    ├── toolbar/
    └── tutorial/
```

The page is still long because it owns complex async state, but every visual sub-tree has its own file.

## What this rule replaces

- **No more single-file 700-line pages with 12 private `_FooBar` widget classes.** That style is forbidden, even if it analyzes clean.
- **No more inline `Container(decoration: BoxDecoration(...))` blocks with nested children > 30 lines** without extracting them.

## When you are done

After completing a feature, run:

```bash
wc -l lib/app/presentation/<feature>/*.dart lib/app/presentation/<feature>/widgets/**/*.dart
```

If any file exceeds the budget, extract before declaring the task complete.
