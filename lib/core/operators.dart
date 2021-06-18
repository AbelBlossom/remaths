import 'dart:math' as Math;

// Takes two values, and when evaluated, returns their sum.
var add = (num? a, num b) => a! + b;
// Takes two values, and when evaluated, returns their product.
var multiply = (num a, num b) => a * b;
// Takes two values, and when evaluated,  returns the result of dividing their values in the exact order.
var divide = (num a, num b) => a / b;

/// Takes two values, and when evaluated, returns the result of substracting their values
var sub = (num? a, num? b) => a! - b!;

/// Takes two or more values, and when evaluated, returns the result of first node to the second node power.
var pow = (num a, num b) => Math.pow(a, b);

/// returns the squre root of the number
var sqrt = (num a) => Math.sqrt(a);

/// Remainder after division of the first argument by the second one. modulo(a,0) will throw an error.
var modulo = (num a, num b) => ((a % b) + b) % b;

/// The same function as `Math.log`
var log = (num a) => Math.log(a);

/// The same function as `Math.sin`
var sin = (num a) => Math.sin(a);

/// The same function as `Math.tan`
var tan = (num a) => Math.tan(a);

/// The same function as `Math.asin`
var asin = (num a, num b) => Math.asin(a);

/// The same function as `Math.exp`
var exp = (num a) => Math.exp(a);

/// The same function as `num.round`
var round = (num a) => a.round();

/// The same function as `num.floor`
var floor = (num a) => a.floor();

/// The same function as `num.ceil`
var ceil = (num a) => a.ceil();

/// The same function as `Math.atan`
var atan = (num a) => Math.atan(a);

/// returns the minimum value
var min = (num a, num b) => Math.min(a, b);

/// returns the maximum value
var max = (num a, num b) => Math.max(a, b);

/// returns the aboslute value
var abs = (num a) => a.abs();
var toRad = (num a) => a * Math.pi / 180;

/// Returns true if the given node evaluates to a "defined" value (that is to something that is non-null, non-undefined and non-NaN).
/// Returns false otherwise
var defined = (a) => a != null;

/// the if the value is valid
bool truthy(dynamic val) {
  if (val is bool) return true;

  if (defined(val)) return true;
  return false;
}

/// If conditionNode evaluates to "truthy" value the node evaluates `ifBlock` node and returns its value,
/// otherwise it evaluates `elseBlock` and returns its value. `elseBlock` is optional.
dynamic cond = (dynamic condition, dynamic ifBlock, [dynamic elseBlock]) {
  if (condition) {
    return ifBlock;
  } else {
    if (defined(elseBlock)) {
      return elseBlock;
    }
  }
};

/// less than `<` comparism
var lessThan = (a, b) => a < b;

/// greater than `>` comparism
var greaterThan = (a, b) => a > b;

/// checks if the two values are equal `==`
var eq = (a, b) => a == b;

/// checks if the two values are `not` equal `!=`
var neq = (a, b) => a != b;

/// less than or equal to `<=` comparism
var lessOrEq = (a, b) => a <= b;

/// graater than or equal to `>=` comparism
var greaterOrEq = (a, b) => a >= b;
