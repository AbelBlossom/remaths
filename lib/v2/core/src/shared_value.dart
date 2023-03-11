part of v2.core;

/// animation value
class SharedValue extends Shared {
  SharedValue(super.val, {required super.vsync});

  /// get the current animation value
  @override
  get value;

  /// start an animation or directly change the animation value
  ///
  /// If the animation is an animation function, the animation value will
  /// animate with the function passed
  ///
  /// Example:
  /// ```
  /// opacity.value = withTiming(1);
  /// ```
  /// This will animate the the `opacity` value from its current value to 1
  /// with timing animation
  ///
  /// ```dart
  /// opacity.value = 1;
  /// ```
  /// This will not run any animation on the opacity value
  @override
  set value(dynamic val);

  /// the value [Listenable] that can be passed to [AnimatedBuilder]
  /// ```dart
  ///   AnimatedBuilder(
  ///     animation: opacity.animation,
  ///     ...
  ///   )
  /// ```
  Listenable get animation => notifier;

  /// merge animation [Listenable] with another [Listenable] <br>
  /// ```dart
  ///   AnimatedBuilder(
  ///     animation: value.mergeWith([opacity.animation]),
  ///     ...
  ///   )
  /// ```
  mergeWith(List<Listenable> animations) => Listenable.merge(animations);

  /// Whether the value is currently animating
  bool get isAnimating => controller.isAnimating;

  /// Interpolate the current value from to another value <br>
  /// similar to [interpolate] helper function
  interpolate(List<dynamic> inputRange, List<dynamic> outputRange,
          {Extrapolate extrapolate = Extrapolate.extend,
          Extrapolate? rightExtrapolate}) =>
      _interpolate(_val, inputRange, outputRange,
          extrapolate: extrapolate, rightExtrapolate: rightExtrapolate);

  /// interpolate the current value to a list of colors
  /// similar to [interpolateColor] helper function
  interpolateColor(List<dynamic> inputRange, List<Color> outputRange) =>
      _interpolateColor(_val, inputRange, outputRange);

  /// run spring animation of the current value <br>
  /// similar to [withSpring] helper function
  withSpring(
    double toValue, {
    int duration = _kDuration,
    double damping = _kDamping,
    double stiffness = _kStiffness,
    double mass = _kMass,
    double velocity = _kVelocity,
    void Function()? onComplete,
  }) =>
      value = springAnimation(
        toValue,
        damping: damping,
        duration: duration,
        mass: mass,
        onComplete: onComplete,
        stiffness: stiffness,
        velocity: velocity,
      );

  /// run timing animation of the current value <br>
  /// similar to [withTiming] helper function
  withTiming(
    double toValue, {
    int duration = _kDuration,
    Curve curve = Curves.easeIn,
    void Function()? onComplete,
    num? from,
  }) =>
      value = timingAnimation(
        toValue,
        curve: curve,
        duration: duration,
        from: from,
        onComplete: onComplete,
      );

  /// run a list of animations sequentially on the current value <br>
  /// similar to [withSequence] helper function
  withSequence(List<Node> animations, {void Function()? onComplete}) =>
      sequenceAnimation(animations, onComplete: onComplete);

  /// delay [animation] for some milliseconds before running <br>
  /// similar to [withDelay] helper function
  withDelay(Node animation, int duration) =>
      delayAnimation(animation, duration);
}

/// This is used to run a timing animation on a `SharedValue` <br>
/// ```dart
/// opacity.value = withTiming(0.0, duration:100, curve:Curves.easeInOut);
/// ```
const withTiming = timingAnimation;

/// This is used to animate `SharedValue` with `SpringSimulation` <br>
/// ```dart
/// width.value = withSpring(1.0, duration: 500);
/// ```
const withSpring = springAnimation;

/// This animation Function is used to run list of animations sequentially, i.e one after the other <br>
/// ```dart
/// width = withSequence(
///   [withTiming(20), withSpring(40)],
///   () => print("animation complete"),
/// )
/// ```
const withSequence = sequenceAnimation;

/// Repeat an animation for some number of times <br>
/// ```dart
/// width = withRepeat(withSpring(20.0), reps:2, reverse: false);
/// ```
const withRepeat = repeatAnimation;

/// Delay an animation before running

/// ```dart
/// // this delays the animation for 300ms before running
/// opacity.value = withDelay(withTiming(), 300)
/// ```
const withDelay = delayAnimation;

/// This is used to map a value from one range to the other. <br>
/// ```dart
/// var yOffset = interpolate(opacity, [0,1], [100,0])
/// ```
/// inputRange must be monotonically increasing <br>
/// Read More About Interpolation on [Wikipedia](https://en.wikipedia.org/wiki/Interpolation)
const interpolate = _interpolate;

/// This is used to map a value from range of number to range of colors. <br>
/// ```dart
/// Color color = interpolateColor(opacity, [0,1], [Colors.red, Colors.green])
/// ```
const interpolateColor = _interpolateColor;

/// This is used to map a value from range of number to range of colors. <br>
/// ```dart
/// Offset pos = interpolateColor(_offset, [Offset(0,0),Offset(10,10)], [Offset(12, 0), Offset(0,0)])
/// ```
/// > NOTE: When interpolating offsets when must ensure that both the dx and dy
/// > coordinates of the inputRange must be monotonically increasing
/// ```dart
///  // Input Ranges
///  [Offset(0,0), Offset(3,5)] // valid
///  [Offset(10,10), Offset(20, 5)] // invalid, `dy` coordinate is not monotonically increasing
///  [Offset(50,5), Offset(10, 20)] // invalid, `dx` coordinate is not monotonically increasing
/// ```
///
const interpolateOffset = _interpolateOffset;
