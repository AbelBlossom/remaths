part of remaths;

class _Ops extends _InterOps {
  /// Takes two values, and when evaluated, returns their sum.
  double add(dynamic a, dynamic b);
//. Takes two values, and when evaluated, returns their product.
  double multiply(dynamic a, dynamic b);

  /// Takes two values, and when evaluated,  returns the result of dividing their values in the exact order.
  double divide(dynamic a, dynamic b);

  /// Takes two values, and when evaluated, returns the result of substracting their values
  double sub(dynamic a, dynamic b);

  /// Takes two or more values, and when evaluated, returns the result of first node to the second node power.
  double pow(dynamic a, dynamic b);

  /// returns the squre root of the number
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

  /// returns the aboslute value
  num abs(dynamic a);

  /// convert [a] in Degress to Radian
  double toRad(dynamic a);

  /// convert [a] in Radian to Degrees
  double toDeg(dynamic a);

  /// Returns true if the given node evaluates to a "defined" value (that is to something that is non-null, non-undefined and non-NaN).
  /// Returns false otherwise
  bool defined(a);

  bool or(bool a, bool b);

  /// the if the value is valid
  bool truthy(dynamic val);

  /// If conditionNode evaluates to "truthy" value the node evaluates `ifBlock` node and returns its value,
  /// otherwise it evaluates `elseBlock` and returns its value. `elseBlock` is optional.
  cond(bool condition, ifBlock, [elseBlock]);

  /// less than `<` comparism
  bool lessThan(a, b);

  /// greater than `>` comparism
  bool greaterThan(a, b);

  /// checks if the two values are equal `==`
  bool eq(a, b);

  /// checks if the two values are `not` equal `!=`
  bool neq(a, b);

  /// less than or equal to `<=` comparism
  bool lessOrEq(a, b);

  /// graater than or equal to `>=` comparism
  bool greaterOrEq(a, b);

  /// Evaluates [Tweenable] and returns a difference between value returned
  ///  at the last time it was evaluated and its value at the current time.
  ///
  /// When evaluating for the first time it returns the [Tweenable] value
  double diff(_InternalShared tweenable, [double initial = 0.0]);

//
  double decimalround(dynamic a, dynamic dec);

  double random([int start = 0, int end = 1, int decimal = 1]);

  List<int> range(int start, [int end = 0]);
}
