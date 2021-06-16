import 'dart:math' as Math;

var add = (num a, num b) => a + b;
var multiply = (num a, num b) => a * b;
var divide = (num a, num b) => a / b;
var sub = (num a, num b) => a - b;
var pow = (num a, num b) => Math.pow(a, b);
var sqrt = (num a) => Math.sqrt(a);
var modulo = (num a, num b) => ((a % b) + b) % b;
var log = (num a) => Math.log(a);
var sin = (num a) => Math.sin(a);
var tan = (num a) => Math.tan(a);
var exp = (num a) => Math.exp(a);
var round = (num a) => a.round();
var min = (num a, num b) => Math.min(a, b);
var max = (num a, num b) => Math.max(a, b);

var defined = (a) => a != null;

dynamic cond = (dynamic condition, dynamic ifBlock, [dynamic elseBlock]) {
  if (condition) {
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

/*

add: reduce((a, b) => a + b),
  
  sin: single((a) => Math.sin(a)),
  cos: single((a) => Math.cos(a)),
  tan: single((a) => Math.tan(a)),
  acos: single((a) => Math.acos(a)),
  asin: single((a) => Math.asin(a)),
  atan: single((a) => Math.atan(a)),
  exp: single((a) => Math.exp(a)),
  round: single((a) => Math.round(a)),
  abs: single((a) => Math.abs(a)),
  ceil: single((a) => Math.ceil(a)),
  floor: single((a) => Math.floor(a)),
  max: reduce((a, b) => Math.max(a, b)),
  min: reduce((a, b) => Math.min(a, b)),

  // logical
  and: reduceFrom((a, b) => a && b, true),
  or: reduceFrom((a, b) => a || b, false),
  not: single((a) => !a),
  defined: single((a) => a !== null && a !== undefined && !isNaN(a)),

  // comparing
  lessThan: infix((a, b) => a < b),
  /* eslint-disable-next-line eqeqeq */
  eq: infix((a, b) => a == b),
  greaterThan: infix((a, b) => a > b),
  lessOrEq: infix((a, b) => a <= b),
  greaterOrEq: infix((a, b) => a >= b),
  /* eslint-disable-next-line eqeqeq */
  neq: infix((a, b) => a != b),
*/