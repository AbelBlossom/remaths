part of remaths;
// import 'package:flutter/widgets.dart';
// import 'package:remaths/remaths.dart';

typedef void CallWith(_InternalShared node);

const double _kDamping = 20;
const double _kStiffness = 180;
const double _kMass = 1.0;
const double _kVelocity = 0.0;
const int _kDuration = 300;

abstract class _InternalShared {
  double? _prev;
  double _val;
  late ValueNotifier<double> _notifier;
  late ValueNotifier<AnimationStatus?> _status;
  // AnimationStatus? _status;
  AnimationController? _currentController;
  final TickerProvider vsync;

  _InternalShared(this._val, {required this.vsync}) {
    _notifier = ValueNotifier(_val);
    _status = ValueNotifier(null);
  }

  addEventListener(void Function(double value) callback) {
    _notifier.addListener(() {
      callback(_notifier.value);
    });
  }

  double get value {
    return _val;
  }

  double operator +(dynamic other) =>
      value + cond(other is _InternalShared, other.value, other);

  double operator -(dynamic other) =>
      value - cond(other is _InternalShared, other.value, other);

  double operator /(dynamic other) =>
      value / cond(other is _InternalShared, other.value, other);

  double operator *(dynamic other) =>
      value * cond(other is _InternalShared, other.value, other);

  call(dynamic _value) {
    value = _value;
  }

  set status(AnimationStatus? status) {
    _status.value = status;
  }

  /// return the status of the currently running Animation
  AnimationStatus? get status {
    return _status.value;
  }

  set value(dynamic val) {
    assert(val is CallWith || num.tryParse(val.toString()) != null);
    if (val is CallWith) {
      val(this);
    } else {
      if (_currentController != null) {
        if (_currentController?.isAnimating == true) {
          _currentController?.stop();
        }
      }
      _prev = _val;
      _val = val.toDouble();
      _notifier.value = val.toDouble();
    }
  }

  _setValue(num val) {
    _prev = _val;
    _val = val.toDouble();
    _notifier.value = val.toDouble();
  }

  ValueNotifier<double> get notifier {
    return _notifier;
  }

  dispose() {
    _stopCurrent();
    return this._notifier.dispose();
  }

  set _controller(AnimationController _controller) {
    _stopCurrent();
    _currentController = _controller;
  }

  _stopCurrent() {
    if (_currentController != null) {
      _currentController?.stop();
      _currentController?.dispose();
    }
  }

  T interpolate<T>(List<num> inputRange, List<T> outputRange,
      [Extrapolate extrapolate = Extrapolate.EXTEND, Extrapolate? right]) {
    return _interpolateAll<T>(
        _val, inputRange, outputRange, extrapolate, right);
  }
}
