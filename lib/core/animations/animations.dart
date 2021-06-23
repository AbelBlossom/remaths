// the animated value implemetation developent

import 'package:flutter/widgets.dart';
import 'package:remaths/core/animations/spring.dart';

const double _kDamping = 20;
const double _kStiffness = 180;
const double _kMass = 1.0;
const double _kVelocity = 0.0;
const Duration _kDuration = Duration(milliseconds: 300);

/// creates a listenable value to listen to animations
class AnimatedValue {
  double _value;
  final TickerProvider vsyc;
  AnimationController? _controller;
  late ValueNotifier<double> _notifier;

  AnimatedValue(this._value, {required this.vsyc}) {
    _notifier = ValueNotifier<double>(_value);
  }

  /// the value of the animation
  double get value {
    return _notifier.value;
  }

  ///
  ValueNotifier<double> get listenable {
    return _notifier;
  }

  set value(double value) {
    if (_controller != null) {
      if (_controller!.isAnimating) {
        _controller!.stop();
      }
    }
    _notifier.value = value;
  }

  /// Starts a spring-based animation.
  ///
  /// [toValue] is the target value at which the spring should settle
  withSpring(
    double toValue, {
    Duration duration = _kDuration,
    double damping = _kDamping,
    double stiffness = _kStiffness,
    double mass = _kMass,
    double velocity = _kVelocity,
  }) {
    _controller = AnimationController(vsync: vsyc, duration: duration);
    var _tween = Tween<double>(begin: value, end: toValue).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Spring(7),
      ),
    );
    _tween.addListener(() {
      _notifier.value = _tween.value;
    });
    _controller!.forward();
  }

  /// Starts a time based animation.
  /// [toValue] is the target value at which the animation should conclude
  /// It also takes the [duration] and [Curve] as the animation settings
  withTiming(
    double toValue, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeIn,
  }) {
    _controller = AnimationController(vsync: vsyc, duration: duration);
    var _tween = Tween<double>(begin: value, end: toValue).animate(
      CurvedAnimation(parent: _controller!, curve: curve),
    );
    _tween.addListener(() {
      _notifier.value = _tween.value;
    });
    _controller!.forward();
  }
}

/// runs a spring animation with more than one [AnimatedValue]
///
/// its take [values] and [destination] arguments that represents the AnimatedValue and where the animation which end *respectively*
///
/// *Example*
///
/// ```dart
/// springAll([x, y],[200, 30], {...springSettings} )
/// ```
///
/// The code run a pring animation for AnimatedValue `x` to `200` and `y` to `30` _respectively_
///
/// *Note*: This function take the spring animation settings as named parameters
void springAll(
  List<AnimatedValue> values,
  List<double> destination, {
  Duration duration = _kDuration,
  double damping = _kDamping,
  double stiffness = _kStiffness,
  double mass = _kMass,
  double velocity = _kVelocity,
}) {
  assert(values.length == destination.length);
  for (var i = 0; i < values.length; i++) {
    values[i].withSpring(
      destination[i],
      damping: damping,
      duration: duration,
      stiffness: stiffness,
      mass: mass,
      velocity: velocity,
    );
  }
}

/// runs a time based animation with more than one [AnimatedValue]
///
/// its take [values] and [destination] arguments that represents the AnimatedValue and where the animation which end *respectively*
///
/// *Example*
///
/// ```dart
/// animateAll([x, y],[200, 30], {...animationSettings})
/// ```
///
/// The code runs a time animation for AnimatedValue `x` to `200` and `y` to `30`
/// *Note*: This function take the animation settings as named parameters
void animateAll(
  List<AnimatedValue> values,
  List<double> destination, {
  Duration duration = _kDuration,
  Curve curve = Curves.easeIn,
}) {
  assert(values.length == destination.length);
  for (var i = 0; i < values.length; i++) {
    values[i].withTiming(destination[i], curve: curve, duration: duration);
  }
}
