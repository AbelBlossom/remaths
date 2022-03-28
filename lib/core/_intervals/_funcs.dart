part of remaths;

abstract class _AnimationFunctions {
  static _runAllWithTiming(
    List<_InternalShared> animatables,
    List<double> destinations, {
    int? duration,
    Curve? curve,
    int? delay,
    void Function()? onComplete,
  }) {
    for (var i = 0; i < animatables.length; i++) {
      animatables[i].value = _AnimationFunctions._withTiming(
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

  static _runAllWithSpring(
    List<_InternalShared> animatables,
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
      animatables[i].value = _AnimationFunctions._withSpring(
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

  static void _timing(
    _InternalShared node,
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

  static void _spring(
    _InternalShared node,
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
        curve: _Spring.custom(
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

  static CallWith _runSeqence(List<dynamic> animations) {
    return (_InternalShared node) {
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

  static CallWith _withSpring(
    double toValue, {
    int? duration,
    double? damping,
    double? stiffness,
    double? mass,
    double? velocity,
    int? delay,
    void Function()? onComplete,
  }) {
    return (_InternalShared node) {
      _AnimationFunctions._spring(
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

  static CallWith _withTiming(
    double toValue, {
    int? duration,
    Curve? curve,
    void Function()? onComplete,
    int? delay,
  }) {
    return (_InternalShared node) {
      _AnimationFunctions._timing(
        node,
        toValue,
        duration: duration ?? _kDuration,
        curve: curve ?? Curves.easeIn,
        onComplete: onComplete,
        delay: delay,
      );
    };
  }

  static Listenable _mergeTweenables(List<_InternalShared> values) =>
      Listenable.merge(values.map((e) => e.notifier).toList());
}
