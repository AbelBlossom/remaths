import 'package:flutter_test/flutter_test.dart';
import 'package:remaths/core/interpolate.dart';
import 'package:remaths/core/operators.dart';

import 'package:remaths/remaths.dart';

void main() {
  test('adds one to input values', () {
    expect(interpolate(10, inputRange: [0, 10], outputRange: [0, 1]), 1);
  });
}
