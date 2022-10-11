part of remaths;

double _get(dynamic data) {
  assert(
    data is SharedValue || data is num || data is double,
    "Value Must be a Tweenable or a number, got ${data.runtimeType}",
  );
  // print(data is num);
  return data is SharedValue ? data._val : (data as num).toDouble();
}

double add(dynamic a, dynamic b) => (_get(a) + _get(b)).toDouble();

double multiply(dynamic a, dynamic b) => (_get(a) * _get(b)).toDouble();

double divide(dynamic a, dynamic b) => (_get(a) / _get(b)).toDouble();

double sub(dynamic a, dynamic b) => (_get(a) - _get(b)).toDouble();

double pow(dynamic a, dynamic b) => (math.pow(_get(a), _get(b))).toDouble();

double sqrt(dynamic a) => math.sqrt(a);

double modulo(dynamic a, dynamic b) =>
    (((_get(a) % _get(b)) + _get(b)) % _get(b)).toDouble();

double log(dynamic a) => math.log(_get(a));

double sin(dynamic a) => math.sin(_get(a));

double tan(dynamic a) => math.tan(_get(a));

double asin(dynamic a) => math.asin(_get(a));

double exp(dynamic a) => math.exp(_get(a));

int round(dynamic a) => _get(a).round();

int floor(dynamic a) => _get(a).floor();

int ceil(dynamic a) => _get(a).ceil();

double atan(dynamic a) => math.atan(_get(a));

min<T extends num>(dynamic a, dynamic b) =>
    math.min(_get(a) as T, _get(b) as T);

T max<T extends num>(dynamic a, dynamic b) =>
    math.max<T>(_get(a) as T, _get(b) as T);

num abs(dynamic a) => _get(a).abs();

double toRad(dynamic a) => _get(a) * math.pi / 180;

double toDeg(dynamic a) => _get(a) * 180 / math.pi;

bool defined(a) => a != null;

bool or(bool a, bool b) => a || b;

bool truthy(dynamic val) {
  if (val is bool) return true;

  if (defined(val)) return true;
  return false;
}

cond(bool condition, ifBlock, [elseBlock]) {
  if (condition) {
    if (ifBlock is Function) return ifBlock();
    return ifBlock;
  } else {
    if (defined(elseBlock)) {
      if (elseBlock is Function) return elseBlock();
      return elseBlock;
    } else
      return null;
  }
}

bool lessThan(a, b) => _get(a) < _get(b);

bool greaterThan(a, b) => _get(a) > _get(b);

bool eq(a, b) => _get(a) == _get(b);

bool neq(a, b) => _get(a) != _get(b);

bool lessOrEq(a, b) => _get(a) <= _get(b);

bool greaterOrEq(a, b) => _get(a) >= _get(b);

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
          add(cond(min == 0, 0, add(min, _rnd.nextInt(sub(max, min).toInt()))),
              _rnd.nextDouble()),
          decimal)
      .toDouble();
}

List<num> range(dynamic stop, {dynamic start: 0, dynamic step: 1}) {
  var _stop = round(_get(stop));
  var _start = round(_get(start));
  var _step = round(_get(step));
  assert(_step >= 0, "step cannot be 0 or less");

  return cond(
      _start < _stop && _step > 0,
      List<int>.generate(
        ((_start - _stop) / _step).abs().ceil(),
        (int i) => _start + (i * _step),
      ),
      []);
}

T call<T>(T Function() func) {
  return func();
}

double clamp(dynamic value, dynamic _min, dynamic _max) =>
    max(min(value, _max), _min);

double diff(SharedValue value) => value.diff;
