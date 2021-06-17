import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remaths/core/interpolate.dart';

import 'package:remaths/remaths.dart';

void main() {
  test('adds one to input values', () {
    var color = interpolateColors(
      30,
      inputRange: [10, 20, 30],
      outputColorRange: [Colors.red, Colors.yellow, Colors.green],
    );
    print("${color.red} ${color.green} ${color.blue}");

    expect(interpolate(5, inputRange: [0, 2.5, 5], outputRange: [0, 1, 2]), 2);
  });
}
