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
  ///
  double get value;

  set value(dynamic val);

  /// returns the current Animation Status
  AnimationStatus? get status;

  /// the [ValueNotifier] of the animation value
  ValueNotifier<double> get notifier;

  double interpolate(inputRange, outputRange,
      [Extrapolate extrapolate = Extrapolate.EXTEND, Extrapolate? right]);

  dispose();
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

abstract class N {}

extension TweenableExtension on num {
  asTweenable(TickerProvider vsync) {
    return Tweenable(this.toDouble(), vsync: vsync);
  }
}

const mergeTweenables = _AnimationFunctions._mergeTweenables;

/// Maps an input value within a range to an output value within a range.
/// Also supports different types of extrapolation for when the value falls outside the range and mapping to strings.
/// For example, if you wanted to animate a rotation you could do:
/// ```dart
/// interpolate(value, { inputRange: [0, 1], outputRange: [0, 360] }),
/// ```
const interpolate = _internalInterpolate;

/// Maps an input value within a range to an output value within a color range.
/// Example:
/// ```dart
/// interpolateColors(value,  {
///    inputRange:  [0, 1],
///    outputColorRange:  [Colors.red, Colors.green],
/// })
/// ```
const interpolateColors = _internalInterpolateColors;
