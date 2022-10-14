part of v2.core;

///TODO: doc
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

  ///TODO: docs
  Listenable get animation => notifier;

  mergerWith(List<Listenable> animations) => Listenable.merge(animations);

  /// returns `true` if the value is animating
  bool get isAnimating => controller.isAnimating;

  //TODO: docs
  interpolate(List<dynamic> inputRange, List<dynamic> outputRange,
          {Extrapolate extrapolate = Extrapolate.extend,
          Extrapolate? rightExtrapolate}) =>
      _interpolate(_val, inputRange, outputRange,
          extrapolate: extrapolate, rightExtrapolate: rightExtrapolate);

  //TODO: docs
  interpolateColors(List<dynamic> inputRange, List<Color> outputRange) =>
      _interpolateColor(_val, inputRange, outputRange);

  //TODO: docs
  withSpring(
    double toValue, {
    int duration = _kDuration,
    double damping = _kDamping,
    double stiffness = _kStiffness,
    double mass = _kMass,
    double velocity = _kVelocity,
    void Function()? onComplete,
    int? delay,
  }) =>
      value = springAnimation(
        toValue,
        damping: damping,
        delay: delay,
        duration: duration,
        mass: mass,
        onComplete: onComplete,
        stiffness: stiffness,
        velocity: velocity,
      );

  // TODO: doc
  withTiming(
    double toValue, {
    int duration = _kDuration,
    Curve curve = Curves.easeIn,
    int? delay,
    void Function()? onComplete,
    num? from,
  }) =>
      value = timingAnimation(
        toValue,
        curve: curve,
        delay: delay,
        duration: duration,
        from: from,
        onComplete: onComplete,
      );

  //TODO: doc
  withSequence(List<Node> animations, {void Function()? onComplete}) =>
      sequenceAnimation(animations, onComplete: onComplete);
}

///TODO: doc
const withTiming = timingAnimation;

///TODO: doc
const withSpring = springAnimation;

///TODO: doc
const withSequence = sequenceAnimation;

///TODO: doc
const withRepeat = repeatAnimation;

///TODO: doc
const withDelay = delayAnimation;

///TODO: doc
const interpolate = _interpolate;

///TODO: doc
const interpolateColor = _interpolateColor;
