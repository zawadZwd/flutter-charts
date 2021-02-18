part of flutter_charts;

/// Draws a grid with [verticalAxisStep] and [horizontalAxisStep] as spacers
/// Grid will stretch across whole graph and it will ignore the padding from
/// [ChartOptions].
/// That will allow for Legend to be inserted as well.
class GridDecoration extends DecorationPainter {
  GridDecoration({
    this.showHorizontalValues = false,
    this.showVerticalValues = false,
    bool endWithChart = false,
    this.horizontalTextAlign = TextAlign.end,
    this.showTopHorizontalValue = false,
    this.verticalTextAlign = TextAlign.center,
    this.showVerticalGrid = true,
    this.showHorizontalGrid = true,
    this.verticalValuesPadding,
    this.horizontalValuesPadding,
    this.horizontalAxisUnit,
    this.verticalAxisValueFromIndex = defaultAxisValue,
    this.horizontalAxisValueFromValue = defaultAxisValue,
    this.gridColor = Colors.grey,
    this.gridWidth = 1.0,
    this.dashArray,
    this.verticalAxisStep = 1,
    this.horizontalAxisStep = 1,
    this.horizontalLegendPosition = HorizontalLegendPosition.end,
    this.verticalLegendPosition = VerticalLegendPosition.bottom,
    this.textStyle,
  })  : _endWithChart = endWithChart ? 1.0 : 0.0,
        assert(textStyle != null || !(showHorizontalValues || showTopHorizontalValue || showVerticalValues),
            'Need to provide text style for values to be visible!') {
    _horizontalAxisDecoration = HorizontalAxisDecoration(
      showValues: showHorizontalValues,
      endWithChart: endWithChart,
      showGrid: showHorizontalGrid,
      valuesAlign: horizontalTextAlign,
      valuesPadding: horizontalValuesPadding,
      showTopValue: showTopHorizontalValue,
      horizontalAxisUnit: horizontalAxisUnit,
      gridColor: gridColor,
      dashArray: dashArray,
      gridWidth: gridWidth,
      axisStep: horizontalAxisStep,
      axisValue: horizontalAxisValueFromValue,
      legendFontStyle: textStyle,
      legendPosition: horizontalLegendPosition,
    );
    _verticalAxisDecoration = VerticalAxisDecoration(
      showValues: showVerticalValues,
      valuesAlign: verticalTextAlign,
      showGrid: showVerticalGrid,
      endWithChart: endWithChart,
      gridColor: gridColor,
      dashArray: dashArray,
      valueFromIndex: verticalAxisValueFromIndex,
      legendPosition: verticalLegendPosition,
      valuesPadding: verticalValuesPadding,
      gridWidth: gridWidth,
      axisStep: verticalAxisStep,
      legendFontStyle: textStyle,
    );
  }

  GridDecoration._lerp({
    this.showHorizontalValues = false,
    this.showVerticalValues = false,
    double endWithChart = 0.0,
    this.horizontalTextAlign = TextAlign.end,
    this.showTopHorizontalValue = false,
    this.verticalTextAlign = TextAlign.center,
    this.showVerticalGrid = true,
    this.showHorizontalGrid = true,
    this.verticalValuesPadding,
    this.horizontalValuesPadding,
    this.horizontalAxisUnit,
    this.verticalAxisValueFromIndex = defaultAxisValue,
    this.horizontalAxisValueFromValue = defaultAxisValue,
    this.gridColor = Colors.grey,
    this.gridWidth = 1.0,
    this.verticalAxisStep = 1,
    this.horizontalAxisStep = 1,
    this.dashArray,
    this.horizontalLegendPosition = HorizontalLegendPosition.end,
    this.verticalLegendPosition = VerticalLegendPosition.bottom,
    this.textStyle,
  })  : _endWithChart = endWithChart,
        assert(textStyle != null || !(showHorizontalValues || showTopHorizontalValue || showVerticalValues),
            'Need to provide text style for values to be visible!') {
    _horizontalAxisDecoration = HorizontalAxisDecoration._lerp(
      showValues: showHorizontalValues,
      endWithChart: _endWithChart,
      valuesAlign: horizontalTextAlign,
      showTopValue: showTopHorizontalValue,
      showGrid: showHorizontalGrid,
      horizontalAxisUnit: horizontalAxisUnit,
      valuesPadding: horizontalValuesPadding,
      gridColor: gridColor,
      dashArray: dashArray,
      axisValue: horizontalAxisValueFromValue,
      gridWidth: gridWidth,
      axisStep: horizontalAxisStep,
      legendFontStyle: textStyle,
      legendPosition: horizontalLegendPosition,
    );
    _verticalAxisDecoration = VerticalAxisDecoration._lerp(
      showValues: showVerticalValues,
      valuesAlign: verticalTextAlign,
      showGrid: showVerticalGrid,
      endWithChart: _endWithChart,
      gridColor: gridColor,
      dashArray: dashArray,
      valueFromIndex: verticalAxisValueFromIndex,
      valuesPadding: verticalValuesPadding,
      gridWidth: gridWidth,
      legendPosition: verticalLegendPosition,
      axisStep: verticalAxisStep,
      legendFontStyle: textStyle,
    );
  }

  final bool showHorizontalValues;
  final bool showVerticalValues;
  bool get endWithChart => _endWithChart > 0.5;
  final double _endWithChart;

  final TextAlign horizontalTextAlign;
  final TextAlign verticalTextAlign;

  final TextStyle textStyle;

  final EdgeInsets horizontalValuesPadding;
  final EdgeInsets verticalValuesPadding;

  final bool showTopHorizontalValue;
  final bool showVerticalGrid;
  final bool showHorizontalGrid;
  final String horizontalAxisUnit;

  final List<double> dashArray;

  HorizontalLegendPosition horizontalLegendPosition;
  VerticalLegendPosition verticalLegendPosition;

  HorizontalAxisDecoration _horizontalAxisDecoration;
  VerticalAxisDecoration _verticalAxisDecoration;

  final AxisValueFromIndex verticalAxisValueFromIndex;
  final AxisValueFromValue horizontalAxisValueFromValue;

  final Color gridColor;
  final double gridWidth;

  /// Change step for y axis (1 by default) used in [GridDecoration], [VerticalAxisDecoration] and [HorizontalAxisDecoration]
  final double verticalAxisStep;

  /// Change step for x axis (1 by default) used in [GridDecoration], [VerticalAxisDecoration] and [HorizontalAxisDecoration]
  final double horizontalAxisStep;

  @override
  void draw(Canvas canvas, Size size, ChartState state) {
    _horizontalAxisDecoration.draw(canvas, size, state);
    _verticalAxisDecoration.draw(canvas, size, state);
  }

  @override
  EdgeInsets marginNeeded() {
    return _horizontalAxisDecoration.marginNeeded() + _verticalAxisDecoration.marginNeeded();
  }

  @override
  EdgeInsets paddingNeeded() {
    return _horizontalAxisDecoration.paddingNeeded() + _verticalAxisDecoration.paddingNeeded();
  }

  @override
  void initDecoration(ChartState state) {
    _horizontalAxisDecoration.initDecoration(state);
    _verticalAxisDecoration.initDecoration(state);
  }

  @override
  DecorationPainter animateTo(DecorationPainter endValue, double t) {
    if (endValue is GridDecoration) {
      return GridDecoration._lerp(
        showHorizontalValues: t < 0.5 ? showHorizontalValues : endValue.showHorizontalValues,
        showVerticalValues: t < 0.5 ? showVerticalValues : endValue.showVerticalValues,
        endWithChart: lerpDouble(_endWithChart, endValue._endWithChart, t),
        horizontalTextAlign: t < 0.5 ? horizontalTextAlign : endValue.horizontalTextAlign,
        showTopHorizontalValue: t < 0.5 ? showTopHorizontalValue : endValue.showTopHorizontalValue,
        verticalTextAlign: t < 0.5 ? verticalTextAlign : endValue.verticalTextAlign,
        showVerticalGrid: t < 0.5 ? showVerticalGrid : endValue.showVerticalGrid,
        showHorizontalGrid: t < 0.5 ? showHorizontalGrid : endValue.showHorizontalGrid,
        horizontalAxisUnit: t < 0.5 ? horizontalAxisUnit : endValue.horizontalAxisUnit,
        verticalAxisValueFromIndex: t < 0.5 ? verticalAxisValueFromIndex : endValue.verticalAxisValueFromIndex,
        horizontalAxisValueFromValue: t < 0.5 ? horizontalAxisValueFromValue : endValue.horizontalAxisValueFromValue,
        horizontalLegendPosition: t < 0.5 ? horizontalLegendPosition : endValue.horizontalLegendPosition,
        verticalLegendPosition: t < 0.5 ? verticalLegendPosition : endValue.verticalLegendPosition,
        gridColor: Color.lerp(gridColor, endValue.gridColor, t),
        dashArray: t < 0.5 ? dashArray : endValue.dashArray,
        gridWidth: lerpDouble(gridWidth, endValue.gridWidth, t),
        verticalAxisStep: lerpDouble(verticalAxisStep, endValue.verticalAxisStep, t),
        horizontalAxisStep: lerpDouble(horizontalAxisStep, endValue.horizontalAxisStep, t),
        verticalValuesPadding: EdgeInsets.lerp(verticalValuesPadding, endValue.verticalValuesPadding, t),
        horizontalValuesPadding: EdgeInsets.lerp(horizontalValuesPadding, endValue.horizontalValuesPadding, t),
        textStyle: TextStyle.lerp(textStyle, endValue.textStyle, t),
      );
    }

    return this;
  }
}
