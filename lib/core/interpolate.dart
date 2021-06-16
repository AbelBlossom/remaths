import 'package:remaths/core/operators.dart';

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

_interpolateInternal(value, inputRange, outputRange, [offset = 0]) {
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

num interpolate(
  value, {
  List inputRange,
  List outputRange,
  Extrapolate extrapolate = Extrapolate.EXTEND,
  Extrapolate extrapolateLeft,
  Extrapolate extrapolateRight,
}) {
  if (inputRange.length != outputRange.length) {
    throw Error();
  }
  var left = defined(extrapolateLeft) ? extrapolateLeft : extrapolate;
  var right = defined(extrapolateRight) ? extrapolateRight : extrapolate;
  var output = _interpolateInternal(value, inputRange, outputRange);

  if (left == Extrapolate.EXTEND) {
  } else if (left == Extrapolate.CLAMP) {
    output = cond(lessThan(value, inputRange[0]), outputRange[0], output);
  } else if (left == Extrapolate.IDENTITY) {
    output = cond(lessThan(value, inputRange[0]), value, output);
  }

  if (right == Extrapolate.EXTEND) {
  } else if (right == Extrapolate.CLAMP) {
    output = cond(greaterThan(value, inputRange[inputRange.length - 1]),
        outputRange[outputRange.length - 1], output);
  } else if (right == Extrapolate.IDENTITY) {
    output = cond(
        greaterThan(value, inputRange[inputRange.length - 1]), value, output);
  }

  return output;
}
