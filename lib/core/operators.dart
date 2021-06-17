import 'dart:math' as Math;

var add = (num? a, num b) => a! + b;
var multiply = (num a, num b) => a * b;
var divide = (num a, num b) => a / b;
var sub = (num? a, num? b) => a! - b!;
var pow = (num a, num b) => Math.pow(a, b);
var sqrt = (num a) => Math.sqrt(a);
var modulo = (num a, num b) => ((a % b) + b) % b;
var log = (num a) => Math.log(a);
var sin = (num a) => Math.sin(a);
var tan = (num a) => Math.tan(a);
var asin = (num a, num b) => Math.asin(a);
var exp = (num a) => Math.exp(a);
var round = (num? a) => a!.round();
var floor = (num a) => a.floor();
var ceil = (num a) => a.ceil();
var atan = (num a) => Math.atan(a);
var min = (num a, num b) => Math.min(a, b);
var max = (num a, num b) => Math.max(a, b);
var defined = (a) => a != null;
bool truthy(dynamic val) {
  if (val is bool) return true;

  if (defined(val)) return true;
  return false;
}

dynamic cond = (dynamic condition, dynamic ifBlock, [dynamic elseBlock]) {
  if (truthy(condition)) {
    return ifBlock;
  } else {
    if (defined(elseBlock)) {
      return elseBlock;
    }
  }
};

var lessThan = (a, b) => a < b;
var greaterThan = (a, b) => a > b;
var eq = (a, b) => a == b;
var neq = (a, b) => a != b;
var lessOrEq = (a, b) => a <= b;
var greaterOrEq = (a, b) => a >= b;
