part of remaths;

/// Creates an [Tweenable] value which can be animated with helper functions
/// like [withTiming], [withSpring], [withSequence] ...
///
/// You need [TickerProvider] in order to initialize [Tweenable] just like in
/// [AnimationController].
///
/// Example
/// ```dart
/// ....
/// Tweenable x = Tweenable(0.0, vsync: this)
/// ...
/// x = withTiming(...)
/// x.value = withSpring(...)
/// x.value = withSequence(...)
/// x.value = 45.0 // no animations done here
///
/// ```
///
/// When the value of `x` is set to a [double] (`45.0`), it stops all the
/// animations and set the position of the [Tweenable] to the provided value
class Tweenable extends _InternalShared {
  Tweenable(double _val, {required TickerProvider vsync})
      : super(_val, vsync: vsync);

  addEventListener(void Function(double value) callback);

  /// get the current animated Value
  double get value;

  set value(dynamic val);

  /// returns the current Animation Status
  AnimationStatus? get status;

  /// the [ValueNotifier] of the animation value
  ValueNotifier<double> get notifier;

  /// Maps an input value within a range to an output value within a range.
  ///
  /// Also supports different types of extrapolation for when the value falls
  /// outside the range and mapping to strings.
  /// Usage
  /// ```dart
  /// var opacity = val.interpolate(
  ///   [1, 100], // input range
  ///   [0, 1],  // output range
  ///   Extrapolate.EXTEND, // right Extrapolation
  ///   Extrapolate.EXTEND, // left Extrapolation
  /// )
  /// ```
  /// The third parameter is the is the `right` extrapolation and the last parameter is the `left` extrapolation.
  ///
  /// If the left extrapolation is the specified the right extrapolation is used
  /// for the left extrapolation, and if any of the extrapolations is not specified, the default `Extrapolate.EXTEND` is used for both the left and the right.
  ///
  /// In Color Interpolation the extrapolation is fixed to `Extrapolate.CLAMP` even if specified
  ///
  /// Color Interpolation Example
  /// ```dart
  /// var opacity = val.interpolate(
  ///   [1, 100], // input range
  ///   [Colors.red, Colors.green],  // output range
  /// )
  /// ```
  T interpolate<T>(List<double> inputRange, List<T> outputRange,
      [Extrapolate extrapolate = Extrapolate.EXTEND, Extrapolate? right]);

  dispose();

  static _init(double value, TickerProvider vsync) =>
      Tweenable(value, vsync: vsync);
}

/// Starts a Curve animation on the [Tweenable] to the [toValue]
///
/// Example
/// ```dart
/// x = withTiming(double toValue, {
///     double toValue, {
///   int duration, // duration of the animation in milliseconds
///   Curve curve // default [Curves.easeIn],
///   int? delay,
///   void Function()? onComplete, // callback after the animation is complete
/// })
/// ```
const withTiming = _AnimationFunctions._withTiming;

/// Starts a spring stimulation on the [Tweenable] to the [toValue]
///
/// Example
///  ```dart
///    Tweenable x = withSpring(toValue, {
//     int  duration // duration the animation will run,
///     double  damping,
///     double  stiffness,
///     double  mass,
///     double  velocity,
///     int?  delay,
///     void  Function()?  onComplete // callback after the animation is complete,
///     })
/// ```
const withSpring = _AnimationFunctions._withSpring;

/// Starts the provided animations sequentially, i.e The next animation starts
/// immediately after the other stops. This animations can be [withTiming],
/// [withSpring], or a [double]. if a [double] is provided, there is no
/// animation in the values the value just jumps to the position.
///
/// Example
/// ```dart
///  x = withSequence([withTiming(...),6.0,withSpring(...),])
/// ```
CallWith withSequence(List<dynamic> animations) =>
    _AnimationFunctions._runSequence(animations);

/// Starts all the [Tweenable] with the [withSpring] animation to the
/// corresponding [destinations].
///
/// Examples
/// ```dart
///   runAllWithSpring([x,y],[40, 50])
/// ```
/// This code will animate `x` to `40` and `y` to `50` with spring stimulation.
/// Other parameters of the [withSpring] function can be passed as
/// named augments
const runAllWithSpring = _AnimationFunctions._runAllWithSpring;

/// Starts all the [Tweenable] with the [withTiming] animation to the
/// corresponding [destinations].
///
/// Examples
/// ```dart
///   runAllWithTiming([x,y],[40, 50])
/// ```
/// This code will animate `x` to `40` and `y` to `50` with Curve animation.
/// The [Curve] and other parameters of the animation can provided as named arguments
const runAllWithTiming = _AnimationFunctions._runAllWithTiming;

extension TweenableExtension on num {
  /// Initialize a Tweenable with [TickerProvider]
  asTweenable(TickerProvider vsync) {
    return Tweenable._init(this.toDouble(), vsync);
  }

  /// Maps an input value within a range to an output value within a range.
  ///
  /// Also supports different types of extrapolation for when the value falls
  /// outside the range and mapping to strings.
  /// Usage
  /// ```dart
  /// var opacity = val.interpolate(
  ///   [1, 100], // input range
  ///   [0, 1],  // output range
  ///   Extrapolate.EXTEND, // right Extrapolation
  ///   Extrapolate.EXTEND, // left Extrapolation
  /// )
  /// ```
  /// The third parameter is the is the `right` extrapolation and the last parameter is the `left` extrapolation.
  ///
  /// If the left extrapolation is the specified the right extrapolation is used
  /// for the left extrapolation, and if any of the extrapolations is not specified, the default `Extrapolate.EXTEND` is used for both the left and the right.
  ///
  /// In Color Interpolation the extrapolation is fixed to `Extrapolate.CLAMP` even if specified
  ///
  /// Color Interpolation Example
  /// ```dart
  /// var opacity = val.interpolate(
  ///   [1, 100], // input range
  ///   [Colors.red, Colors.green],  // output range
  /// )
  /// ```
  T interpolate<T>(List<double> inputRange, List<T> outputRange,
      [Extrapolate extrapolate = Extrapolate.EXTEND, Extrapolate? right]) {
    return _interpolateAll<T>(
        this.toDouble(), inputRange, outputRange, extrapolate, right);
  }
}

extension OffsetExtension on Offset {
  Offset interpolate(List<Offset> inputRange, List<Offset> outputRange,
      [Extrapolate extrapolate = Extrapolate.EXTEND, Extrapolate? right]) {
    return _interpolateOffset(
        this, inputRange, outputRange, extrapolate, right);
  }
}

/// Merge List of Tweenables into one [Listenable] that can be used as [AnimatedWidget] animation
const mergeTweenables = _AnimationFunctions._mergeTweenables;

U interpolate<T, U>(T value, List<T> inputRange, List<U> outputRange,
    [Extrapolate extrapolate = Extrapolate.EXTEND, Extrapolate? right]) {
  assert(
      outputRange.first is Offset ||
          outputRange.first is Color ||
          outputRange.first is double,
      "outputRange must be a list of Offset, Color or double");
  assert(value is double || value is Offset,
      "value must be a double or an Offset");
  assert(value is Offset && outputRange.first is Offset,
      "if value is Offset the outputRange must be a list of Offset");

  if (value is Offset) {
    return _interpolateOffset(value, inputRange as List<Offset>,
        outputRange as List<Offset>, extrapolate, right) as U;
  }
  return _interpolateAll<U>(
      value as num, inputRange as List<num>, outputRange, extrapolate, right);
}
