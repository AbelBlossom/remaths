
import '../core/core.dart';
import 'dart:math' as math;

double getValue(dynamic data) {
  assert(
    data is SharedValue || data is num || data is double,
    "Value Must be a SharedValue or a number, got ${data.runtimeType}",
  );
  // print(data is num);
  return data is SharedValue ? data.value : (data as num).toDouble();
}

/// add [a] to [b] <br>
/// values
double add(dynamic a, dynamic b) => (getValue(a) + getValue(b)).toDouble();

double multiply(dynamic a, dynamic b) => (getValue(a) * getValue(b)).toDouble();

double divide(dynamic a, dynamic b) => (getValue(a) / getValue(b)).toDouble();

double sub(dynamic a, dynamic b) => (getValue(a) - getValue(b)).toDouble();

double pow(dynamic a, dynamic b) =>
    (math.pow(getValue(a), getValue(b))).toDouble();

double sqrt(dynamic a) => math.sqrt(a);

double modulo(dynamic a, dynamic b) =>
    (((getValue(a) % getValue(b)) + getValue(b)) % getValue(b)).toDouble();

double log(dynamic a) => math.log(getValue(a));

double sin(dynamic a) => math.sin(getValue(a));

double tan(dynamic a) => math.tan(getValue(a));

double atan(dynamic a) => math.atan(getValue(a));

double asin(dynamic a) => math.asin(getValue(a));

double acos(dynamic a) => math.acos(getValue(a));

double exp(dynamic a) => math.exp(getValue(a));

int round(dynamic a) => getValue(a).round();

int floor(dynamic a) => getValue(a).floor();

int ceil(dynamic a) => getValue(a).ceil();

min<T extends num>(dynamic a, dynamic b) =>
    math.min(getValue(a) as T, getValue(b) as T);

T max<T extends num>(dynamic a, dynamic b) =>
    math.max<T>(getValue(a) as T, getValue(b) as T);

num abs(dynamic a) => getValue(a).abs();

double toRad(dynamic a) => getValue(a) * math.pi / 180;

double toDeg(dynamic a) => getValue(a) * 180 / math.pi;

bool defined(a) => a != null;

bool or(bool a, bool b) => a || b;

cond(bool condition, ifBlock, [elseBlock]) {
  if (condition) {
    if (ifBlock is Function) return ifBlock();
    return ifBlock;
  } else {
    if (defined(elseBlock)) {
      if (elseBlock is Function) return elseBlock();
      return elseBlock;
    }
    return;
  }
}

bool lessThan(a, b) => getValue(a) < getValue(b);

bool greaterThan(a, b) => getValue(a) > getValue(b);

bool eq(a, b) => getValue(a) == getValue(b);

bool neq(a, b) => getValue(a) != getValue(b);

bool lessOrEq(a, b) => getValue(a) <= getValue(b);

bool greaterOrEq(a, b) => getValue(a) >= getValue(b);

double decimalRound(dynamic a, dynamic dec) {
  assert(greaterOrEq(dec, 0), "decimal must be 0 or greater");
  if (getValue(dec) == 0) return dec.toDouble();
  var r = multiply(10, pow(10, getValue(dec) - 1));
  return divide(round(multiply(a, r)), r);
}

double random([int start = 0, int end = 1, int decimal = 1]) {
  var rnd = math.Random();
  var min = cond(lessThan(start, end), start, end);
  var max = cond(lessThan(start, end), end, start);
  return decimalRound(
          add(cond(min == 0, 0, add(min, rnd.nextInt(sub(max, min).toInt()))),
              rnd.nextDouble()),
          decimal)
      .toDouble();
}

List<num> range(dynamic stop, {dynamic start = 0, dynamic step = 1}) {
  var stop_ = round(getValue(stop));
  var start_ = round(getValue(start));
  var step_ = round(getValue(step));
  assert(step_ >= 0, "step cannot be 0 or less");

  return cond(
      start_ < stop_ && step_ > 0,
      List<int>.generate(
        ((start_ - stop_) / step_).abs().ceil(),
        (int i) => start_ + (i * step_),
      ),
      []);
}

T call<T>(T Function() func) {
  return func();
}

double clamp(dynamic value, dynamic min_, dynamic max_) =>
    max(min(value, max_), min_);

double diff(SharedValue value) => value.diff;

double diffClamp(SharedValue value, num min_, num max_) =>
    clamp(add(value, value.diff), min_, max_);
