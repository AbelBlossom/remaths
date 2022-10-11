part of remaths.v2;

double interpolate(
  value,
  List<dynamic> inputRange,
  List<dynamic> outputRange, {
  Extrapolate extrapolate = Extrapolate.EXTEND,
  Extrapolate? extrapolateLeft,
  Extrapolate? extrapolateRight,
}) {
  var val = _get(value);
  var input = inputRange.map((e) => _get(e)).toList();
  var output = outputRange.map((e) => _get(e)).toList();
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

  double _singleInterpolate(_val, _input, _output, offset) {
    var inS = _input[offset];
    var inE = _input[offset + 1];
    var outS = _output[offset];
    var outE = _output[offset + 1];
    var progress = (_val - inS) / (inE - inS);
    var resultForNonZeroRange = outS + (progress * (outE - outS));
    return cond(
        inS == inE, cond(_val <= inS, outS, outE), resultForNonZeroRange);
  }

  var left = (defined(extrapolateLeft) ? extrapolateLeft : extrapolate)!;
  var right = (defined(extrapolateRight) ? extrapolateRight : extrapolate)!;

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
  var res = _singleInterpolate(val, input, output, index);

  if (left != Extrapolate.EXTEND)
    res = left == Extrapolate.CLAMP
        ? cond(val < input.first, output.first, res)
        : left == Extrapolate.IDENTITY
            ? res = cond(val < input.first, val, res)
            : res;
  if (right != Extrapolate.EXTEND)
    res = right == Extrapolate.CLAMP
        ? cond(val > input.last, output.last, res)
        : right == Extrapolate.IDENTITY
            ? res = cond(val > input.last, val, res)
            : res;

  return res;
}

interpolateColor(
  dynamic value,
  List<dynamic> inputRange,
  List<Color> outputRange,
) {
  var reds = outputRange.map((e) => e.red).toList();
  var greens = outputRange.map((e) => e.green).toList();
  var blues = outputRange.map((e) => e.blue).toList();
  var alpha = outputRange.map((e) => e.alpha).toList();

  getValue(List<dynamic> outputs, [List<dynamic>? input]) {
    return interpolate(
      value,
      input ?? inputRange,
      outputs,
      extrapolate: Extrapolate.CLAMP,
    ).round();
  }

  return Color.fromARGB(
    getValue(alpha),
    getValue(reds),
    getValue(greens),
    getValue(blues),
  );
}
