# Remaths

remaths is a flutter package that makes animations and other calculations easier to use. This package is heavily **inspired** by the react-native reanimated package.

## `Tweenable`

`Tweenables` are one of the fundamentals of the `remaths` package. `Tweenable` carries `Tweenable` data. This data can be animated with timing or spring. `Tweenable` uses the default flutter `AnimationController` under the hood to render animations (performable). Before we start animating with `Tweenable` lets look at Tweenable Functions

# Tweenable Functions
Tweenable functions are used to animate `Tweenable` values. 
## withSpring

Starts a spring animation on the `Tweenable` value.
 ```dart
    x = withSpring(toValue, {
    int  duration,
    double  damping,
    double  stiffness,
    double  mass,
    double  velocity,
    int?  delay,
    void  Function()?  onComplete,
    })
```
| Params   | default  | description |
| --------  | -------  | ------------|
| toValue * | required | the destination of the animation |
| duration   | 300      | the duration in `milliseconds` |
| damping   | 20       | spring damping|
| stiffness | 180.0    | stiffness|
| mass      | 1.0      | mass|
| velocity  | 0.0      | velocity|
| delay     | 0.0      | duration in `milliseconds` the animation will delay before starting |
| onComplete| null     | function called after the animation is complete |

## withTiming
Start a timing animation in the `Tweenable` value

```dart
x = withTiming(double toValue, {
    double toValue, {
  int duration = _kDuration,
  Curve curve = Curves.easeIn,
  int? delay,
  void Function()? onComplete,
})
```

| Params   | default  | description |
| --------  | -------  | ------------|
| toValue * | required | the destination of the animation |
| duration   | 300      | the duration in `milliseconds` |
| curve     | Curves.easeIn| the curve of the animation |
| delay     | 0.0      | duration in `milliseconds` the animation will delay before starting |
| onComplete| null     | function called after the animation is complete |
## withSequence
Run list of animations sequentially.
```dart
 x = withSequence([withTiming(...),6.0,withSpring(...),])
```
`wihSequence` takes a list of Tweenable Functions or a `double` and run them sequentially.
When a `double` is provided, the value is set to that destination without any animation.

# Working with Tweenables
Lets take `Tweenable` as a double value that can be animated with Tweenable Functions.
```dart
var x = Tweenable(double value, vsync: this);
```

Tweenables can also be initialized with num extensions
```dart
var x = 12.asTweenable(this);
// In this case 12 is used as an initial value
```

| Params   | default  | description |
| -------- | -------  | ------------|
| value    | required | the animation position |
| vsync    | required  | `TickerProvider` |

You have to use your stateful object as the `vsync` by adding `SingleTickerProviderStateMixin` or `TickerProviderStateMixin` to the class definition

Animations can be done on `Tweenable` by setting the `Tweenable` value to an animated function

When any animation does not end before initializing another animation, the previous animation is stopped and the current animation continues from where the old on stopped to bring a smooth animation experience

Example
```dart
x = withTiming(...)
x = withSpring(...)
x = withSequence(...)
x = 45.0 // no animations done here

```
**Note**: if a `double` value to set with the `Tweenable`, no animation is triggered. The value is just jumped the destination.

# Using Tweenables
[Tweenable] can be used with [AnimatedBuilder].

To use [Tweenable] with [AnimationBuilder], you need a helper function `mergeTweenables` which you can pass the [Tweenable] which when changed the Widget will rebuild

i.e
```dart
// initialization
var x = 10.asTweenable();
var x = 12.asTweenable();

// Usage

AnimatedBuilder(
  animation: mergeTweenables([x,y])
  child: ...
  builder: ...
)
// the widget will rebuild anytime the values of `x` and `y` changed
```

# Interpolation
Maps an input value within a range to an output value within a range. Also supports different types of extrapolation for when the value falls outside the range and mapping to strings.
Interpolation is made as an extension on `num` and `Tweenable`.
```dart
var val = 50;
// or
var val = 50.asTweenable(this);
// usage
var opacity = val.interpolate<double>(
  [20, 100] // input range
  [0,1] // output range
  Extrapolate.EXTEND, // extrapolation
  Extrapolate.EXTEND, // left Extrapolation
);

// COLOR INTERPOLATION
var color = val.interpolate<Color>(
  [20, 10],
  [Colors.red, Colors.green],
)
// The extrapolation in Color interpolation is fixed to Extrapolate.CLAMP even if specified
```
The third parameter is the is the `right` extrapolation and the last parameter is the `left` extrapolation. If the left extrapolation is the specified the right extrapolation is used for the left extrapolation, and if any of the extrapolations is not specified, the default `Extrapolate.EXTEND` is used for both the left and the right.
In Color Interpolation the extrapolation is fixed to `Extrapolate.CLAMP` even if specified



# Helper nodes

```dart
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
  range(int stop, {int start: 0, int step: 1});
```