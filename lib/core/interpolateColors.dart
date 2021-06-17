import 'package:flutter/material.dart';
import 'package:remaths/remaths.dart';

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

Color interpolateColors(value,
    {List<Color> outputColorRange, List<num> inputRange}) {
  var r = round(
    interpolate(
      value,
      inputRange: inputRange,
      outputRange: _getRed(outputColorRange),
    ),
  );

  var g = round(
    interpolate(
      value,
      inputRange: inputRange,
      outputRange: _getGreen(outputColorRange),
    ),
  );

  var b = round(
    interpolate(
      value,
      inputRange: inputRange,
      outputRange: _getBlue(
        (outputColorRange),
      ),
    ),
  );

  var a = interpolate(
    value,
    inputRange: inputRange,
    outputRange: _getOpacity(
      (outputColorRange),
    ),
  );

  // assddfd

  return Color.fromRGBO(r, g, b, a);
}
