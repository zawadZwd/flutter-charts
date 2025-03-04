part of charts_painter;

/// Abstract class for decorations
/// Decorations are placed under and/or above items in the charts
abstract class DecorationPainter {
  /// Draw decoration.
  /// Decoration can be foreground or background decoration that will be drawn on the chart
  /// decorations can ignore padding and can use whole available canvas to draw.
  void draw(Canvas canvas, Size size, ChartState state);

  /// Get extra margin (not definable by the user). This makes sure that any decoration
  /// that leaves original drawing window is not drawing outside of that window (This is not
  /// enforced right now but it's unwanted behavior)
  ///
  /// Any decoration that needs space on side of the chart (any side) has to override this
  /// method and return how much space it needs and where as [EdgeInsets].
  EdgeInsets marginNeeded() {
    return EdgeInsets.zero;
  }

  /// Get extra padding (not definable by user, calculated by decoration if needed). This makes sure
  /// that decoration will fit with the chart in wanted area.
  ///
  /// Any decoration that needs padding can override this method and return [EdgeInsets] how much space it needs.
  EdgeInsets paddingNeeded() {
    return EdgeInsets.zero;
  }

  Size layoutSize(BoxConstraints constraints, ChartState state) {
    return constraints.biggest;
  }

  Offset applyPaintTransform(ChartState state, Size size) {
    return Offset.zero;
  }

  /// Init decoration is first thing called on decorations, it will pass current [ChartState]
  /// so decoration can easily calculate needed stuff for their layout.
  void initDecoration(ChartState state) {
    return;
  }

  Widget getRenderer(ChartState state) {
    return ChartDecorationRenderer(state, this, key: ValueKey(hashCode));
  }

  /// Animate to next decoration state, each decoration should implement this.
  /// This is just regular lerp function, but instead of static function where you pass start and
  /// end state, here we start with current state and animate to [endValue].
  DecorationPainter animateTo(DecorationPainter endValue, double t);

  /// Used for animating, we just need to find matching type, don't actually check for equality since we want to animate
  /// from one state to other. Some decorations may consider overriding this in case multiples are used
  bool isSameType(DecorationPainter other) {
    return runtimeType == other.runtimeType;
  }
}
