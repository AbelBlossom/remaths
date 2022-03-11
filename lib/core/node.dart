part of remaths;

typedef void CallWith(SharedValue node);

const double _kDamping = 20;
const double _kStiffness = 180;
const double _kMass = 1.0;
const double _kVelocity = 0.0;
const int _kDuration = 300;

/// Creates an `animatable` value which can be animated with helper functions
/// like [withTiming], [withSpring], [withSeqence] ...
///
/// You need [TickerProvider] in order to anitialize [SharedValue] just like in
/// [AnimationController].
///
/// Example
/// ```dart
/// ....
/// SharedValue x = SharedValue(0.0, vsync: this)
/// ...
/// x = withTiming(...)
/// x.value = withSpring(...)
/// x.value = withSequence(...)
/// x.value = 45.0 // no animations done here
///
/// ```
///
/// When the value of `x` is set to a [double] (`45.0`), it stops all the
/// animations and set the position of the [SharedValue] to the provided value
class SharedValue {
  double? _prev;
  double _val;
  late ValueNotifier<double> _notifier;
  late ValueNotifier<AnimationStatus?> _status;
  // AnimationStatus? _status;
  AnimationController? _currentController;
  final TickerProvider vsync;

  SharedValue(this._val, {required this.vsync}) {
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

  /// return the status of the curently Runing Animation
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
  SharedValue node,
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
  SharedValue node,
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

/// Starts a Curve animation on the [SharedValue] to the [toValue]
///
/// Example
/// ```dart
/// x = withTiming(double toValue, {
///     double toValue, {
///   int duration, // duration of the animation in millisecons
///   Curve curve // default [Curves.easeIn],
///   int? delay,
///   void Function()? onComplete, // calback after the animation is complete
/// })
/// ```
CallWith withTiming(
  double toValue, {
  int? duration,
  Curve? curve,
  void Function()? onComplete,
  int? delay,
}) {
  return (SharedValue node) {
    _timing(
      node,
      toValue,
      duration: duration ?? _kDuration,
      curve: curve ?? Curves.easeIn,
      onComplete: onComplete,
      delay: delay,
    );
  };
}

/// Starts a spring stimulation on the [SharedValue] to the [toValue]
///
/// Example
///  ```dart
///    SharedValue x = withSpring(toValue, {
//     int  duration // duration the animation will run,
///     double  damping,
///     double  stiffness,
///     double  mass,
///     double  velocity,
///     int?  delay,
///     void  Function()?  onComplete // callback after the animation is complete,
///     })
/// ```
CallWith withSpring(
  double toValue, {
  int? duration,
  double? damping,
  double? stiffness,
  double? mass,
  double? velocity,
  int? delay,
  void Function()? onComplete,
}) {
  return (SharedValue node) {
    _spring(
      node,
      toValue,
      duration: duration ?? _kDuration,
      damping: damping ?? _kDamping,
      stiffness: stiffness ?? _kStiffness,
      mass: mass ?? _kMass,
      velocity: velocity ?? _kVelocity,
      delay: delay,
      onComplete: onComplete,
    );
  };
}

/// Starts theprovided animations sequencially, i.e The next animation starts
/// immediately after the other stops. This animations can be [withTiming],
/// [withSpring], or a [double]. if a [double] is provided, there is no
/// animation in the values the value just jumps to the position.
///
/// Example
/// ```dart
///  x = withSequence([withTiming(...),6.0,withSpring(...),])
/// ```
CallWith withSeqence(List<dynamic> animations) {
  return (SharedValue node) {
    var len = animations.length - 1;
    print(animations.map((e) {
      return e.runtimeType;
    }).toList());
    runAnimation(int index) {
      if (index > len) return null;
      var val = animations[index];

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

/// Starts all the [animatables] with the [withSpring] animation to the
/// corresponding [destinations].
///
/// Examples
/// ```dart
///   runAllWithSpring([x,y],[40, 50])
/// ```
/// This code will animate `x` to `40` and `y` to `50` with spring stimulation.
/// Other parameters of the [withSpring] function can be passed as
/// named aguments
runAllWithSpring(
  List<SharedValue> animatables,
  List<double> destinations, {
  int? duration,
  double? damping,
  double? stiffness,
  double? mass,
  double? velocity,
  int? delay,
  void Function()? onComplete,
}) async {
  assert(animatables.length == destinations.length, '');
  print("here");

  for (var i = 0; i < animatables.length; i++) {
    animatables[i].value = withSpring(
      destinations[i],
      duration: duration,
      damping: damping,
      stiffness: stiffness,
      velocity: velocity,
      mass: mass,
      delay: delay,
      onComplete: () {
        if (i == animatables.length - 1) {
          onComplete?.call();
        }
      },
    );
  }
}

/// Starts all the [animatables] with the [withTiming] animation to the
/// corresponding [destinations].
///
/// Examples
/// ```dart
///   runAllWithTiming([x,y],[40, 50])
/// ```
/// This code will animate `x` to `40` and `y` to `50` with Curve animation.
/// The [Curve] and other parameters of the animation can provided as named arguments
runAllWithTiming(
  List<SharedValue> animatables,
  List<double> destinations, {
  int? duration,
  Curve? curve,
  int? delay,
  void Function()? onComplete,
}) {
  for (var i = 0; i < animatables.length; i++) {
    animatables[i].value = withTiming(
      destinations[i],
      duration: duration,
      curve: curve,
      delay: delay,
      onComplete: () {
        if (i == animatables.length - 1) {
          onComplete?.call();
        }
      },
    );
  }
}
