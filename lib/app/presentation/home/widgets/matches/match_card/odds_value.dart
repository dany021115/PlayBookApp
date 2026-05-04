/// UI-only model representing a single odds cell.
///
/// Lives next to [OddsCell]. Two display modes:
///
///   * Full mode (`price` non-empty) → `1` / `1.85` / `↑0.05` stacked.
///   * Compact mode (`price` empty)  → label is the whole content,
///     e.g. `"X · 3.10"`.
///
/// `up == null` renders the delta in muted; `true`=green, `false`=red.
/// `selected` paints the cell primary-filled.
class OddsValue {
  final String label;
  final String price;
  final String delta;
  final bool? up;
  final bool selected;

  const OddsValue({
    required this.label,
    required this.price,
    required this.delta,
    this.up,
    this.selected = false,
  });

  bool get isCompact => price.isEmpty;
}
