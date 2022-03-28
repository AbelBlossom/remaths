part of remaths;

num _get(dynamic data) {
  assert(or(data is SharedValue, data is num));
  // print(data is num);
  return data is SharedValue ? data.value : data;
}

/// Takes two values, and when evaluated, returns their sum.
double add(dynamic a, dynamic b) => (_get(a) + _get(b)).toDouble();
//. Takes two values, and when evaluated, returns their product.
double multiply(dynamic a, dynamic b) => (_get(a) * _get(b)).toDouble();

/// Takes two values, and when evaluated,  returns the result of dividing their values in the exact order.
double divide(dynamic a, dynamic b) => (_get(a) / _get(b)).toDouble();

/// Takes two values, and when evaluated, returns the result of substracting their values
double sub(dynamic a, dynamic b) => (_get(a) - _get(b)).toDouble();

/// Takes two or more values, and when evaluated, returns the result of first node to the second node power.
double pow(dynamic a, dynamic b) => (Math.pow(_get(a), _get(b))).toDouble();

/// returns the squre root of the number
double sqrt(dynamic a) => Math.sqrt(a);

/// Remainder after division of the first argument by the second one. modulo(a,0) will throw an error.
double modulo(dynamic a, dynamic b) =>
    (((_get(a) % _get(b)) + _get(b)) % _get(b)).toDouble();

/// The same function as `Math.log`
double log(dynamic a) => Math.log(_get(a));

/// The same function as `Math.sin`
double sin(dynamic a) => Math.sin(_get(a));

/// The same function as `Math.tan`
double tan(dynamic a) => Math.tan(_get(a));

/// The same function as `Math.asin`
double asin(dynamic a) => Math.asin(_get(a));

/// The same function as `Math.exp`
double exp(dynamic a) => Math.exp(_get(a));

/// The same function as `num.round`
int round(dynamic a) => _get(a).round();

/// The same function as `num.floor`
int floor(dynamic a) => _get(a).floor();

/// The same function as `num.ceil`
int ceil(dynamic a) => _get(a).ceil();

/// The same function as `Math.atan`
double atan(dynamic a) => Math.atan(_get(a));

/// returns the minimum value
min<T extends num>(T a, T b) => Math.min(_get(a) as T, _get(b) as T);

/// returns the maximum value
T max<T extends num>(T a, T b) => Math.max<T>(_get(a) as T, _get(b) as T);

/// returns the aboslute value
num abs(dynamic a) => _get(a).abs();

/// convert [a] in Degress to Radian
double toRad(dynamic a) => _get(a) * Math.pi / 180;

/// convert [a] in Radian to Degrees
double toDeg(dynamic a) => _get(a) * 180 / Math.pi;

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

/// less than `<` comparism
bool lessThan(a, b) => _get(a) < _get(b);

/// greater than `>` comparism
bool greaterThan(a, b) => _get(a) > _get(b);

/// checks if the two values are equal `==`
bool eq(a, b) => _get(a) == _get(b);

/// checks if the two values are `not` equal `!=`
bool neq(a, b) => _get(a) != _get(a);

/// less than or equal to `<=` comparism
bool lessOrEq(a, b) => _get(a) <= _get(a);

/// graater than or equal to `>=` comparism
bool greaterOrEq(a, b) => _get(a) >= _get(a);

/// Evaluates [SharedValue] and returns a difference between value returned
///  at the last time it was evaluated and its value at the current time.
///
/// When evaluating for the first time it returns the [SharedValue] value
double diff(SharedValue sharedValue, [double initial = 0.0]) {
  return cond(
      defined(sharedValue._prev),
      sub(sharedValue.value, sharedValue._prev ?? 0),
      cond(defined(initial), initial, sharedValue.value)) as double;
}
