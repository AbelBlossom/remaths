part of remaths;

typedef void Node(SharedValue node);
typedef void AnimationListener();
// const double _kDamping = 20;
// const double _kStiffness = 180;
// const double _kMass = 1.0;
// const double _kVelocity = 0.0;
// const int _kDuration = 300;

class SharedValue {
  double? _prev;
  double _val;
  late ValueNotifier<double> _notifier;
  late ValueNotifier<AnimationStatus?> _status;
  late AnimationController controller;
  final TickerProvider vsync;
  bool _sequenceLocked = false;

  /// This value is used by sequence animation to know whether
  /// the lock is free to run the next animation
  bool _lock = false;

  late _AnimationInfo meta;

  SharedValue(this._val, {required this.vsync}) {
    _notifier = ValueNotifier(_val);
    _status = ValueNotifier(null);
    controller = AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: _kDuration),
    );
    meta = _AnimationInfo(
        curve: Curves.linear, duration: _kDuration, from: 0.0, to: 0.0);
  }

  resetController(int? duration) {
    //FIXME: find a performant way then disposing contollers and creating them
    _stopCurrent();
    controller.dispose();
    controller = AnimationController(
      vsync: vsync,
      duration: Duration(
        milliseconds: duration ?? _kDuration,
      ),
    );
  }

  setAnimation(Animation<double> animation, [void Function()? onComplete]) {
    meta.removeListener();
    meta.animation = animation;
    meta.listener = () => _setValue(animation.value);
    meta.animation?.addStatusListener((status) {
      _status.value = status;
      if (status == AnimationStatus.completed) {
        if (onComplete != null) {
          onComplete();
        }
        if (meta.hasCompleteLister) {
          meta.completeListener!();
        }
      }
    });
    meta.animation!.addListener(meta.listener!);
  }

  double get value => _val;

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
  AnimationStatus? get status => _status.value;

  set value(dynamic val) {
    assert(val is Node || num.tryParse(val.toString()) != null);
    if (_sequenceLocked) {}
    _sequenceLocked = false;

    val is Node ? val(this) : _setValue(val);
  }

  get diff {
    if (_prev != null) {
      return _val - _prev!;
    }
    return 0;
  }

  _setValue(double val) {
    _prev = _val;
    _val = val.toDouble();
    _notifier.value = _val;
  }

  ValueNotifier<double> get notifier => _notifier;

  dispose() {
    _stopCurrent();
    controller.dispose();
    _notifier.dispose();
  }

  _stopCurrent() {
    controller.stop();
  }

  T interpolate<T>(List<double> inputRange, List<T> outputRange,
      [Extrapolate extrapolate = Extrapolate.EXTEND, Extrapolate? right]) {
    return _interpolateAll<T>(
      _val,
      inputRange,
      outputRange,
      extrapolate,
      right,
    );
  }
}
