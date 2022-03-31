part of remaths;

List<int> _getRed(List<Color> colors) {
  return colors.map((e) => e.red).toList();
}

List<int> _getBlue(List<Color> colors) {
  return colors.map((e) => e.blue).toList();
}

List<int> _getGreen(List<Color> colors) {
  return colors.map((e) => e.green).toList();
}

List<double> _getOpacity(List<Color> colors) {
  return colors.map((e) => e.opacity).toList();
}

Color _internalInterpolateColors(value,
    {required List<Color> outputColorRange, required List<num> inputRange}) {
  var v = _get(value);
  var r = round(
    _internalInterpolate(
      v,
      inputRange: inputRange,
      outputRange: _getRed(outputColorRange),
    ),
  );

  var g = round(
    _internalInterpolate(
      v,
      inputRange: inputRange,
      outputRange: _getGreen(outputColorRange),
    ),
  );

  var b = round(
    _internalInterpolate(
      v,
      inputRange: inputRange,
      outputRange: _getBlue(
        (outputColorRange),
      ),
    ),
  );

  var a = _internalInterpolate(
    v,
    inputRange: inputRange,
    outputRange: _getOpacity(
      (outputColorRange),
    ),
  );

  return Color.fromRGBO(r, g, b, a as double);
}
