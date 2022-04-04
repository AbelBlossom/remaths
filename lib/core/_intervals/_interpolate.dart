part of remaths;

dynamic _interpolateInternalSingleProc(value, inS, inE, outS, outE) {
  ///asd
  var progress = divide(sub(value, inS), sub(inE, inS));
  var resultForNonZeroRange = add(outS, multiply(progress, sub(outE, outS)));
  var result = cond(eq(inS, inE), cond(lessOrEq(value, inS), outS, outE),
      resultForNonZeroRange);
  return result;
}

_interpolateInternalSingle(value, inputRange, outputRange, offset) {
  var inS = inputRange[offset];
  var inE = inputRange[offset + 1];
  var outS = outputRange[offset];
  var outE = outputRange[offset + 1];
  return _interpolateInternalSingleProc(value, inS, inE, outS, outE);
}

double _interpolateInternal(value, inputRange, outputRange, [offset = 0]) {
  if (inputRange.length - offset == 2) {
    return _interpolateInternalSingle(value, inputRange, outputRange, offset);
  }
  return cond(
      lessThan(value, inputRange[offset + 1]),
      _interpolateInternalSingle(value, inputRange, outputRange, offset),
      _interpolateInternal(value, inputRange, outputRange, offset + 1));
}

enum Extrapolate {
  EXTEND,
  CLAMP,
  IDENTITY,
}
typedef Map Name(params);

// void _throwError(bool condition, String text) {
//   if (!condition) {
//     throw (text);
//   }
// }

_checkNonDecreasing(name, arr) {
  for (var i = 1; i < arr.length; ++i) {
    assert(
      arr[i] >= arr[i - 1],
      "$name must be monotonically non-decreasing.",
    );
  }
}

_checkMinElements(name, arr) {
  assert(arr.length >= 2, "$name must have at least 2 elements.");
}

double _internalInterpolate(
  value, {
  required List<num> inputRange,
  required List<num> outputRange,
  Extrapolate extrapolate = Extrapolate.EXTEND,
  Extrapolate? extrapolateLeft,
  Extrapolate? extrapolateRight,
}) {
  _checkMinElements('inputRange', inputRange);
  _checkMinElements('outputRange', outputRange);
  _checkNonDecreasing('inputRange', inputRange);

  var _inputRange = inputRange.map((e) => e.toDouble()).toList();
  var _outputRange = outputRange.map((e) => e.toDouble()).toList();
  assert(
    inputRange.length == outputRange.length,
    "inputRange and outputRange must be the same length.",
  );

  var left = defined(extrapolateLeft) ? extrapolateLeft : extrapolate;
  var right = defined(extrapolateRight) ? extrapolateRight : extrapolate;
  var output = _interpolateInternal(_get(value), _inputRange, _outputRange);

  if (left == Extrapolate.CLAMP) {
    output = cond(lessThan(value, _inputRange[0]), _outputRange[0], output);
  } else if (left == Extrapolate.IDENTITY) {
    output = cond(lessThan(value, _inputRange[0]), value, output);
  }

  if (right == Extrapolate.CLAMP) {
    output = cond(greaterThan(value, _inputRange[_inputRange.length - 1]),
        _outputRange[_outputRange.length - 1], output);
  } else if (right == Extrapolate.IDENTITY) {
    output = cond(
        greaterThan(value, _inputRange[_inputRange.length - 1]), value, output);
  }

  return output.toDouble();
}

T _interpolateAll<T>(num value, List<num> inputRange, List<T> outputRange,
    [Extrapolate extrapolate = Extrapolate.EXTEND, Extrapolate? right]) {
  assert(or(outputRange.first is Color, outputRange.first is num),
      'Only Numbers and Colors can be Interpolated');

  if (outputRange.first is Color) {
    return _internalInterpolateColors(
      value,
      inputRange: inputRange,
      outputColorRange: outputRange as List<Color>,
    ) as T;
  } else {
    return _internalInterpolate(
      value,
      inputRange: inputRange,
      outputRange: outputRange as List<num>,
      extrapolate: cond(right == null, extrapolate, null),
      extrapolateLeft: cond(right == null, extrapolate, null),
      extrapolateRight: cond(right == null, null, right),
    ) as T;
  }
}
