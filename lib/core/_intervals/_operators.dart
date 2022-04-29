part of remaths;

abstract class _InterOps {
  double _get(dynamic data) {
    assert(or(data is _InternalShared, data is num),
        "Value Must be a Tweenable or a number, got ${data.runtimeType}");
    // print(data is num);
    return data is _InternalShared ? data.value : (data as num).toDouble();
  }

  /// Takes two values, and when evaluated, returns their sum.
  double add(dynamic a, dynamic b) => (_get(a) + _get(b)).toDouble();
//. Takes two values, and when evaluated, returns their product.
  double multiply(dynamic a, dynamic b) => (_get(a) * _get(b)).toDouble();

  /// Takes two values, and when evaluated,  returns the result of dividing their values in the exact order.
  double divide(dynamic a, dynamic b) => (_get(a) / _get(b)).toDouble();

  /// Takes two values, and when evaluated, returns the result of subtracting their values
  double sub(dynamic a, dynamic b) => (_get(a) - _get(b)).toDouble();

  /// Takes two or more values, and when evaluated, returns the result of first node to the second node power.
  double pow(dynamic a, dynamic b) => (math.pow(_get(a), _get(b))).toDouble();

  /// returns the square root of the number
  double sqrt(dynamic a) => math.sqrt(a);

  /// Remainder after division of the first argument by the second one. modulo(a,0) will throw an error.
  double modulo(dynamic a, dynamic b) =>
      (((_get(a) % _get(b)) + _get(b)) % _get(b)).toDouble();

  /// The same function as `math.log`
  // TODO: This function conflicts with the log method from `dart:developer` package
  double log(dynamic a) => math.log(_get(a));

  /// The same function as `math.sin`
  double sin(dynamic a) => math.sin(_get(a));

  /// The same function as `math.tan`
  double tan(dynamic a) => math.tan(_get(a));

  /// The same function as `math.asin`
  double asin(dynamic a) => math.asin(_get(a));

  /// The same function as `math.exp`
  double exp(dynamic a) => math.exp(_get(a));

  /// The same function as `num.round`
  int round(dynamic a) => _get(a).round();

  /// The same function as `num.floor`
  int floor(dynamic a) => _get(a).floor();

  /// The same function as `num.ceil`
  int ceil(dynamic a) => _get(a).ceil();

  /// The same function as `math.atan`
  double atan(dynamic a) => math.atan(_get(a));

  /// returns the minimum value
  min<T extends num>(T a, T b) => math.min(_get(a) as T, _get(b) as T);

  /// returns the maximum value
  T max<T extends num>(T a, T b) => math.max<T>(_get(a) as T, _get(b) as T);

  /// returns the absolute value
  num abs(dynamic a) => _get(a).abs();

  /// convert [a] in Degrees to Radian
  double toRad(dynamic a) => _get(a) * math.pi / 180;

  /// convert [a] in Radian to Degrees
  double toDeg(dynamic a) => _get(a) * 180 / math.pi;

  /// Returns true if the given node evaluates to a "defined" value (that is to something that is non-null, non-undefined and non-NaN).
  /// Returns false otherwise
  bool defined(a) {
    return a != null;
  }

  bool or(bool a, bool b) => a || b;

  /// the if the value is valid
  bool truthy(dynamic val) {
    if (val is bool) return true;

    if (defined(val)) return true;
    return false;
  }

  /// If conditionNode evaluates to "truthy" value the node evaluates `ifBlock` node and returns its value,
  /// otherwise it evaluates `elseBlock` and returns its value. `elseBlock` is optional.
  cond(bool condition, ifBlock, [elseBlock]) {
    if (condition) {
      if (ifBlock is Function) {
        return ifBlock();
      }
      return ifBlock;
    } else {
      if (defined(elseBlock)) {
        if (elseBlock is Function) {
          return elseBlock();
        }
        return elseBlock;
      } else {
        return null;
      }
    }
  }

  /// less than `<` comparison
  bool lessThan(a, b) => _get(a) < _get(b);

  /// greater than `>` comparison
  bool greaterThan(a, b) => _get(a) > _get(b);

  /// checks if the two values are equal `==`
  bool eq(a, b) => _get(a) == _get(b);

  /// checks if the two values are `not` equal `!=`
  bool neq(a, b) => _get(a) != _get(b);

  /// less than or equal to `<=` comparison
  bool lessOrEq(a, b) => _get(a) <= _get(b);

  /// greater than or equal to `>=` comparison
  bool greaterOrEq(a, b) => _get(a) >= _get(b);

  /// Evaluates [Tweenable] and returns a difference between value returned
  ///  at the last time it was evaluated and its value at the current time.
  ///
  /// When evaluating for the first time it returns the [Tweenable] value
  double diff(_InternalShared tweenable, [double initial = 0.0]) {
    return cond(
        defined(tweenable._prev),
        sub(tweenable.value, tweenable._prev ?? 0),
        cond(defined(initial), initial, tweenable.value)) as double;
  }

//
  double decimalRound(dynamic a, dynamic dec) {
    assert(greaterOrEq(dec, 0), "decimal must be 0 or greater");
    if (_get(dec) == 0) return round(dec).toDouble();
    var r = multiply(10, pow(10, _get(dec) - 1));
    return divide(round(multiply(a, r)), r);
  }

  double random([int start = 0, int end = 1, int decimal = 1]) {
    var _rnd = math.Random();
    var min = cond(lessThan(start, end), start, end);
    var max = cond(lessThan(start, end), end, start);
    return decimalRound(
            add(
                cond(
                    min == 0, 0, add(min, _rnd.nextInt(sub(max, min).toInt()))),
                _rnd.nextDouble()),
            decimal)
        .toDouble();
  }

  List<int> range(int stop, {int start: 0, int step: 1}) {
    if (step <= 0) throw Exception("Step cannot be 0");

    return start < stop == step > 0
        ? List<int>.generate(
            ((start - stop) / step).abs().ceil(), (int i) => start + (i * step))
        : [];
  }

  T call<T>(T Function() func) {
    return func();
  }
}
