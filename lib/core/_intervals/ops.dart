part of remaths.v1;

class _Ops extends _InterOps {
  /// Takes two values, and when evaluated, returns their sum.
  double add(dynamic a, dynamic b);
//. Takes two values, and when evaluated, returns their product.
  double multiply(dynamic a, dynamic b);

  /// Takes two values, and when evaluated,  returns the result of dividing their values in the exact order.
  double divide(dynamic a, dynamic b);

  /// Takes two values, and when evaluated, returns the result of subtracting their values
  double sub(dynamic a, dynamic b);

  /// Takes two or more values, and when evaluated, returns the result of first node to the second node power.
  double pow(dynamic a, dynamic b);

  /// returns the square root of the number
  double sqrt(dynamic a);

  /// Remainder after division of the first argument by the second one. modulo(a,0) will throw an error.
  double modulo(dynamic a, dynamic b);

  /// The same function as `math.log`
  double log(dynamic a);

  /// The same function as `math.sin`
  double sin(dynamic a);

  /// The same function as `math.tan`
  double tan(dynamic a);

  /// The same function as `math.asin`
  double asin(dynamic a);

  /// The same function as `math.exp`
  double exp(dynamic a);

  /// The same function as `num.round`
  int round(dynamic a);

  /// The same function as `num.floor`
  int floor(dynamic a);

  /// The same function as `num.ceil`
  int ceil(dynamic a);

  /// The same function as `math.atan`
  double atan(dynamic a);

  /// returns the minimum value
  min<T extends num>(T a, T b);

  /// returns the maximum value
  T max<T extends num>(T a, T b);

  /// returns the absolute value
  num abs(dynamic a);

  /// convert [a] in Degrees to Radian
  double toRad(dynamic a);

  /// convert [a] in Radian to Degrees
  double toDeg(dynamic a);

  /// Returns true if the given node evaluates to a "defined" value (that is to something that is non-null, non-undefined and non-NaN).
  /// Returns false otherwise
  bool defined(a);

  bool or(bool a, bool b);

  /// the if the value is valid
  bool truthy(dynamic val);

  /// If [condition] evaluates to "truthy" value the node evaluates [ifBlock] node and returns its value,
  /// otherwise it evaluates [elseBlock] and returns its value. [elseBlock] is optional.
  cond(bool condition, ifBlock, [elseBlock]);

  /// less than `<` comparison
  bool lessThan(a, b);

  /// greater than `>` comparison
  bool greaterThan(a, b);

  /// checks if the two values are equal `==`
  bool eq(a, b);

  /// checks if the two values are `not` equal `!=`
  bool neq(a, b);

  /// less than or equal to `<=` comparison
  bool lessOrEq(a, b);

  /// greater than or equal to `>=` comparison
  bool greaterOrEq(a, b);

  /// Evaluates [Tweenable] and returns a difference between value returned
  ///  at the last time it was evaluated and its value at the current time.
  ///
  /// When evaluating for the first time it returns the [Tweenable] value
  double diff(_InternalShared tweenable, [double initial = 0.0]);

  /// round a number [dec] (decimal)  specified
  /// ```dart
  /// decimalRound(1.34343, 2) // 1.34
  /// ````
  double decimalRound(dynamic a, dynamic dec);

  /// generate a random number from [start] to [end]
  ///
  /// If [decimal] is is specified, a random number is generated
  /// to the [decimal] specified
  /// ```dart
  /// random() // returns number from 0-1
  /// random(5) // returns random number from 0 - 5
  /// random(5,9) // returns random number from 5 to 9
  /// random(5,10,2) //returns a random decimal from 5 to 10 to 2 decimal places
  /// ```
  double random([int start = 0, int end = 1, int decimal = 1]);

  /// Generate a list integers
  /// ```dart
  /// range(3) // [0,1,2]
  /// range(10, start: 5) // [5,6,7,8,9]
  /// range(10, step: 2) // [0,2,4,6,8]
  /// ```
  List<int> range(int stop, {int start = 0, int step = 1});
}
