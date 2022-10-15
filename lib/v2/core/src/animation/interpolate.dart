part of v2.core;

double _interpolate(
  value,
  List<dynamic> inputRange,
  List<dynamic> outputRange, {
  Extrapolate extrapolate = Extrapolate.extend,
  Extrapolate? rightExtrapolate,
}) {
  var val = getValue(value);
  var input = inputRange.map((e) => getValue(e)).toList();
  var output = outputRange.map((e) => getValue(e)).toList();
  assert(
    input.length == output.length,
    "The length of inputRange must be equal to the outputRange",
  );
  assert(
    input.length > 1,
    "The length of the input must be 2 or more",
  );
  var sorted = [...input];
  sorted.sort((a, b) => a.compareTo(b));
  assert(listEquals(sorted, input), "Increasing error");

  double singleInterpolate(val_, input_, output_, offset) {
    var inS = input_[offset];
    var inE = input_[offset + 1];
    var outS = output_[offset];
    var outE = output_[offset + 1];
    var progress = (val_ - inS) / (inE - inS);
    var resultForNonZeroRange = outS + (progress * (outE - outS));
    return cond(
        inS == inE, cond(val_ <= inS, outS, outE), resultForNonZeroRange);
  }

  var left = extrapolate;
  var right = (defined(rightExtrapolate) ? rightExtrapolate : extrapolate)!;

  var index = 0;
  if (val < input.first) {
    // do nothing
  } else if (val > input.last) {
    index = input.length - 2;
  } else {
    for (var i = 1; i < input.length; i++) {
      index = i - 1;
      if (input[i] > val) break;
    }
  }
  var res = singleInterpolate(val, input, output, index);

  if (left != Extrapolate.extend) {
    res = left == Extrapolate.clamp
        ? cond(val < input.first, output.first, res)
        : left == Extrapolate.identity
            ? res = cond(val < input.first, val, res)
            : res;
  }
  if (right != Extrapolate.extend) {
    res = right == Extrapolate.clamp
        ? cond(val > input.last, output.last, res)
        : right == Extrapolate.identity
            ? res = cond(val > input.last, val, res)
            : res;
  }

  return res;
}

_interpolateColor(
  dynamic value,
  List<dynamic> inputRange,
  List<Color> outputRange,
) {
  var reds = outputRange.map((e) => e.red).toList();
  var greens = outputRange.map((e) => e.green).toList();
  var blues = outputRange.map((e) => e.blue).toList();
  var alpha = outputRange.map((e) => e.alpha).toList();

  getValue(List<dynamic> outputs, [List<dynamic>? input]) {
    return _interpolate(
      value,
      input ?? inputRange,
      outputs,
      extrapolate: Extrapolate.clamp,
    ).round();
  }

  return Color.fromARGB(
    getValue(alpha),
    getValue(reds),
    getValue(greens),
    getValue(blues),
  );
}

Offset _interpolateOffset(
  Offset value,
  List<Offset> inputRange,
  List<Offset> outputRange, {
  Extrapolate extrapolate = Extrapolate.extend,
  Extrapolate? rightExtrapolate,
}) {
  return Offset(
    _interpolate(value.dx, inputRange.map((e) => e.dx).toList(),
        outputRange.map((e) => e.dx).toList()),
    _interpolate(value.dy, inputRange.map((e) => e.dy).toList(),
        outputRange.map((e) => e.dy).toList()),
  );
}
