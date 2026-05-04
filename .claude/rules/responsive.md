# Responsive Rules (dlujo pattern)

User explicitly hates the messy "every widget calls
`ResponsiveBreakpoints.of(context)` independently and duplicates its tree
inside `if (isDesktop) ... else ...` branches" approach.

Mirror dlujo_store's pattern. Strict rules:

## 1. Resolve breakpoints ONCE per page

At the top of the page's `build()` method:

```dart
final isMobile = ResponsiveBreakpoints.of(context).isMobile;
final isDesktop = ResponsiveBreakpoints.of(context).isDesktop ||
    ResponsiveBreakpoints.of(context).largerThan(DESKTOP);
```

Compute any derived values too (column count, max width, etc.).

## 2. Pass `isMobile` down via constructor params

Every widget that branches on screen size receives `final bool isMobile;`
as a constructor field. **Do not** call
`ResponsiveBreakpoints.of(context)` inside leaf widgets — that scatters
the breakpoint logic and makes refactors painful.

```dart
class MatchesTopBar extends StatelessWidget {
  final bool isMobile;
  const MatchesTopBar({required this.isMobile, ...});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      // ...
    );
  }
}
```

For grids, pass an explicit `int columns` instead of re-computing from
breakpoints in every section.

## 3. Inline ternaries for sizes — NO intermediate variables

For values that change with breakpoint, write the ternary EXACTLY where
the value is used. **Do not** define `final scoreFs = isMobile ? 48 : 88`
at the top of `build` and reference it later — it bloats the build with
junk variables and makes the code harder to read.

```dart
// ✅ CORRECT
Text(
  homeScore,
  style: TextStyle(fontSize: isMobile ? 48 : 88, ...),
),

// ❌ WRONG — pointless variable
final scoreFs = isMobile ? 48.0 : 88.0;
Text(
  homeScore,
  style: TextStyle(fontSize: scoreFs, ...),
),
```

Even if the same `isMobile ? X : Y` ternary appears 2-3 times in the
same `build()`, repeat it inline. Variables are ONLY justified when:
- The value has a meaningful semantic name (e.g., `cardWidth` computed
  from `LayoutBuilder` constraints, not a simple ternary).
- The same expression appears 4+ times AND the ternary is long.

No `Builder`, no `LayoutBuilder` for simple size swaps.

## 4. Layout shifts: same widgets, different container

When the layout fundamentally changes (single column → two columns
side-by-side), build the SAME widget instances and feed them into a
different container — never duplicate the widget tree.

```dart
final main = <Widget>[ PickCard(...), MarketsSection(...) ];
final sidebar = <Widget>[ LiveStatsSection(...), FormSection(...) ];

return isDesktop
    ? Row(children: [
        Expanded(flex: 2, child: Column(children: main)),
        Expanded(flex: 1, child: Column(children: sidebar)),
      ])
    : Column(children: [...main, ...sidebar]);
```

ANTIPATTERN — duplicating the tree:

```dart
// DO NOT DO THIS
return isDesktop
    ? Row(children: [
        Expanded(child: Column(children: [
          PickCard(title: m.pickTitle, reasoning: m.pickReasoning, ...),
          MarketsSection(markets: m.markets, ...),
        ])),
        Expanded(child: Column(children: [
          LiveStatsSection(homePossession: m.homePossession, ...),
          FormSection(home: m.home, ...),
        ])),
      ])
    : Column(children: [
        PickCard(title: m.pickTitle, reasoning: m.pickReasoning, ...),
        MarketsSection(markets: m.markets, ...),
        LiveStatsSection(homePossession: m.homePossession, ...),
        FormSection(home: m.home, ...),
      ]);
```

## 5. No new files for responsive variants

Don't create `matches_page_desktop.dart` or `_DesktopMatchesPage` private
classes. Adapt the existing widget by adding `isMobile` / `columns` /
similar params and using ternaries inside the same `build()`.

## 6. Card grids

Use `LayoutBuilder` + `Wrap` to compute card width from `columns`:

```dart
LayoutBuilder(
  builder: (context, constraints) {
    const gap = 12.0;
    final cardWidth = columns == 1
        ? constraints.maxWidth
        : (constraints.maxWidth - gap * (columns - 1)) / columns;
    return Wrap(
      spacing: gap,
      runSpacing: gap,
      children: [
        for (final m in items)
          SizedBox(width: cardWidth, child: ItemCard(item: m)),
      ],
    );
  },
)
```

## 7. Two breakpoints by default, three when meaningful

Most widgets only need `isMobile` (true/false). Only differentiate
mobile / tablet / desktop when the design genuinely splits into three
visual modes (e.g., grid columns: 1 / 2 / 3).
