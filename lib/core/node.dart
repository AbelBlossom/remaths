import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remaths/core/animations/spring.dart';

typedef void CallWith(Node node);

const double _kDamping = 20;
const double _kStiffness = 180;
const double _kMass = 1.0;
const double _kVelocity = 0.0;
const int _kDuration = 300;

class Node {
  double? _prev;
  double _val;
  late ValueNotifier<double> _notifier;
  late ValueNotifier<AnimationStatus?> _status;
  // AnimationStatus? _status;
  AnimationController? _currentController;
  final TickerProvider vsync;

  Node(this._val, {required this.vsync}) {
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

  set status(AnimationStatus? status) {
    _status.value = status;
  }

  AnimationStatus? get status {
    return _status.value;
  }

  get onStatusChanged {
    return _status.addListener;
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

  ValueNotifier get notifier {
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
}

void _timing(
  Node node,
  double toValue, {
  required int duration,
  required Curve curve,
  int? delay,
  void Function()? onComplete,
}) {
  var _controller = AnimationController(
      vsync: node.vsync, duration: Duration(milliseconds: duration));
  var _tween =
      Tween<double>(begin: node.value.toDouble(), end: toValue.toDouble())
          .animate(
    CurvedAnimation(parent: _controller, curve: curve),
  );
  node._controller = _controller;
  _controller.addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      if (onComplete != null) {
        onComplete();
      }
    }
    node.status = status;
  });
  _tween.addListener(() {
    node._setValue(_tween.value);
  });
  if (delay == null) {
    _controller.forward();
  } else {
    Future.delayed(Duration(milliseconds: delay), () {
      _controller.forward();
    });
  }
}

void _spring(
  Node node,
  double toValue, {
  required int duration,
  required double damping,
  required double stiffness,
  required double mass,
  required double velocity,
  void Function()? onComplete,
  int? delay,
}) {
  var _controller = AnimationController(
      vsync: node.vsync, duration: Duration(milliseconds: duration));
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
    if (status == AnimationStatus.completed) {
      if (onComplete != null) {
        onComplete();
      }
    }
    node.status = status;
  });
  _tween.addListener(() {
    node._setValue(_tween.value);
  });

  if (delay == null) {
    _controller.forward();
  } else {
    Future.delayed(Duration(milliseconds: delay), () {
      _controller.forward();
    });
  }
}

CallWith withTiming(
  double toValue, {
  int duration = _kDuration,
  Curve curve = Curves.easeIn,
  void Function()? onComplete,
  int? delay,
}) {
  return (Node node) {
    _timing(
      node,
      toValue,
      duration: duration,
      curve: curve,
      onComplete: onComplete,
      delay: delay,
    );
  };
}

CallWith withSpring(
  double toValue, {
  int duration = _kDuration,
  double damping = _kDamping,
  double stiffness = _kStiffness,
  double mass = _kMass,
  double velocity = _kVelocity,
  int? delay,
  void Function()? onComplete,
}) {
  return (Node node) {
    _spring(
      node,
      toValue,
      duration: duration,
      damping: damping,
      stiffness: stiffness,
      mass: mass,
      velocity: velocity,
      delay: delay,
      onComplete: onComplete,
    );
  };
}

CallWith withSeqence(List<dynamic> list) {
  return (Node node) {
    var len = list.length - 1;
    print(list.map((e) {
      return e.runtimeType;
    }).toList());
    runAnimation(int index) {
      if (index > len) return null;
      var val = list[index];

      if (val is CallWith) {
        node.value = val;
        node._currentController?.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            return runAnimation(index + 1);
          }
        });
      } else {
        print('finised $index');
        node.value = val;
        return runAnimation(index + 1);
      }
    }

    runAnimation(0);
  };
}
