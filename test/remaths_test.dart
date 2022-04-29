import 'package:flutter_test/flutter_test.dart';

import 'package:remaths/remaths.dart';

void main() {
  test('adds one to input values', () {
    // var color = interpolateColors(
    //   30,
    //   inputRange: [10, 20, 30],
    //   outputColorRange: [Colors.red, Colors.yellow, Colors.green],
    // );
    // print("${color.red} ${color.green} ${color.blue}");

    expect(4.interpolate([0, 2.5, 5], [0, 1, 2]), 2);
  });
}
