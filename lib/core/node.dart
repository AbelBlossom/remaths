import 'package:flutter/material.dart';
import 'package:remaths/core/animations/spring.dart';

typedef void CallWith(Node node);

const double _kDamping = 20;
const double _kStiffness = 180;
const double _kMass = 1.0;
const double _kVelocity = 0.0;
const Duration _kDuration = Duration(milliseconds: 300);

class Node {
  double? _prev;
  double _val;
  late ValueNotifier<double> _notifier;
  AnimationStatus? _status;
  AnimationController? _currentController;
  final TickerProvider vsync;

  Node(this._val, {required this.vsync}) {
    _notifier = ValueNotifier(_val);
  }

  addEventListener(void Function(double value) callback) {
    _notifier.addListener(() {
      callback(_notifier.value);
    });
  }

  double get value {
    return _val;
  }

  set value(dynamic val) {
    if (val is CallWith) {
      val(this);
    }
    if (val is double) {
      _prev = _val;
      _val = val;
      _notifier.value = val;
    }
  }

  ValueNotifier get notifier {
    return _notifier;
  }

  dispose() {
    return this._notifier.dispose();
  }

  set _controller(AnimationController _controller) {
    _stopCurrent();
    _currentController = _controller;
  }

  _stopCurrent() {
    if (_currentController != null) {
      _currentController?.stop();
    }
  }
}

void _timing(
  Node node,
  double toValue, {
  required Duration duration,
  required Curve curve,
}) {
  var _controller = AnimationController(vsync: node.vsync, duration: duration);
  var _tween =
      Tween<double>(begin: node.value.toDouble(), end: toValue.toDouble())
          .animate(
    CurvedAnimation(parent: _controller, curve: curve),
  );
  node._controller = _controller;
  _controller.addStatusListener((status) {
    node._status = status;
  });
  _tween.addListener(() {
    node.value = _tween.value;
  });

  _controller.forward();
}

void _spring(
  Node node,
  double toValue, {
  required Duration duration,
  required double damping,
  required double stiffness,
  required double mass,
  required double velocity,
}) {
  var _controller = AnimationController(vsync: node.vsync, duration: duration);
  var _tween =
      Tween<double>(begin: node.value.toDouble(), end: toValue.toDouble())
          .animate(
    CurvedAnimation(
      parent: _controller,
      curve: Spring.custom(
        damping: damping,
        mass: mass,
        stiffness: stiffness,
        velocity: velocity,
      ),
    ),
  );
  node._controller = _controller;
  _controller.addStatusListener((status) {
    node._status = status;
  });
  _tween.addListener(() {
    node.value = _tween.value;
  });

  _controller.forward();
}

CallWith withTiming(double toValue,
    {Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeIn}) {
  return (Node node) {
    _timing(node, toValue, duration: duration, curve: curve);
  };
}

CallWith withSpring(
  double toValue, {
  Duration duration = _kDuration,
  double damping = _kDamping,
  double stiffness = _kStiffness,
  double mass = _kMass,
  double velocity = _kVelocity,
}) {
  return (Node node) {
    _spring(node, toValue,
        duration: duration,
        damping: damping,
        stiffness: stiffness,
        mass: mass,
        velocity: velocity);
  };
}
