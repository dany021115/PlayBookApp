# Design System Token Reference (PlayBook)

All tokens are mirrored 1:1 from `PlayBook.pen` (Pencil design file).

## Typography — `AppTextStyle` (`lib/device/theme/typography.dart`)

Instantiate with `final styles = AppTextStyle(context);` then use semantic getters.

| Getter | Size | Weight | Color | Use for |
|--------|------|--------|-------|---------|
| `authTitle` | 22 | w800 | onSurface | Auth screen titles ("Iniciar sesión") |
| `authSubtitle` | 13 | w400 | onSurfaceVariant | Auth subtitles |
| `heroTitle` | 28 | w800 | white | Hero headlines on gradient panels |
| `heroSubtitle` | 14 | w400 | white 80% | Hero supporting copy |
| `pageTitle` | 22 | w800 | onSurface | Page headers |
| `sectionTitle` | 20 | w700 | onSurface | Section headers |
| `cardTitle` | 16 | w700 | onSurface | Card / row titles |
| `bodyText` | 14 | w400 | onSurface | Body paragraphs |
| `bodySecondary` | 13 | w400 | onSurfaceVariant | Secondary/hint text |
| `formLabel` | 12 | w600 | onSurfaceVariant | Form field labels |
| `formHint` | 14 | w400 | onSurfaceVariant 60% | Placeholder text |
| `formField` | 14 | w500 | onSurface | Field value |
| `formError` | 12 | w500 | danger | Form error messages |
| `buttonPrimary` | 14 | w600 | onPrimary | Primary button label |
| `buttonSecondary` | 14 | w600 | primary | Outlined / text button label |
| `authLink` | 12 | w600 | primary | Inline auth links ("¿Olvidaste tu contraseña?") |
| `authFootLink` | 13 | w800 | primary | Foot link ("Crear cuenta") |
| `authFootPrompt` | 13 | w400 | onSurfaceVariant | Foot prompt ("¿No tienes cuenta?") |
| `chipLabel` | 12 | w700 | onSurfaceVariant | Tabs, category headers |
| `caption` | 11 | w400 | onSurfaceVariant | Auxiliary labels |
| `navActive` | 12 | w600 | primary | Active nav label |
| `navInactive` | 12 | w400 | onSurfaceVariant | Inactive nav label |
| `statusSuccess` | 12 | w700 | success | Success status |
| `statusWarning` | 12 | w700 | warning | Warning status |
| `statusError` | 12 | w700 | danger | Error status |
| `statusLive` | 12 | w700 | danger | Live match indicator |
| `scoreLarge` | 28 | w800 | onSurface | Score numbers (tabular) |
| `oddsPrice` | 16 | w700 | primary | Odds price (tabular) |

**Static property**: `AppTextStyle.fontFamily` — returns null on iOS (SF Pro auto), Inter on Android/web (matches Pencil).

## Colors — `ColorScheme` via `Theme.of(context).colorScheme`

Project convention: `final colors = Theme.of(context).colorScheme;`

| Token | Pencil var | Use for |
|-------|------------|---------|
| `primary` | `$primary` (#6366F1) | Primary actions, links, selected state |
| `onPrimary` | white | Text on primary backgrounds |
| `secondary` | `$primary/hover` (#4F46E5) | Hover/pressed primary, gradient end |
| `error` | `$danger` (#EF4444) | Error states, destructive actions |
| `surface` | `$bg/canvas` | Page backgrounds (`#0F172A` dark / `#F8FAFC` light) |
| `onSurface` | `$text/primary` | Primary text (`#F1F5F9` dark / `#0F172A` light) |
| `onSurfaceVariant` | `$text/secondary` | Secondary text (`#94A3B8` dark / `#64748B` light) |
| `surfaceContainer` | `$bg/surface` | Cards, inputs (`#1E293B` dark / `#FFFFFF` light) |
| `surfaceContainerHigh` | `$bg/surface-elevated` | Elevated surfaces (`#334155` dark / `#F1F5F9` light) |
| `outline` | `$border` | Borders, dividers (`#334155` dark / `#E2E8F0` light) |
| `outlineVariant` | `$border` 50% | Subtle borders |

For brand/status colors not in `ColorScheme`, use `AppColor` directly:
- `AppColor.primary`, `AppColor.primaryHover`
- `AppColor.success`, `AppColor.danger`, `AppColor.warning`, `AppColor.info`, `AppColor.muted`
- `AppColor.predictionWon/Lost/Pending/Void`
- `AppColor.primaryGradient` (primary → primaryHover) — hero panels
- `AppColor.heroDarkGradient` (surface → canvas) — login hero
- `AppColor.googleBlue` — Google SSO

## Radius — `AppRadius` (`lib/device/theme/radius.dart`)

Mirrors Pencil radius scale.

| Token | Value | Pencil var | Use for |
|-------|-------|------------|---------|
| `AppRadius.small` / `smallBorder` | 8 | `$radius-small` | Text buttons, chips, small elements |
| `AppRadius.card` / `cardBorder` | 12 | `$radius-card` | Buttons, inputs, cards (most things) |
| `AppRadius.sheet` / `sheetBorder` | 16 | `$radius-sheet` | Bottom sheets, large modals |
| `AppRadius.pill` / `pillBorder` | 9999 | `$radius-pill` | Pill buttons, fully rounded |

Compatibility aliases (`AppRadius.xs/sm/md/lg/xl` and `*Border`) are kept for legacy widgets — prefer the new names for new code.

## Spacing — `AppSpacing` (`lib/device/theme/spacing.dart`)

Pencil spacing scale.

| Token | Value | Pencil var |
|-------|-------|------------|
| `AppSpacing.s4` | 4 | `$spacing-4` |
| `AppSpacing.s8` | 8 | `$spacing-8` |
| `AppSpacing.s12` | 12 | `$spacing-12` |
| `AppSpacing.s16` | 16 | `$spacing-16` |
| `AppSpacing.s24` | 24 | `$spacing-24` |
| `AppSpacing.s32` | 32 | `$spacing-32` |
| `AppSpacing.s48` | 48 | `$spacing-48` |
| `AppSpacing.s64` | 64 | `$spacing-64` |

Compatibility aliases (`AppSpacing.xs/sm/md/lg/xl/xxl/xxxl`) are kept for legacy widgets — prefer the `sN` names for new code.

Use these constants directly in `EdgeInsets`, `SizedBox`, `Gap`, etc.
